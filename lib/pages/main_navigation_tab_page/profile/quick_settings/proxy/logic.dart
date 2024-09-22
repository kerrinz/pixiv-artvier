import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/network_provider.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/storage/network_store.dart';

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

  /// 图片源的输入框值
  final inputImageHostProvider = StateProvider.autoDispose<String?>((ref) {
    var prefs = ref.watch(globalSharedPreferencesProvider);
    return NetworkStorage(prefs).getImageHosting();
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

  /// 保存图片源
  Future<bool> handleSaveImageHost(WidgetRef ref, {required String host}) async {
    return ref.read(globalImageHostingProvider.notifier).updateAndSaveHost(host);
  }
}
