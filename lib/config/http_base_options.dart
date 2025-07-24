/// Http请求的默认参数
class HttpBaseOptions {
  static String get baseUrl => 'https://$appApiHost';

  // Get ip by https://dns.sb/doh
  static const String appApiHost = "app-api.pixiv.net";
  static const String appApiIp = "210.140.139.152";

  static const String oauthHost = "oauth.secure.pixiv.net";
  static const String oauthIp = "210.140.139.152";

  static const String pximgHost = "i.pximg.net";
  static const String pximg2Host = "s.pximg.net";
  static const String pximgIp = "210.140.139.134";
  static const String pximg2Ip = "210.140.139.134";
  static const String pixivisionHost = "www.pixivision.net";
  static const String pixivisionIp = "210.140.139.155";

  // 网络请求的各个时间
  static const Duration connectTimeout = Duration(seconds: 12);
  static const Duration receiveTimeout = Duration(seconds: 12);
  static const Duration sendTimeout = Duration(seconds: 12);
}
