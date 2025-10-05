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
    // Update host
    if (isEnableDirect && !isImageHostingEnable) {
      _pximgHeaders[HttpHeaders.hostHeader] = HttpBaseOptions.pximgHost;
    } else if (_pximgHeaders.containsKey(HttpHeaders.hostHeader)) {
      _pximgHeaders.remove(HttpHeaders.hostHeader);
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
      return baseHeaders;
    }
    if (url.contains(HttpBaseOptions.oauthHost)) {
      return oauthHeaders;
    }
    if (url.contains(HttpBaseOptions.oauthHost)) {
      return oauthHeaders;
    }
    if (url.contains(HttpBaseOptions.pixivisionHost)) {
      return pixivisionHeaders;
    }
    return baseHeaders;
  }

  appApiUrl(String url) =>
      isEnableDirect ? url.replaceFirst(HttpBaseOptions.appApiHost, HttpBaseOptions.appApiIp) : url;

  pxImgUrl(String url) {
    if (isImageHostingEnable) {
      return url.replaceFirst(HttpBaseOptions.pximgHost, imageHosting);
    }
    return isEnableDirect ? url.replaceFirst(HttpBaseOptions.pximgHost, HttpBaseOptions.pximgIp) : url;
  }

  pixivisionUrl(String url) =>
      isEnableDirect ? url.replaceFirst(HttpBaseOptions.pixivisionHost, HttpBaseOptions.pixivisionIp) : url;
}
