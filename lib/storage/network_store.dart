import 'package:pixgem/base/base_storage.dart';
import 'package:pixgem/config/constants.dart';

class NetworkStorage extends BaseStorage {
  NetworkStorage(super.sharedPreferences);

  static const String proxyHost = "network_proxy_host";
  static const String proxyPort = "network_proxy_port";
  static const String proxyEnable = "network_proxy_enable"; // 是否开启代理

  /// 设置网络代理
  Future<bool> setNetworkProxy(String host, String port) async {
    bool h = await sharedPreferences.setString(proxyHost, host);
    return h && await sharedPreferences.setString(proxyPort, port);
  }

  /// 获取完整的网络代理（适合用于应用代理设置），不存在则会获得默认值
  /// 格式：[HOST]:[IP]
  String getNetworkProxy() {
    String h = sharedPreferences.getString(proxyHost) ?? CONSTANTS.proxy_default_host;
    String p = sharedPreferences.getString(proxyPort) ?? CONSTANTS.proxy_default_port;
    return "$h:$p";
  }

  String? getProxyHost() {
    return sharedPreferences.getString(proxyHost);
  }

  String? getProxyPort() {
    return sharedPreferences.getString(proxyPort);
  }

  bool getProxyEnable() {
    return sharedPreferences.getBool(proxyEnable) ?? false;
  }

  Future<bool> setProxyEnable(bool enable) {
    return sharedPreferences.setBool(proxyEnable, enable);
  }
}
