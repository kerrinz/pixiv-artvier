import 'dart:typed_data';

import 'package:artvier/config/http_base_options.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

/// 直连 API：Android 用 Cronet QUIC，iOS 15+ 用 Network.framework QUIC。
///
/// 两边都走 [artvier/pixiv_cronet]。图片仍走 dart:io 的无 SNI 源站，更新检查也走 dart:io。
class PixivCronetAdapter implements HttpClientAdapter {
  PixivCronetAdapter({HttpClientAdapter? fallback})
      : _fallback = fallback ?? IOHttpClientAdapter();

  static const MethodChannel _channel = MethodChannel('artvier/pixiv_cronet');

  static const Set<String> directHosts = {
    'app-api.pixiv.net',
    'oauth.secure.pixiv.net',
    'www.pixiv.net',
    'www.pixivision.net',
  };

  final HttpClientAdapter _fallback;
  var _closed = false;
  var _requestSerial = 0;

  static bool handlesHost(String host) =>
      directHosts.contains(host.toLowerCase());

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_closed) {
      throw DioException.connectionError(
          requestOptions: options, reason: 'Cronet adapter is closed');
    }
    if (!handlesHost(options.uri.host)) {
      return _fallback.fetch(options, requestStream, cancelFuture);
    }

    final id = '${DateTime.now().microsecondsSinceEpoch}-${_requestSerial++}';
    var cancelled = false;
    cancelFuture?.then((_) {
      cancelled = true;
      _channel.invokeMethod<void>('cancel', {'id': id});
    });

    Uint8List? body;
    if (requestStream != null) {
      final builder = BytesBuilder(copy: false);
      await for (final chunk in requestStream) {
        if (cancelled) break;
        builder.add(chunk);
      }
      final bytes = builder.takeBytes();
      if (bytes.isNotEmpty) body = bytes;
    }
    if (cancelled) {
      throw DioException.requestCancelled(
          requestOptions: options, reason: 'cancelled');
    }

    try {
      final raw =
          await _channel.invokeMethod<Map<Object?, Object?>>('request', {
        'id': id,
        'url': options.uri.toString(),
        'method': options.method,
        'headers': _encodeHeaders(options.headers),
        'body': body,
        'timeoutMillis': 30000,
        'directIp': HttpBaseOptions.cloudflareApiIp,
      });
      if (raw == null) {
        throw DioException.connectionError(
            requestOptions: options, reason: 'Empty Cronet response');
      }
      final statusCode = raw['statusCode'] as int? ?? 0;
      final headers = _decodeHeaders(raw['headers']);
      final bytes = raw['body'];
      final data = bytes is Uint8List
          ? bytes
          : Uint8List.fromList((bytes as List?)?.cast<int>() ?? const []);
      return ResponseBody.fromBytes(
        data,
        statusCode,
        headers: headers,
        statusMessage: raw['statusMessage'] as String? ?? '',
      );
    } on PlatformException catch (e) {
      if (e.code == 'CANCELLED') {
        throw DioException.requestCancelled(
            requestOptions: options,
            reason: e.message,
            stackTrace: StackTrace.current);
      }
      if (e.code == 'TIMEOUT') {
        throw DioException.receiveTimeout(
          timeout: const Duration(seconds: 30),
          requestOptions: options,
          error: e.message,
        );
      }
      throw DioException.connectionError(
        requestOptions: options,
        reason: e.message ?? 'Cronet request failed',
        error: e,
      );
    }
  }

  Map<String, String> _encodeHeaders(Map<String, dynamic> headers) {
    final encoded = <String, String>{};
    headers.forEach((key, value) {
      if (value == null) return;
      final lower = key.toLowerCase();
      if (lower == 'content-length' ||
          lower == 'host' ||
          lower == 'transfer-encoding' ||
          lower == 'connection') {
        return;
      }
      encoded[key] = value is List ? value.join(',') : value.toString();
    });
    return encoded;
  }

  Map<String, List<String>> _decodeHeaders(Object? raw) {
    if (raw is! Map) return const {};
    final headers = <String, List<String>>{};
    raw.forEach((key, value) {
      if (key == null) return;
      if (value is List) {
        headers[key.toString()] = value.map((e) => e.toString()).toList();
      } else if (value != null) {
        headers[key.toString()] = [value.toString()];
      }
    });
    return headers;
  }

  @override
  void close({bool force = false}) {
    _closed = true;
    _fallback.close(force: force);
  }
}
