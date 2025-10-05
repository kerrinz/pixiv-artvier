import 'package:artvier/global/model/proxy_options/image_hosting_model.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/model/proxy_options/proxy_state_model.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/request/my_http_overrides.dart';
import 'package:artvier/preferences/network_store.dart';

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

/// 图片源（图床）设置
final globalImageHostingProvider = StateNotifierProvider<_ImageHostingNotifier, ImageHostingModel>((ref) {
  var prefs = ref.watch(globalSharedPreferencesProvider);
  var storage = NetworkStorage(prefs);

  // 从本地读取配置
  bool isEnabled = storage.getImageHostingEnable();
  String host = storage.getImageHosting();

  return _ImageHostingNotifier(
    ImageHostingModel(isEnabled: isEnabled, host: host),
    ref: ref,
  );
  // return ProxyStateModel(isProxyEnabled: isEnabled, host: host, port: port);
});

/// 直连
final globalDirectConnectionProvider = StateNotifierProvider<_DirectConnectionNotifier, bool>((ref) {
  var prefs = ref.watch(globalSharedPreferencesProvider);
  var storage = NetworkStorage(prefs);
  bool isEnabled = storage.getDirectEnable();
  return _DirectConnectionNotifier(isEnabled, ref: ref);
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

class _DirectConnectionNotifier extends BaseStateNotifier<bool> {
  _DirectConnectionNotifier(super.state, {required super.ref});

  Future<bool> openDirect() async {
    state = true;
    var storage = NetworkStorage(prefs);
    return await storage.setDirectEnable(true);
  }

  Future<bool> closeDirect() async {
    state = false;
    var storage = NetworkStorage(prefs);
    return await storage.setDirectEnable(false);
  }

  Future<bool> toggleDirect() async {
    return state ? closeDirect() : openDirect();
  }
}

class _ImageHostingNotifier extends BaseStateNotifier<ImageHostingModel> {
  _ImageHostingNotifier(super.state, {required super.ref});
  Future<bool> enable() async {
    state = state.copyWith(isEnabled: true);
    var storage = NetworkStorage(prefs);
    final result = await storage.setImageHostingEnable(true);
    HttpHostOverrides().reload();
    return result;
  }

  Future<bool> disable() async {
    state = state.copyWith(isEnabled: false);
    var storage = NetworkStorage(prefs);
    final result = await storage.setImageHostingEnable(false);
    HttpHostOverrides().reload();
    return result;
  }

  Future<bool> toggle() async {
    return state.isEnabled ? disable() : enable();
  }

  /// 更新并保存
  /// return isSuccessed
  Future<bool> updateAndSaveHost(String host) async {
    state = state.copyWith(host: host);
    var storage = NetworkStorage(prefs);
    bool result = await storage.setImageHosting(host);
    HttpHostOverrides().reload();
    return result;
  }

  /// 更新并保存
  /// return isSuccessed
  Future<bool> updateAndSave(ImageHostingModel data) async {
    state = data;
    var storage = NetworkStorage(prefs);
    bool result = await storage.setImageHosting(data.host).then(
          (value) => value ? storage.setImageHostingEnable(data.isEnabled) : Future.value(false),
        );
    return result;
  }
}
