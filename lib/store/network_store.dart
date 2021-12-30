// ignore_for_file: constant_identifier_names

import 'package:pixgem/config/constants.dart';

import 'global.dart';

class NetworkStore {
  static const String PROXY_HOST = "network_proxy_host";
  static const String PROXY_PORT = "network_proxy_port";
  static const String PROXY_ENABLE = "network_proxy_enable"; // 是否开启代理

  // 设置网络代理
  static Future<bool> setNetworkProxy(String host, String port) async {
    bool h = await GlobalStore.globalSharedPreferences.setString(PROXY_HOST, host);
    return h && await GlobalStore.globalSharedPreferences.setString(PROXY_PORT, port);
  }

  // 获取完整的网络代理（适合用于应用代理设置），不存在则会获得默认值
  static String getNetworkProxy() {
    String h = GlobalStore.globalSharedPreferences.getString(PROXY_HOST) ?? CONSTANTS.proxy_default_host;
    String p = GlobalStore.globalSharedPreferences.getString(PROXY_PORT) ?? CONSTANTS.proxy_default_port;
    return "$h:$p";
  }

  static String? getProxyHost() {
    return GlobalStore.globalSharedPreferences.getString(PROXY_HOST);
  }

  static String? getProxyPort() {
    return GlobalStore.globalSharedPreferences.getString(PROXY_PORT);
  }

  static bool? getProxyEnable() {
    return GlobalStore.globalSharedPreferences.getBool(PROXY_ENABLE);
  }

  static Future<bool> setProxyEnable(bool enable) {
    return GlobalStore.globalSharedPreferences.setBool(PROXY_ENABLE, enable);
  }
}
