import Flutter
import Foundation
import Network
import os
import Security

/// iOS 直连 API。图片仍走 Dart 的 No-SNI（IP 字面量），不经过这里。
///
/// HTTP/3 必须带 SNI，而系统 DNS 又不能信，所以用 Network.framework 把 UDP 钉到
/// Cloudflare IP，TLS 服务器名仍是 pixiv 域名。URLSession 做不到这两件事同时成立。
/// 通道与 Android Cronet 相同：`artvier/pixiv_cronet`。
enum PixivQuicBridge {
  static func register(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "artvier/pixiv_cronet", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      if #available(iOS 15.0, *) {
        PixivQuicClient.shared.handle(call, result: result)
      } else if call.method == "cancel" {
        result(nil)
      } else {
        result(
          FlutterError(
            code: "CRONET",
            message: "HTTP/3 direct connect requires iOS 15 or later",
            details: nil))
      }
    }
  }
}

private struct H3Failure: LocalizedError {
  let message: String
  var errorDescription: String? { message }
}

private enum H3Outcome {
  case cancelled
  case timeout
  case failed(String)
}

@available(iOS 15.0, *)
private final class PixivQuicClient {
  static let shared = PixivQuicClient()
  static let log = Logger(subsystem: "org.augenblick.artvier", category: "PixivQuic")

  private let lock = NSLock()
  private var inflight: [String: PixivH3Call] = [:]

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "cancel":
      let id = (call.arguments as? [String: Any])?["id"] as? String ?? ""
      lock.lock()
      let request = inflight[id]
      lock.unlock()
      request?.cancel()
      result(nil)
    case "request":
      do {
        let request = try PixivH3Call(call: call, result: result)
        lock.lock()
        inflight[request.id] = request
        lock.unlock()
        request.start()
      } catch {
        result(FlutterError(code: "CRONET", message: error.localizedDescription, details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func remove(_ id: String) {
    lock.lock()
    inflight.removeValue(forKey: id)
    lock.unlock()
  }
}

@available(iOS 15.0, *)
private final class PixivH3Call {
  /// 与 HttpBaseOptions.cloudflareApiIp、PixivCronet.CF_IP_PRIMARY 保持一致。
  static let fallbackIP = "104.18.42.239"
  static let maxBody = 32 * 1024 * 1024
  static let allowedHosts: Set<String> = [
    "app-api.pixiv.net",
    "oauth.secure.pixiv.net",
    "www.pixiv.net",
    "www.pixivision.net",
  ]
  static let methodIndexes = [
    "CONNECT": 15, "DELETE": 16, "GET": 17, "HEAD": 18,
    "OPTIONS": 19, "POST": 20, "PUT": 21,
  ]
  static let skipRequestHeaders: Set<String> = [
    "accept-encoding",
    "connection",
    "content-length",
    "host",
    "keep-alive",
    "proxy-connection",
    "transfer-encoding",
    "upgrade",
  ]

  let id: String
  let queue: DispatchQueue
  let directIP: String
  let timeoutMs: Int
  let startedAt = Date()

  private var method: String
  private var url: URL
  private var headers: [String: String]
  private var body: Data?
  private var redirectsLeft = 5
  private var result: FlutterResult?
  private var timeoutWork: DispatchWorkItem?
  private var generation = 0
  private var stopped = false
  private var group: NWConnectionGroup?
  private var connections: [NWConnection] = []
  /// iOS 26+ 的 NetworkConnection。类型在旧系统上不存在，所以用 Any 持有。
  private var retainedModern: Any?
  private var closeModern: (() -> Void)?
  private var requestStream: NWConnection?
  private var streamsOpened = false
  private var prefaces = 0
  private var requestStreamReady = false
  private var requestSent = false
  private var receiving = false

  private var inbound = Data()
  private var inboundRead = 0
  private var framePhase = 0
  private var frameType: UInt64 = 0
  private var frameLength = 0
  private var frameGot = 0
  private var headerPayload = Data()
  private var responseBody = Data()
  private var status = 0
  private var sawFinalHeaders = false
  private var responseHeaders: [String: [String]] = [:]

  init(call: FlutterMethodCall, result: @escaping FlutterResult) throws {
    guard let args = call.arguments as? [String: Any] else {
      throw H3Failure(message: "Missing request arguments")
    }
    let id = args["id"] as? String ?? ""
    guard let urlString = args["url"] as? String, let url = URL(string: urlString) else {
      throw H3Failure(message: "Invalid URL")
    }
    guard url.scheme?.lowercased() == "https", url.port == nil || url.port == 443 else {
      throw H3Failure(message: "HTTP/3 direct connect only supports https:443")
    }
    guard let host = url.host?.lowercased(), Self.allowedHosts.contains(host) else {
      throw H3Failure(message: "HTTP/3 direct connect does not handle host: \(url.host ?? "")")
    }
    var timeoutMs = (args["timeoutMillis"] as? NSNumber)?.intValue ?? 30000
    if timeoutMs <= 0 { timeoutMs = 30000 }
    let requestedIP = args["directIp"] as? String ?? Self.fallbackIP
    self.id = id
    self.queue = DispatchQueue(label: "org.augenblick.artvier.pixiv-quic", qos: .userInitiated)
    self.directIP = Self.isIPv4(requestedIP) ? requestedIP : Self.fallbackIP
    self.timeoutMs = timeoutMs
    self.method = ((args["method"] as? String) ?? "GET").uppercased()
    self.url = url
    self.headers = Self.stringMap(args["headers"])
    if let typed = args["body"] as? FlutterStandardTypedData, !typed.data.isEmpty {
      self.body = typed.data
    } else {
      self.body = nil
    }
    self.result = result
  }

  func start() {
    let work = DispatchWorkItem { [weak self] in
      self?.complete(outcome: .timeout, payload: nil)
    }
    timeoutWork = work
    queue.asyncAfter(deadline: .now() + .milliseconds(timeoutMs), execute: work)
    queue.async { [weak self] in
      self?.connect()
    }
  }

  func cancel() {
    queue.async { [weak self] in
      self?.complete(outcome: .cancelled, payload: nil)
    }
  }

  private func connect() {
    if stopped { return }
    generation += 1
    let gen = generation
    guard let host = url.host?.lowercased(), Self.allowedHosts.contains(host) else {
      complete(outcome: .failed("HTTP/3 direct connect does not handle host: \(url.host ?? "")"), payload: nil)
      return
    }

    if #available(iOS 26.0, *) {
      connectUsingOpenStream(gen: gen, serverName: host)
      return
    }

    let options = NWProtocolQUIC.Options(alpn: ["h3"])
    // direction 是单条流的属性。写在连接上时，extract 出来的流会立刻失败，
    // 错误是 POSIX 50（ENETDOWN），看起来像网络断开。
    options.initialMaxStreamsBidirectional = 100
    options.initialMaxStreamsUnidirectional = 100
    options.initialMaxData = 16 * 1024 * 1024
    options.initialMaxStreamDataBidirectionalLocal = 6 * 1024 * 1024
    options.initialMaxStreamDataBidirectionalRemote = 6 * 1024 * 1024
    options.initialMaxStreamDataUnidirectional = 6 * 1024 * 1024
    let serverName = host
    serverName.withCString { name in
      sec_protocol_options_set_tls_server_name(options.securityProtocolOptions, name)
    }
    // 验证回调不要跑在连接队列上，同步 complete 会把握手卡死。
    let verifyQueue = DispatchQueue(label: "org.augenblick.artvier.pixiv-quic.tls")
    sec_protocol_options_set_verify_block(options.securityProtocolOptions, { _, trust, complete in
      let secTrust = sec_trust_copy_ref(trust).takeRetainedValue()
      let policy = SecPolicyCreateSSL(true, serverName as CFString)
      SecTrustSetPolicies(secTrust, policy)
      var error: CFError?
      let ok = SecTrustEvaluateWithError(secTrust, &error)
      if !ok {
        PixivQuicClient.log.error(
          "TLS verify failed \(serverName, privacy: .public) \(String(describing: error), privacy: .public)")
      }
      complete(ok)
    }, verifyQueue)

    let parameters = NWParameters(quic: options)
    parameters.preferNoProxies = true
    guard let address = IPv4Address(directIP) else {
      complete(outcome: .failed("Invalid direct connect IP: \(directIP)"), payload: nil)
      return
    }
    let endpoint = NWEndpoint.hostPort(host: .ipv4(address), port: 443)
    let connectionGroup = NWConnectionGroup(with: NWMultiplexGroup(to: endpoint), using: parameters)
    group = connectionGroup
    connectionGroup.stateUpdateHandler = { [weak self] state in
      guard let self, self.generation == gen, !self.stopped else { return }
      switch state {
      case .ready:
        if self.streamsOpened { return }
        self.streamsOpened = true
        PixivQuicClient.log.info(
          "QUIC ready \(self.directIP, privacy: .public) sni \(serverName, privacy: .public)")
        self.openStreams(gen: gen)
      case .waiting(let error):
        PixivQuicClient.log.error(
          "QUIC waiting \(String(describing: error), privacy: .public)")
      case .failed(let error):
        self.complete(outcome: .failed("QUIC connection failed: \(error)"), payload: nil)
      case .cancelled:
        self.complete(outcome: .cancelled, payload: nil)
      default:
        break
      }
    }
    connectionGroup.newConnectionHandler = { [weak self] connection in
      guard let self, self.generation == gen, !self.stopped else {
        connection.cancel()
        return
      }
      self.drain(connection, gen: gen)
    }
    connectionGroup.start(queue: queue)
  }

  /// iOS 26 上 NWConnectionGroup.extract 无法加入已建立的 QUIC 栈，流会立刻以 POSIX 50 失败。
  /// NetworkConnection.openStream 可以在同一条连接上打开 HTTP/3 流。
  @available(iOS 26.0, *)
  private func connectUsingOpenStream(gen: Int, serverName: String) {
    guard let address = IPv4Address(directIP) else {
      complete(outcome: .failed("Invalid direct connect IP: \(directIP)"), payload: nil)
      return
    }
    let endpoint = NWEndpoint.hostPort(host: .ipv4(address), port: 443)
    let connection = NetworkConnection<QUIC>(to: endpoint) {
      QUIC(alpn: ["h3"])
        .initialMaxBidirectionalStreams(100)
        .initialMaxUnidirectionalStreams(100)
        .initialMaxData(16 * 1024 * 1024)
        .initialMaxStreamDataBidirectionalLocal(6 * 1024 * 1024)
        .initialMaxStreamDataBidirectionalRemote(6 * 1024 * 1024)
        .initialMaxStreamDataUnidirectional(6 * 1024 * 1024)
    }
    if let quic = connection.parameters.defaultProtocolStack.transportProtocol as? NWProtocolQUIC.Options {
      serverName.withCString { name in
        sec_protocol_options_set_tls_server_name(quic.securityProtocolOptions, name)
      }
      let verifyQueue = DispatchQueue(label: "org.augenblick.artvier.pixiv-quic.tls")
      sec_protocol_options_set_verify_block(quic.securityProtocolOptions, { _, trust, complete in
        let secTrust = sec_trust_copy_ref(trust).takeRetainedValue()
        let policy = SecPolicyCreateSSL(true, serverName as CFString)
        SecTrustSetPolicies(secTrust, policy)
        var error: CFError?
        let ok = SecTrustEvaluateWithError(secTrust, &error)
        if !ok {
          PixivQuicClient.log.error(
            "TLS verify failed \(serverName, privacy: .public) \(String(describing: error), privacy: .public)")
        }
        complete(ok)
      }, verifyQueue)
    }
    connection.parameters.preferNoProxies = true
    retainedModern = connection
    closeModern = { [weak connection] in
      // reason 不能是 nil，系统会把空指针交给 strlen，直接 SIGSEGV。
      connection?.applicationError = NWProtocolQUIC.ApplicationError(code: 0, reason: "closed")
    }

    connection.onStateUpdate { [weak self] _, state in
      guard let self else { return }
      self.queue.async {
        guard self.generation == gen, !self.stopped else { return }
        switch state {
        case .ready:
          if self.streamsOpened { return }
          self.streamsOpened = true
          PixivQuicClient.log.info(
            "QUIC ready \(self.directIP, privacy: .public) sni \(serverName, privacy: .public)")
          self.openModernStreams(connection, gen: gen)
        case .waiting(let error):
          // 连接已经 ready 之后，系统仍可能报一次 POSIX 50。请求本身可以成功，不把它当成失败。
          PixivQuicClient.log.debug(
            "QUIC waiting \(String(describing: error), privacy: .public)")
        case .failed(let error):
          self.complete(outcome: .failed("QUIC connection failed: \(error)"), payload: nil)
        case .cancelled:
          self.complete(outcome: .cancelled, payload: nil)
        default:
          break
        }
      }
    }
    _ = connection.start()
    Task {
      do {
        try await connection.inboundStreams { stream in
          do {
            while true {
              let message = try await stream.receive(atLeast: 1, atMost: 64 * 1024)
              if message.metadata.endOfStream { return }
            }
          } catch {
            return
          }
        }
      } catch {
        return
      }
    }
  }

  @available(iOS 26.0, *)
  private func openModernStreams(_ connection: NetworkConnection<QUIC>, gen: Int) {
    let payload: Data
    do {
      payload = try encodeRequest()
    } catch {
      complete(outcome: .failed((error as? H3Failure)?.message ?? error.localizedDescription), payload: nil)
      return
    }
    Task {
      do {
        let control = try await connection.openStream(directionality: .unidirectional)
        let encoder = try await connection.openStream(directionality: .unidirectional)
        let decoder = try await connection.openStream(directionality: .unidirectional)
        try await control.send(Data([0x00, 0x04, 0x00]))
        try await encoder.send(Data([0x02]))
        try await decoder.send(Data([0x03]))
        let request = try await connection.openStream(directionality: .bidirectional)
        try await request.send(payload, endOfStream: true)
        try await self.receiveModern(request, gen: gen)
      } catch {
        self.queue.async {
          guard self.generation == gen, !self.stopped else { return }
          self.complete(outcome: .failed("QUIC stream failed: \(error)"), payload: nil)
        }
      }
    }
  }

  @available(iOS 26.0, *)
  private func receiveModern(_ request: QUIC.Stream<QUICStream>, gen: Int) async throws {
    while true {
      let message = try await request.receive(atLeast: 1, atMost: 64 * 1024)
      let data = message.content
      let ended = message.metadata.endOfStream
      try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
        self.queue.async {
          guard self.generation == gen, !self.stopped else {
            continuation.resume()
            return
          }
          if !data.isEmpty {
            self.inbound.append(data)
            do {
              try self.consumeFrames()
            } catch {
              continuation.resume(throwing: error)
              return
            }
          }
          if ended {
            self.finishStream()
          }
          continuation.resume()
        }
      }
      if ended { return }
    }
  }

  private func openStreams(gen: Int) {
    do {
      let control = try makeStream(unidirectional: true)
      let encoder = try makeStream(unidirectional: true)
      let decoder = try makeStream(unidirectional: true)
      let request = try makeStream(unidirectional: false)
      connections = [control, encoder, decoder, request]
      requestStream = request
      watchUni(control, preface: Data([0x00, 0x04, 0x00]), gen: gen)
      watchUni(encoder, preface: Data([0x02]), gen: gen)
      watchUni(decoder, preface: Data([0x03]), gen: gen)
      watchRequest(request, gen: gen)
      for connection in connections {
        connection.start(queue: queue)
      }
    } catch {
      let message = (error as? H3Failure)?.message ?? error.localizedDescription
      complete(outcome: .failed(message), payload: nil)
    }
  }

  /// 单向流要在 extract 时把 direction 设上。控制流、QPACK 编码器、解码器必须按这个顺序先打开。
  private func makeStream(unidirectional: Bool) throws -> NWConnection {
    guard let group else {
      throw H3Failure(message: "QUIC connection is gone")
    }
    // 必须带上和连接相同的 ALPN。空的 Options 无法加入已建立的 QUIC 协议栈，
    // 系统会报 could not find protocol to join，对外就是 POSIX 50。
    let options = NWProtocolQUIC.Options(alpn: ["h3"])
    options.direction = unidirectional ? .unidirectional : .bidirectional
    guard let connection = group.extract(connectionTo: nil, using: options) else {
      throw H3Failure(message: "Failed to open a QUIC stream")
    }
    return connection
  }

  private func watchUni(_ connection: NWConnection, preface: Data, gen: Int) {
    var sent = false
    connection.stateUpdateHandler = { [weak self] state in
      guard let self, self.generation == gen, !self.stopped else { return }
      switch state {
      case .ready:
        if sent { return }
        sent = true
        connection.send(content: preface, isComplete: false, completion: .contentProcessed { [weak self] error in
          guard let self, self.generation == gen, !self.stopped else { return }
          if let error {
            self.complete(outcome: .failed("QUIC control stream failed: \(error)"), payload: nil)
            return
          }
          self.prefaces += 1
          self.maybeSendRequest(gen: gen)
        })
      case .failed(let error):
        self.complete(outcome: .failed("QUIC stream failed: \(error)"), payload: nil)
      case .cancelled:
        self.complete(outcome: .cancelled, payload: nil)
      default:
        break
      }
    }
  }

  private func watchRequest(_ connection: NWConnection, gen: Int) {
    connection.stateUpdateHandler = { [weak self] state in
      guard let self, self.generation == gen, !self.stopped else { return }
      switch state {
      case .ready:
        self.requestStreamReady = true
        self.receiveMore(connection, gen: gen)
        self.maybeSendRequest(gen: gen)
      case .failed(let error):
        self.complete(outcome: .failed("QUIC request stream failed: \(error)"), payload: nil)
      case .cancelled:
        self.complete(outcome: .cancelled, payload: nil)
      default:
        break
      }
    }
  }

  private func maybeSendRequest(gen: Int) {
    if stopped || generation != gen || requestSent || prefaces < 3 || !requestStreamReady { return }
    requestSent = true
    let payload: Data
    do {
      payload = try encodeRequest()
    } catch {
      complete(outcome: .failed((error as? H3Failure)?.message ?? error.localizedDescription), payload: nil)
      return
    }
    requestStream?.send(content: payload, isComplete: true, completion: .contentProcessed { [weak self] error in
      guard let self, self.generation == gen, !self.stopped else { return }
      if let error {
        self.complete(outcome: .failed("QUIC send failed: \(error)"), payload: nil)
      }
    })
  }

  private func receiveMore(_ connection: NWConnection, gen: Int) {
    if receiving { return }
    receiving = true
    connection.receive(minimumIncompleteLength: 1, maximumLength: 64 * 1024) { [weak self] data, _, isComplete, error in
      guard let self, self.generation == gen, !self.stopped else { return }
      self.receiving = false
      if let data, !data.isEmpty {
        self.inbound.append(data)
        do {
          try self.consumeFrames()
        } catch {
          self.complete(outcome: .failed((error as? H3Failure)?.message ?? error.localizedDescription), payload: nil)
          return
        }
      }
      if isComplete {
        self.finishStream()
        return
      }
      if let error {
        self.complete(outcome: .failed("QUIC receive failed: \(error)"), payload: nil)
        return
      }
      self.queue.async { [weak self] in
        guard let self, self.generation == gen, !self.stopped else { return }
        self.receiveMore(connection, gen: gen)
      }
    }
  }

  private func drain(_ connection: NWConnection, gen: Int) {
    connections.append(connection)
    connection.stateUpdateHandler = { [weak self] state in
      guard let self, self.generation == gen, !self.stopped else { return }
      if case .ready = state {
        self.discard(connection, gen: gen)
      }
    }
    connection.start(queue: queue)
  }

  private func discard(_ connection: NWConnection, gen: Int) {
    connection.receive(minimumIncompleteLength: 1, maximumLength: 64 * 1024) { [weak self] _, _, isComplete, error in
      guard let self, self.generation == gen, !self.stopped else { return }
      if isComplete || error != nil { return }
      self.discard(connection, gen: gen)
    }
  }

  private func finishStream() {
    if framePhase != 0 || inboundRead != inbound.count {
      complete(outcome: .failed("Truncated HTTP/3 response"), payload: nil)
      return
    }
    if status == 0 {
      complete(outcome: .failed("HTTP/3 response had no :status"), payload: nil)
      return
    }
    if let next = redirectTarget() {
      follow(next)
      return
    }
    let ms = Int(Date().timeIntervalSince(startedAt) * 1000)
    PixivQuicClient.log.info(
      "\(self.method, privacy: .public) \(self.url.host ?? "", privacy: .public) \(self.status) h3 \(self.responseBody.count)B \(ms)ms")
    complete(outcome: nil, payload: successPayload())
  }

  private func redirectTarget() -> URL? {
    guard redirectsLeft > 0 else { return nil }
    guard [301, 302, 303, 307, 308].contains(status) else { return nil }
    guard let location = responseHeaders["location"]?.first,
      let next = URL(string: location, relativeTo: url)?.absoluteURL,
      next.scheme?.lowercased() == "https",
      next.port == nil || next.port == 443,
      let host = next.host?.lowercased(),
      Self.allowedHosts.contains(host)
    else { return nil }
    return next
  }

  private func follow(_ next: URL) {
    if status == 301 || status == 302 || status == 303 {
      method = "GET"
      body = nil
      headers = headers.filter { name, _ in
        let lower = name.lowercased()
        return lower != "content-type" && lower != "content-length"
      }
    }
    redirectsLeft -= 1
    url = next
    tearDown()
    connect()
  }

  private func successPayload() -> [String: Any] {
    [
      "statusCode": status,
      "statusMessage": "",
      "headers": responseHeaders,
      "body": FlutterStandardTypedData(bytes: responseBody),
      "protocol": "h3",
    ]
  }

  private func complete(outcome: H3Outcome?, payload: [String: Any]?) {
    if stopped { return }
    stopped = true
    timeoutWork?.cancel()
    timeoutWork = nil
    tearDown()
    PixivQuicClient.shared.remove(id)
    let callback = result
    result = nil
    if let outcome {
      switch outcome {
      case .cancelled:
        PixivQuicClient.log.debug("cancelled \(self.url.host ?? "", privacy: .public)")
      case .timeout:
        PixivQuicClient.log.error("timeout \(self.url.host ?? "", privacy: .public)")
      case .failed(let message):
        PixivQuicClient.log.error(
          "\(self.method, privacy: .public) \(self.url.host ?? "", privacy: .public) \(message, privacy: .public)")
      }
    }
    DispatchQueue.main.async {
      if let payload {
        callback?(payload)
        return
      }
      switch outcome {
      case .cancelled:
        callback?(FlutterError(code: "CANCELLED", message: "Request cancelled", details: nil))
      case .timeout:
        callback?(
          FlutterError(
            code: "TIMEOUT",
            message: "HTTP/3 request timed out after \(self.timeoutMs)ms",
            details: nil))
      case .failed(let message):
        callback?(FlutterError(code: "CRONET", message: message, details: nil))
      case nil:
        callback?(FlutterError(code: "CRONET", message: "Empty HTTP/3 response", details: nil))
      }
    }
  }

  private func tearDown() {
    generation += 1
    let oldGroup = group
    group = nil
    requestStream = nil
    oldGroup?.stateUpdateHandler = nil
    oldGroup?.newConnectionHandler = nil
    let oldConnections = connections
    connections = []
    for connection in oldConnections {
      connection.stateUpdateHandler = nil
      connection.cancel()
    }
    oldGroup?.cancel()
    closeModern?()
    closeModern = nil
    retainedModern = nil
    resetParser()
  }

  private func resetParser() {
    streamsOpened = false
    prefaces = 0
    requestStreamReady = false
    requestSent = false
    receiving = false
    inbound.removeAll(keepingCapacity: false)
    inboundRead = 0
    framePhase = 0
    frameType = 0
    frameLength = 0
    frameGot = 0
    headerPayload.removeAll(keepingCapacity: false)
    responseBody.removeAll(keepingCapacity: false)
    status = 0
    sawFinalHeaders = false
    responseHeaders = [:]
  }

  private func encodeRequest() throws -> Data {
    var block = Data([0x00, 0x00])
    if let index = Self.methodIndexes[method] {
      PixivQpack.appendIndexed(index, to: &block)
    } else {
      try PixivQpack.appendLiteral(":method", method, to: &block)
    }
    PixivQpack.appendIndexed(23, to: &block)
    try PixivQpack.appendNameRef(0, requestAuthority(), to: &block)
    let path = requestPath()
    if path == "/" {
      PixivQpack.appendIndexed(1, to: &block)
    } else {
      try PixivQpack.appendNameRef(1, path, to: &block)
    }
    for (name, value) in headers {
      let lower = name.lowercased()
      if lower.hasPrefix(":") || Self.skipRequestHeaders.contains(lower) { continue }
      try PixivQpack.appendLiteral(lower, value, to: &block)
    }

    var frame = Data()
    PixivQpack.appendVarint(0x01, to: &frame)
    PixivQpack.appendVarint(UInt64(block.count), to: &frame)
    frame.append(block)
    if let body, !body.isEmpty {
      PixivQpack.appendVarint(0x00, to: &frame)
      PixivQpack.appendVarint(UInt64(body.count), to: &frame)
      frame.append(body)
    }
    return frame
  }

  private func requestAuthority() -> String {
    guard let host = url.host else { return "" }
    if let port = url.port, port != 443 {
      return "\(host):\(port)"
    }
    return host
  }

  private func requestPath() -> String {
    if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
      let path = components.percentEncodedPath.isEmpty ? "/" : components.percentEncodedPath
      if let query = components.percentEncodedQuery, !query.isEmpty {
        return "\(path)?\(query)"
      }
      return path
    }
    return url.path.isEmpty ? "/" : url.path
  }

  private func consumeFrames() throws {
    while true {
      if framePhase == 0 {
        guard let type = pullVarint() else { return }
        frameType = type
        framePhase = 1
      } else if framePhase == 1 {
        guard let length = pullVarint() else { return }
        if length > UInt64(Self.maxBody) {
          throw H3Failure(message: "HTTP/3 frame exceeds \(Self.maxBody) bytes")
        }
        frameLength = Int(length)
        frameGot = 0
        headerPayload.removeAll(keepingCapacity: true)
        if frameType == 0x01 && frameLength > 256 * 1024 {
          throw H3Failure(message: "HTTP/3 headers exceed 256KB")
        }
        framePhase = 2
        if frameLength == 0 {
          try finishFrame()
          framePhase = 0
        }
      } else {
        let available = inbound.count - inboundRead
        let need = frameLength - frameGot
        if available == 0 || need == 0 {
          if need == 0 {
            try finishFrame()
            framePhase = 0
            continue
          }
          return
        }
        let take = min(available, need)
        let chunk = inbound.subdata(in: inboundRead..<(inboundRead + take))
        inboundRead += take
        frameGot += take
        try acceptPayload(chunk)
        compactInbound()
        if frameGot == frameLength {
          try finishFrame()
          framePhase = 0
        } else {
          return
        }
      }
    }
  }

  private func acceptPayload(_ chunk: Data) throws {
    if frameType == 0x00 {
      if responseBody.count + chunk.count > Self.maxBody {
        throw H3Failure(message: "Response exceeds \(Self.maxBody) bytes")
      }
      responseBody.append(chunk)
    } else if frameType == 0x01 {
      headerPayload.append(chunk)
    }
  }

  private func finishFrame() throws {
    if frameType == 0x01 {
      try applyHeaderBlock(headerPayload)
      headerPayload.removeAll(keepingCapacity: false)
    }
  }

  private func applyHeaderBlock(_ block: Data) throws {
    let fields = try PixivQpack.decode(block)
    guard let rawStatus = fields.first(where: { $0.name == ":status" })?.value, let code = Int(rawStatus),
      (100...599).contains(code)
    else {
      throw H3Failure(message: "HTTP/3 response is missing :status")
    }
    if code < 200 || sawFinalHeaders { return }
    sawFinalHeaders = true
    status = code
    var decoded: [String: [String]] = [:]
    for field in fields where !field.name.hasPrefix(":") {
      decoded[field.name, default: []].append(field.value)
    }
    responseHeaders = decoded
  }

  private func pullVarint() -> UInt64? {
    guard inboundRead < inbound.count else { return nil }
    let first = inbound[inboundRead]
    let length = 1 << Int(first >> 6)
    guard inbound.count - inboundRead >= length else { return nil }
    var value = UInt64(first & 0x3F)
    if length > 1 {
      for offset in 1..<length {
        value = (value << 8) | UInt64(inbound[inboundRead + offset])
      }
    }
    inboundRead += length
    return value
  }

  private func compactInbound() {
    if inboundRead == inbound.count {
      inbound.removeAll(keepingCapacity: true)
      inboundRead = 0
    } else if inboundRead > 65536 {
      inbound.removeSubrange(0..<inboundRead)
      inboundRead = 0
    }
  }

  private static func isIPv4(_ value: String) -> Bool {
    let parts = value.split(separator: ".")
    guard parts.count == 4 else { return false }
    return parts.allSatisfy { part in
      guard let number = Int(part), (0...255).contains(number) else { return false }
      return String(number) == part
    }
  }

  private static func stringMap(_ value: Any?) -> [String: String] {
    guard let raw = value as? [AnyHashable: Any] else { return [:] }
    var headers: [String: String] = [:]
    for (key, item) in raw {
      guard let name = key as? String else { continue }
      if let text = item as? String {
        headers[name] = text
      } else if item is NSNull {
        continue
      } else {
        headers[name] = String(describing: item)
      }
    }
    return headers
  }
}

private enum PixivQpack {
  struct Field {
    let name: String
    let value: String
  }

  static func appendVarint(_ value: UInt64, to data: inout Data) {
    if value <= 63 {
      data.append(UInt8(value))
    } else if value <= 16383 {
      let encoded = UInt16(value) | 0x4000
      data.append(UInt8(encoded >> 8))
      data.append(UInt8(encoded & 0xFF))
    } else if value <= 1_073_741_823 {
      let encoded = UInt32(value) | 0x8000_0000
      data.append(UInt8((encoded >> 24) & 0xFF))
      data.append(UInt8((encoded >> 16) & 0xFF))
      data.append(UInt8((encoded >> 8) & 0xFF))
      data.append(UInt8(encoded & 0xFF))
    } else {
      let encoded = value | 0xC000_0000_0000_0000
      for shift in stride(from: 56, through: 0, by: -8) {
        data.append(UInt8((encoded >> UInt64(shift)) & 0xFF))
      }
    }
  }

  static func appendIndexed(_ index: Int, to data: inout Data) {
    appendPrefixed(index, prefixBits: 6, mask: 0xC0, to: &data)
  }

  static func appendNameRef(_ index: Int, _ value: String, to data: inout Data) throws {
    appendPrefixed(index, prefixBits: 4, mask: 0x70, to: &data)
    try appendString(Data(value.utf8), prefixBits: 7, mask: 0x00, to: &data)
  }

  static func appendLiteral(_ name: String, _ value: String, to data: inout Data) throws {
    try appendString(Data(name.utf8), prefixBits: 3, mask: 0x30, to: &data)
    try appendString(Data(value.utf8), prefixBits: 7, mask: 0x00, to: &data)
  }

  static func decode(_ block: Data) throws -> [Field] {
    var reader = Reader(data: block)
    let requiredInserts = try reader.readInteger(prefixBits: 8)
    if requiredInserts != 0 {
      throw H3Failure(message: "QPACK dynamic table is not supported")
    }
    _ = try reader.readInteger(prefixBits: 7)
    var fields: [Field] = []
    while reader.index < block.count {
      let peek = block[reader.index]
      if peek & 0x80 != 0 {
        let isStatic = peek & 0x40 != 0
        let index = try reader.readInteger(prefixBits: 6)
        if !isStatic {
          throw H3Failure(message: "QPACK dynamic table is not supported")
        }
        let entry = try staticEntry(index)
        fields.append(Field(name: entry.0, value: entry.1))
      } else if peek & 0xC0 == 0x40 {
        let isStatic = peek & 0x10 != 0
        let index = try reader.readInteger(prefixBits: 4)
        let value = try reader.readString(prefixBits: 7)
        if !isStatic {
          throw H3Failure(message: "QPACK dynamic table is not supported")
        }
        let entry = try staticEntry(index)
        fields.append(Field(name: entry.0, value: value))
      } else if peek & 0xE0 == 0x20 {
        let name = try reader.readString(prefixBits: 3).lowercased()
        let value = try reader.readString(prefixBits: 7)
        fields.append(Field(name: name, value: value))
      } else {
        throw H3Failure(message: "QPACK dynamic table is not supported")
      }
    }
    return fields
  }

  private static func staticEntry(_ index: Int) throws -> (String, String) {
    guard staticTable.indices.contains(index) else {
      throw H3Failure(message: "QPACK static index \(index) is out of range")
    }
    return staticTable[index]
  }

  private static func appendPrefixed(_ value: Int, prefixBits: Int, mask: UInt8, to data: inout Data) {
    let maxValue = (1 << prefixBits) - 1
    if value < maxValue {
      data.append(mask | UInt8(value))
      return
    }
    data.append(mask | UInt8(maxValue))
    var rest = value - maxValue
    while rest >= 128 {
      data.append(UInt8(rest & 0x7F) | 0x80)
      rest >>= 7
    }
    data.append(UInt8(rest))
  }

  private static func appendString(_ bytes: Data, prefixBits: Int, mask: UInt8, to data: inout Data) throws {
    if bytes.count > 1024 * 1024 {
      throw H3Failure(message: "HTTP/3 header is too large")
    }
    appendPrefixed(bytes.count, prefixBits: prefixBits, mask: mask, to: &data)
    data.append(bytes)
  }

  private struct Reader {
    let data: Data
    var index = 0

    mutating func readInteger(prefixBits: Int) throws -> Int {
      if index >= data.count {
        throw H3Failure(message: "Truncated QPACK header block")
      }
      let first = data[index]
      index += 1
      let maxValue = (1 << prefixBits) - 1
      var value = Int(first & UInt8(maxValue))
      if value < maxValue { return value }
      var shift = 0
      while true {
        if index >= data.count {
          throw H3Failure(message: "Truncated QPACK integer")
        }
        let byte = data[index]
        index += 1
        value += Int(byte & 0x7F) << shift
        if byte & 0x80 == 0 { return value }
        shift += 7
        if shift > 28 {
          throw H3Failure(message: "QPACK integer is too large")
        }
      }
    }

    mutating func readString(prefixBits: Int) throws -> String {
      if index >= data.count {
        throw H3Failure(message: "Truncated QPACK header block")
      }
      let first = data[index]
      let huffman = (first & UInt8(1 << prefixBits)) != 0
      let maxValue = (1 << prefixBits) - 1
      var length = Int(first & UInt8(maxValue))
      index += 1
      if length == maxValue {
        var shift = 0
        while true {
          if index >= data.count {
            throw H3Failure(message: "Truncated QPACK string")
          }
          let byte = data[index]
          index += 1
          length += Int(byte & 0x7F) << shift
          if byte & 0x80 == 0 { break }
          shift += 7
          if shift > 28 {
            throw H3Failure(message: "QPACK string length is too large")
          }
        }
      }
      if length < 0 || length > 1024 * 1024 || length > data.count - index {
        throw H3Failure(message: "Truncated QPACK string")
      }
      let raw = data.subdata(in: index..<(index + length))
      index += length
      if huffman {
        return String(decoding: try PixivHuffman.decode(raw), as: UTF8.self)
      }
      return String(decoding: raw, as: UTF8.self)
    }
  }

  private static let staticTable: [(String, String)] = {
    let entries: [(String, String)] = [
      (":authority", ""),
      (":path", "/"),
      ("age", "0"),
      ("content-disposition", ""),
      ("content-length", "0"),
      ("cookie", ""),
      ("date", ""),
      ("etag", ""),
      ("if-modified-since", ""),
      ("if-none-match", ""),
      ("last-modified", ""),
      ("link", ""),
      ("location", ""),
      ("referer", ""),
      ("set-cookie", ""),
      (":method", "CONNECT"),
      (":method", "DELETE"),
      (":method", "GET"),
      (":method", "HEAD"),
      (":method", "OPTIONS"),
      (":method", "POST"),
      (":method", "PUT"),
      (":scheme", "http"),
      (":scheme", "https"),
      (":status", "103"),
      (":status", "200"),
      (":status", "304"),
      (":status", "404"),
      (":status", "503"),
      ("accept", "*/*"),
      ("accept", "application/dns-message"),
      ("accept-encoding", "gzip, deflate, br"),
      ("accept-ranges", "bytes"),
      ("access-control-allow-headers", "cache-control"),
      ("access-control-allow-headers", "content-type"),
      ("access-control-allow-origin", "*"),
      ("cache-control", "max-age=0"),
      ("cache-control", "max-age=2592000"),
      ("cache-control", "max-age=604800"),
      ("cache-control", "no-cache"),
      ("cache-control", "no-store"),
      ("cache-control", "public, max-age=31536000"),
      ("content-encoding", "br"),
      ("content-encoding", "gzip"),
      ("content-type", "application/dns-message"),
      ("content-type", "application/javascript"),
      ("content-type", "application/json"),
      ("content-type", "application/x-www-form-urlencoded"),
      ("content-type", "image/gif"),
      ("content-type", "image/jpeg"),
      ("content-type", "image/png"),
      ("content-type", "text/css"),
      ("content-type", "text/html; charset=utf-8"),
      ("content-type", "text/plain"),
      ("content-type", "text/plain;charset=utf-8"),
      ("range", "bytes=0-"),
      ("strict-transport-security", "max-age=31536000"),
      ("strict-transport-security", "max-age=31536000; includesubdomains"),
      ("strict-transport-security", "max-age=31536000; includesubdomains; preload"),
      ("vary", "accept-encoding"),
      ("vary", "origin"),
      ("x-content-type-options", "nosniff"),
      ("x-xss-protection", "1; mode=block"),
      (":status", "100"),
      (":status", "204"),
      (":status", "206"),
      (":status", "302"),
      (":status", "400"),
      (":status", "403"),
      (":status", "421"),
      (":status", "425"),
      (":status", "500"),
      ("accept-language", ""),
      ("access-control-allow-credentials", "FALSE"),
      ("access-control-allow-credentials", "TRUE"),
      ("access-control-allow-headers", "*"),
      ("access-control-allow-methods", "get"),
      ("access-control-allow-methods", "get, post, options"),
      ("access-control-allow-methods", "options"),
      ("access-control-expose-headers", "content-length"),
      ("access-control-request-headers", "content-type"),
      ("access-control-request-method", "get"),
      ("access-control-request-method", "post"),
      ("alt-svc", "clear"),
      ("authorization", ""),
      ("content-security-policy", "script-src 'none'; object-src 'none'; base-uri 'none'"),
      ("early-data", "1"),
      ("expect-ct", ""),
      ("forwarded", ""),
      ("if-range", ""),
      ("origin", ""),
      ("purpose", "prefetch"),
      ("server", ""),
      ("timing-allow-origin", "*"),
      ("upgrade-insecure-requests", "1"),
      ("user-agent", ""),
      ("x-forwarded-for", ""),
      ("x-frame-options", "deny"),
      ("x-frame-options", "sameorigin"),
    ]
    precondition(entries.count == 99)
    precondition(entries[17] == (":method", "GET"))
    precondition(entries[20] == (":method", "POST"))
    precondition(entries[23] == (":scheme", "https"))
    precondition(entries[25] == (":status", "200"))
    return entries
  }()
}

private enum PixivHuffman {
  static func decode(_ data: Data) throws -> Data {
    let tables = codesByLength
    var acc: UInt64 = 0
    var bits = 0
    var position = 0
    var output = Data()
    while true {
      if bits >= 5 {
        var matched = false
        let limit = min(30, bits)
        for length in 5...limit {
          let code = UInt32((acc >> UInt64(bits - length)) & ((UInt64(1) << UInt64(length)) - 1))
          if let symbol = tables[length][code] {
            output.append(symbol)
            bits -= length
            acc = bits == 0 ? 0 : acc & ((UInt64(1) << UInt64(bits)) - 1)
            matched = true
            break
          }
        }
        if matched {
          if output.count > data.count * 2 + 32 {
            throw H3Failure(message: "Huffman header expanded too far")
          }
          continue
        }
      }
      if bits >= 30 {
        throw H3Failure(message: "Invalid Huffman header")
      }
      if position < data.count {
        acc = (acc << 8) | UInt64(data[position])
        bits += 8
        position += 1
        continue
      }
      if bits == 0 { break }
      if bits < 8 && acc == (UInt64(1) << UInt64(bits)) - 1 { break }
      throw H3Failure(message: "Invalid Huffman padding")
    }
    return output
  }

  private static let codesByLength: [[UInt32: UInt8]] = {
    let packed = [
      "1ff8.13,7fffd8.23,fffffe2.28,fffffe3.28,fffffe4.28,fffffe5.28,fffffe6.28,fffffe7.28,fffffe8.28,ffffea.24,3ffffffc.30,fffffe9.28,fffffea.28,3ffffffd.30,fffffeb.28,fffffec.28,",
      "fffffed.28,fffffee.28,fffffef.28,ffffff0.28,ffffff1.28,ffffff2.28,3ffffffe.30,ffffff3.28,ffffff4.28,ffffff5.28,ffffff6.28,ffffff7.28,ffffff8.28,ffffff9.28,ffffffa.28,ffffffb.28,",
      "14.6,3f8.10,3f9.10,ffa.12,1ff9.13,15.6,f8.8,7fa.11,3fa.10,3fb.10,f9.8,7fb.11,fa.8,16.6,17.6,18.6,0.5,1.5,2.5,19.6,1a.6,1b.6,1c.6,1d.6,1e.6,1f.6,5c.7,fb.8,7ffc.15,20.6,ffb.12,3fc.10,",
      "1ffa.13,21.6,5d.7,5e.7,5f.7,60.7,61.7,62.7,63.7,64.7,65.7,66.7,67.7,68.7,69.7,6a.7,6b.7,6c.7,6d.7,6e.7,6f.7,70.7,71.7,72.7,fc.8,73.7,fd.8,1ffb.13,7fff0.19,1ffc.13,3ffc.14,22.6,",
      "7ffd.15,3.5,23.6,4.5,24.6,5.5,25.6,26.6,27.6,6.5,74.7,75.7,28.6,29.6,2a.6,7.5,2b.6,76.7,2c.6,8.5,9.5,2d.6,77.7,78.7,79.7,7a.7,7b.7,7ffe.15,7fc.11,3ffd.14,1ffd.13,ffffffc.28,",
      "fffe6.20,3fffd2.22,fffe7.20,fffe8.20,3fffd3.22,3fffd4.22,3fffd5.22,7fffd9.23,3fffd6.22,7fffda.23,7fffdb.23,7fffdc.23,7fffdd.23,7fffde.23,ffffeb.24,7fffdf.23,",
      "ffffec.24,ffffed.24,3fffd7.22,7fffe0.23,ffffee.24,7fffe1.23,7fffe2.23,7fffe3.23,7fffe4.23,1fffdc.21,3fffd8.22,7fffe5.23,3fffd9.22,7fffe6.23,7fffe7.23,ffffef.24,",
      "3fffda.22,1fffdd.21,fffe9.20,3fffdb.22,3fffdc.22,7fffe8.23,7fffe9.23,1fffde.21,7fffea.23,3fffdd.22,3fffde.22,fffff0.24,1fffdf.21,3fffdf.22,7fffeb.23,7fffec.23,",
      "1fffe0.21,1fffe1.21,3fffe0.22,1fffe2.21,7fffed.23,3fffe1.22,7fffee.23,7fffef.23,fffea.20,3fffe2.22,3fffe3.22,3fffe4.22,7ffff0.23,3fffe5.22,3fffe6.22,7ffff1.23,",
      "3ffffe0.26,3ffffe1.26,fffeb.20,7fff1.19,3fffe7.22,7ffff2.23,3fffe8.22,1ffffec.25,3ffffe2.26,3ffffe3.26,3ffffe4.26,7ffffde.27,7ffffdf.27,3ffffe5.26,fffff1.24,1ffffed.25,",
      "7fff2.19,1fffe3.21,3ffffe6.26,7ffffe0.27,7ffffe1.27,3ffffe7.26,7ffffe2.27,fffff2.24,1fffe4.21,1fffe5.21,3ffffe8.26,3ffffe9.26,ffffffd.28,7ffffe3.27,7ffffe4.27,7ffffe5.27,",
      "fffec.20,fffff3.24,fffed.20,1fffe6.21,3fffe9.22,1fffe7.21,1fffe8.21,7ffff3.23,3fffea.22,3fffeb.22,1ffffee.25,1ffffef.25,fffff4.24,fffff5.24,3ffffea.26,7ffff4.23,",
      "3ffffeb.26,7ffffe6.27,3ffffec.26,3ffffed.26,7ffffe7.27,7ffffe8.27,7ffffe9.27,7ffffea.27,7ffffeb.27,ffffffe.28,7ffffec.27,7ffffed.27,7ffffee.27,7ffffef.27,7fffff0.27,3ffffee.26",
    ].joined()
    let parts = packed.split(separator: ",")
    precondition(parts.count == 256, "Huffman table has \(parts.count) symbols")
    var tables = Array(repeating: [UInt32: UInt8](), count: 31)
    for (symbol, part) in parts.enumerated() {
      let pieces = part.split(separator: ".")
      precondition(pieces.count == 2, "Bad Huffman entry \(part)")
      guard let code = UInt32(pieces[0], radix: 16), let length = Int(pieces[1]) else {
        preconditionFailure("Bad Huffman entry \(part)")
      }
      precondition((5...30).contains(length))
      precondition(tables[length][code] == nil, "Duplicate Huffman code")
      tables[length][code] = UInt8(symbol)
    }
    precondition(tables[5][0] == UInt8(48))
    precondition(tables[6][0x18] == UInt8(47))
    return tables
  }()
}
