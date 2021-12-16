import 'dart:io';

import 'package:pixgem/store/global.dart';

class MyHttpOverrides extends HttpOverrides {
  MyHttpOverrides() : super();

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
    if (GlobalStore.proxy == null)
      return HttpClient.findProxyFromEnvironment(url);
    else
      return HttpClient.findProxyFromEnvironment(url, environment: {
        "http_proxy": GlobalStore.proxy!,
        "https_proxy": GlobalStore.proxy!,
        "no_proxy": "",
      });
  }
}
