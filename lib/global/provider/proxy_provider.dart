import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/model/proxy_options/proxy_state_model.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/request/my_http_overrides.dart';
import 'package:artvier/storage/network_store.dart';

/// 全局代理配置
final globalProxyStateProvider = StateNotifierProvider<_HttpProxyNotifier, ProxyStateModel>((ref) {
  var prefs = ref.watch(globalSharedPreferencesProvider);
  var storage = NetworkStorage(prefs);

  // 从本地读取配置
  bool isEnabled = storage.getProxyEnable();
  String host = storage.getProxyHost() ?? CONSTANTS.proxy_default_host;
  String port = storage.getProxyPort() ?? CONSTANTS.proxy_default_port;

  return _HttpProxyNotifier(
    ProxyStateModel(isProxyEnabled: isEnabled, host: host, port: port),
    ref: ref,
  );
  // return ProxyStateModel(isProxyEnabled: isEnabled, host: host, port: port);
});

class _HttpProxyNotifier extends BaseStateNotifier<ProxyStateModel> {
  _HttpProxyNotifier(super.state, {required super.ref});

  /// 拼接的代理地址
  get proxyAddress => "${state.host}:${state.port}";

  /// 应用配置到 [MyHttpOverrides]
  void applyHttpOverrides() {
    MyHttpOverrides.instance.setProxyAddress(state.isProxyEnabled ? proxyAddress : null);
  }

  /// 更新代理配置并保存
  /// return isSuccessed
  Future<bool> updateAndSave(ProxyStateModel data) async {
    state = data;
    var storage = NetworkStorage(prefs);
    bool result = await storage.setNetworkProxy(data.host, data.port).then(
          (value) => value ? storage.setProxyEnable(data.isProxyEnabled) : Future.value(false),
        );
    if (result) applyHttpOverrides();
    return result;
  }
}
