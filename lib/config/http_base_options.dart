/// Http请求的默认参数
class HttpBaseOptions {
  static get baseUrl => 'https://$baseUrlHost';

  static const String baseUrlHost = 'app-api.pixiv.net';
  // static const String baseUrlIp = '210.140.131.199'; // www.pixiv.net
  // static const String baseUrlIp = '104.18.30.199'; // app-api.pixiv.net
  static const String pixivisionUrlHost = 'www.pixivision.net';

  // 时间单位：毫秒 ms
  static const int connectTimeout = 12000;
  static const int receiveTimeout = 12000;
  static const int sendTimeout = 12000;

  static const Map<String, String> headers = {
    "User-Agent": "PixivIOSApp/7.12.5 (iOS 14.6; iPhone11,2)",
    "accept-language": "zh-cn",
  };
}
