import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/provider/shared_preferences.dart';
import 'package:pixgem/model/model_store/account_profile.dart';
import 'package:pixgem/storage/account_storage.dart';

/// 当前登录的帐号
final globalCurrentAccountProvider = StateNotifierProvider<CurrentAccountProvider, AccountProfile?>(((ref) {
  final prefs = ref.watch(globalSharedPreferencesProvider);
  AccountProfile? currentAccount = AccountStorage(prefs).getCurrentAccountProfile();
  return CurrentAccountProvider(currentAccount, ref: ref);
}));

class CurrentAccountProvider extends StateNotifier<AccountProfile?> {
  CurrentAccountProvider(
    super.state, {
    required this.ref,
  });
  final Ref ref;

  /// 退出登录
  logOut() {
    final prefs = ref.read(globalSharedPreferencesProvider);
    AccountStorage(prefs).logoutCurrent();
  }
}
