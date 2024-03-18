/// Http请求的默认参数
class HttpBaseOptions {
  static get baseUrl => 'https://$appApiHost';

  static const String appApiHost = "app-api.pixiv.net";
  static const String appApiIp = "210.140.92.183";

  static const String oauthHost = "oauth.secure.pixiv.net";
  static const String oauthIp = "210.140.131.219";

  static const String pximgHost = "i.pximg.net";
  static const String pximgIp = "210.140.92.144";
  static const String pixivisionHost = "www.pixivision.net";
  static const String pixivisionIp = "210.140.92.186";

  // 时间单位：毫秒 ms
  static const int connectTimeout = 12000;
  static const int receiveTimeout = 12000;
  static const int sendTimeout = 12000;

  static const Map<String, String> baseHeaders = {
    "User-Agent": "PixivIOSApp/7.12.5 (iOS 14.6; iPhone11,2)",
    "App-OS": "ios",
    "App-OS-Version": "11.0",
    "App-Version": "6.54.0",
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
    ...{"Host": pximgHost}
  };

  static const Map<String, String> pixivisionHeaders = {
    ...baseHeaders,
    ...{"Host": pixivisionHost}
  };
}
