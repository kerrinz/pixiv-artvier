import 'dart:io';

import 'package:artvier/global/logger.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final httpOverridesProvider = Provider((ref) => MyHttpOverrides());

class MyHttpOverrides extends HttpOverrides {
  factory MyHttpOverrides() => _instance;

  static final MyHttpOverrides _instance = MyHttpOverrides._();

  static MyHttpOverrides get instance => _instance;

  MyHttpOverrides._();

  /// 代理配置，格式为[HOST/IP:PORT]，当null时则不使用代理
  String? _proxy;

  /// 设置代理，当null时则不使用代理
  void setProxyAddress(String? proxy) {
    if (_proxy == proxy) return;
    _proxy = proxy;
    logger.i("The Proxy in HttpOverrides is changed (null means disabled): \nproxy=【$proxy】");
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      }
      // ..findProxy = (url) {
      //   return 'PROXY $proxy';
      // };
      ..findProxy = _findProxy;
  }

  // 配置代理设置
  String _findProxy(url) {
    if (_proxy == null) {
      return HttpClient.findProxyFromEnvironment(url);
    } else {
      return HttpClient.findProxyFromEnvironment(url, environment: {
        "http_proxy": _proxy!,
        "https_proxy": _proxy!,
        "no_proxy": "",
      });
    }
  }
}
