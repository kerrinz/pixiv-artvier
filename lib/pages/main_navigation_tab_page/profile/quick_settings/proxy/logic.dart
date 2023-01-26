import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/provider/proxy_provider.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/storage/network_store.dart';

mixin ProxyLogic {
  /// 代理主机的输入框值
  final inputProxyHostProvider = StateProvider.autoDispose<String?>((ref) {
    var prefs = ref.watch(globalSharedPreferencesProvider);
    return NetworkStorage(prefs).getProxyHost();
  });

  /// 代理端口的输入框值
  final inputProxyPortProvider = StateProvider.autoDispose<String?>((ref) {
    var prefs = ref.watch(globalSharedPreferencesProvider);
    return NetworkStorage(prefs).getProxyPort();
  });

  /// 代理开关
  Future<bool> handleProxyEnable(WidgetRef ref, {required bool proxyEnabled}) {
    return ref
        .read(globalProxyStateProvider.notifier)
        .updateAndSave(ref.read(globalProxyStateProvider).copyWith(isProxyEnabled: proxyEnabled));
  }

  /// 保存代理主机端口
  /// return isSuccessed
  Future<bool> handleSaveProxyHostPort(WidgetRef ref, {required String host, required String port}) async {
    return ref
        .read(globalProxyStateProvider.notifier)
        .updateAndSave(ref.read(globalProxyStateProvider).copyWith(host: host, port: port));
  }
}
