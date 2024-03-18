import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/storage/network_store.dart';

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
    isEnableDirect = NetworkStorage(globalSharedPreferences).getDirectEnable();
  }

  /// 重新加载该服务
  reload() {
    _init();
  }

  bool isEnableDirect = false;

  appApiUrl(String url) =>
      isEnableDirect ? url.replaceFirst(HttpBaseOptions.appApiHost, HttpBaseOptions.appApiIp) : url;
  pxImgUrl(String url) => isEnableDirect ? url.replaceFirst(HttpBaseOptions.pximgHost, HttpBaseOptions.pximgIp) : url;
  pixivisionUrl(String url) =>
      isEnableDirect ? url.replaceFirst(HttpBaseOptions.pixivisionHost, HttpBaseOptions.pixivisionIp) : url;
}
