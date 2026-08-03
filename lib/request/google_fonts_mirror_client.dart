import 'package:http/http.dart' as http;

/// 将 google_fonts 官方下载域名替换为自定义镜像的 HTTP Client。
///
/// 官方请求形如：`https://fonts.gstatic.com/s/a/{hash}.ttf`
/// 镜像只需提供相同路径结构，改 [mirrorHost] 即可。
class GoogleFontsMirrorClient extends http.BaseClient {
  GoogleFontsMirrorClient({
    required this.mirrorHost,
    http.Client? inner,
  }) : _inner = inner ?? http.Client();

  /// 官方默认主机
  static const String officialHost = 'fonts.gstatic.com';

  /// 镜像主机名（不含协议），例如 `fonts.gstatic.com` 或你的 CDN 主机
  final String mirrorHost;

  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (mirrorHost.isEmpty ||
        mirrorHost == officialHost ||
        request.url.host != officialHost) {
      return _inner.send(request);
    }

    final mirroredUri = request.url.replace(host: mirrorHost);
    final mirrored = http.Request(request.method, mirroredUri)
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..persistentConnection = request.persistentConnection
      ..headers.addAll(request.headers);

    if (request is http.Request) {
      mirrored.bodyBytes = request.bodyBytes;
    }

    return _inner.send(mirrored);
  }

  @override
  void close() => _inner.close();
}
