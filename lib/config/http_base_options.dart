import 'package:artvier/config/constants.dart';

/// Http请求的默认参数
class HttpBaseOptions {
  static get baseUrl => 'https://$appApiHost';

  // Get ip by https://dns.sb/doh
  static const String appApiHost = "app-api.pixiv.net";
  static const String appApiIp = "210.140.139.152";

  static const String oauthHost = "oauth.secure.pixiv.net";
  static const String oauthIp = "210.140.139.152";

  static const String pximgHost = "i.pximg.net";
  static const String pximgIp = "210.140.139.134";
  static const String pixivisionHost = "www.pixivision.net";
  static const String pixivisionIp = "210.140.139.155";

  // 网络请求的各个时间
  static const Duration connectTimeout = Duration(seconds: 12);
  static const Duration receiveTimeout = Duration(seconds: 12);
  static const Duration sendTimeout = Duration(seconds: 12);

  static const Map<String, String> baseHeaders = {
    "User-Agent": "PixivIOSApp/7.20.18 (iOS 17.7; iPhone11,2)",
    "App-OS": "ios",
    "App-OS-Version": "17.7",
    "App-Version": "7.20.18",
    "Accept-Language": "zh-CN",
  };

  static const Map<String, String> appApiHeaders = {
    ...baseHeaders,
    ...{"Host": appApiHost}
  };

  static const Map<String, String> oauthHeaders = {
    ...baseHeaders,
    ...{"Host": oauthHost}
  };

  static const Map<String, String> pximgHeaders = {
    ...baseHeaders,
    ...{"Host": pximgHost},
    ...{"referer": CONSTANTS.appApiReferer}
  };

  static const Map<String, String> pixivisionHeaders = {
    ...baseHeaders,
    ...{"Host": pixivisionHost}
  };
}
