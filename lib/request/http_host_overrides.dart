import 'dart:io' show HttpHeaders;
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/preferences/language_store.dart';
import 'package:artvier/preferences/network_store.dart';

/// 根据设置，覆盖 Http 链接的 url
/// 单例模式，依赖变化后需要手动调用 [reload()] 重载
class HttpHostOverrides {
  factory HttpHostOverrides() => _instance;

  static final HttpHostOverrides _instance = HttpHostOverrides._();

  static HttpHostOverrides get instance => _instance;

  HttpHostOverrides._() {
    _init();
  }

  _init() {
    final networkStore = NetworkStorage(globalSharedPreferences);
    final languageStore = LanguageStorage(globalSharedPreferences);
    isEnableDirect = networkStore.getDirectEnable();
    isImageHostingEnable = networkStore.getImageHostingEnable();
    imageHosting = networkStore.getImageHosting();

    // Update headers...
    // Update language
    final languageLocale = languageStore.getLanguageLocale();
    final acceptLanguage = "${languageLocale.languageCode}_${languageLocale.countryCode}";
    globalBaseHttpHeaders[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    _appApiHeaders[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    _oauthHeaders[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    _pximgHeaders[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    _pximg2Headers[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    _pixivisionHeaders[HttpHeaders.acceptLanguageHeader] = acceptLanguage;
    // 直连图片：TCP 连源站 IP，Host 仍是原域名。SNI 由 IP 字面量 URL 省略。
    if (isEnableDirect && !isImageHostingEnable) {
      _pximgHeaders[HttpHeaders.hostHeader] = HttpBaseOptions.pximgHost;
      _pximg2Headers[HttpHeaders.hostHeader] = HttpBaseOptions.pximg2Host;
    } else {
      _pximgHeaders.remove(HttpHeaders.hostHeader);
      _pximg2Headers.remove(HttpHeaders.hostHeader);
    }
  }

  /// 重新加载该服务
  reload() {
    _init();
  }

  bool isEnableDirect = false;
  bool isImageHostingEnable = false;
  String imageHosting = "";

  final Map<String, String> _appApiHeaders = {
    ...globalBaseHttpHeaders,
    ...{HttpHeaders.hostHeader: HttpBaseOptions.appApiHost}
  };
  final Map<String, String> _oauthHeaders = {
    ...globalBaseHttpHeaders,
    ...{HttpHeaders.hostHeader: HttpBaseOptions.oauthHost}
  };
  final Map<String, String> _pximgHeaders = {
    ...globalBaseHttpHeaders,
    ...{HttpHeaders.refererHeader: CONSTANTS.referer}
  };
  final Map<String, String> _pximg2Headers = {
    ...globalBaseHttpHeaders,
    ...{HttpHeaders.refererHeader: CONSTANTS.referer}
  };
  final Map<String, String> _pixivisionHeaders = {
    ...globalBaseHttpHeaders,
    ...{HttpHeaders.hostHeader: HttpBaseOptions.pixivisionHost}
  };

  Map<String, String> get baseHeaders => globalBaseHttpHeaders;
  Map<String, String> get appApiHeaders => _appApiHeaders;
  Map<String, String> get oauthHeaders => _oauthHeaders;
  Map<String, String> get pximgHeaders => _pximgHeaders;
  Map<String, String> get pximg2Headers => _pximg2Headers;
  Map<String, String> get pixivisionHeaders => _pixivisionHeaders;

  /// 自动判断并生成 Headers
  Map<String, String> dynamicHeaders(String url) {
    if (!isEnableDirect) {
      return baseHeaders;
    }
    if (url.contains(HttpBaseOptions.pximgHost)) {
      return pximgHeaders;
    }
    if (url.contains(HttpBaseOptions.pximg2Host)) {
      return pximg2Headers;
    }
    if (url.contains(HttpBaseOptions.oauthHost)) {
      return oauthHeaders;
    }
    if (url.contains(HttpBaseOptions.pixivisionHost)) {
      return pixivisionHeaders;
    }
    return baseHeaders;
  }

  /// API 直连不再改写成旧源站 IP。域名交给 Cronet，由 QUIC + HostResolverRules 到达 Cloudflare。
  String appApiUrl(String url) => url;

  /// 直连图片：把 i.pximg.net / s.pximg.net 换成源站 IP。
  /// Dart 对 IP 字面量不发送 SNI，握手包里不会出现 pximg 域名。
  String pxImgUrl(String url) {
    if (isImageHostingEnable) {
      return url
          .replaceFirst(HttpBaseOptions.pximgHost, imageHosting)
          .replaceFirst(HttpBaseOptions.pximg2Host, imageHosting);
    }
    if (!isEnableDirect) return url;
    if (url.contains(HttpBaseOptions.pximgHost)) {
      return url.replaceFirst(HttpBaseOptions.pximgHost, HttpBaseOptions.pximgIp);
    }
    if (url.contains(HttpBaseOptions.pximg2Host)) {
      return url.replaceFirst(HttpBaseOptions.pximg2Host, HttpBaseOptions.pximg2Ip);
    }
    return url;
  }

  pixivisionUrl(String url) =>
      isEnableDirect ? url.replaceFirst(HttpBaseOptions.pixivisionHost, HttpBaseOptions.pixivisionIp) : url;
}
