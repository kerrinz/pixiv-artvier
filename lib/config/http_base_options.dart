/// Http请求的默认参数
class HttpBaseOptions {
  static String get baseUrl => 'https://$appApiHost';

  static const String appApiHost = "app-api.pixiv.net";
  static const String oauthHost = "oauth.secure.pixiv.net";

  /// API / OAuth 在 Cloudflare 上。直连时把域名钉到这里（Android HostResolverRules，
  /// iOS 直接连这个 IP），请求 URL 仍用域名，TLS 带原主机名 SNI。
  static const String cloudflareApiIp = "104.18.42.239";
  static const String cloudflareApiIpSecondary = "172.64.145.17";

  /// 图片仍在 Pixiv 源站，不支持 QUIC。直连时连这些 IP，且 URL 用 IP 字面量以省略 SNI。
  static const String pximgHost = "i.pximg.net";
  static const String pximg2Host = "s.pximg.net";
  static const List<String> pximgIps = [
    "210.140.139.134",
    "210.140.139.133",
    "210.140.139.131",
  ];
  static const String pximgIp = "210.140.139.134";
  static const String pximg2Ip = "210.140.139.134";

  static const String pixivisionHost = "www.pixivision.net";

  /// 旧源站。无 SNI 的 HTTP/1.1 会 403，直连改为和 API 一样钉到 Cloudflare。
  static const String pixivisionIp = "210.140.139.155";

  // 网络请求的各个时间
  static const Duration connectTimeout = Duration(seconds: 12);
  static const Duration receiveTimeout = Duration(seconds: 12);
  static const Duration sendTimeout = Duration(seconds: 12);
}
