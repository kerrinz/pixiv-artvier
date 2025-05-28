import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/oauth.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/storage/account_storage.dart';
import 'package:artvier/global/model/account_profile/account_profile.dart';

final accountManageProvider =
    StateNotifierProvider.autoDispose<AccountManageNotifier, Map<String, AccountProfile>>(((ref) {
  var prefs = ref.watch(globalSharedPreferencesProvider);
  var allAccounts = AccountStorage(prefs).getAllAccountsProfile();

  return AccountManageNotifier(allAccounts ?? {}, ref: ref);
}));

class AccountManageNotifier extends BaseStateNotifier<Map<String, AccountProfile>> {
  AccountManageNotifier(super.state, {required super.ref});

  Future<void> deleteAccount(String userId) async {
    await AccountStorage(ref.read(globalSharedPreferencesProvider)).removeAccount(userId: userId);
    state.remove(userId);
    final state2 = Map<String, AccountProfile>.from(state);
    update(state2);
  }

  /// 切换帐号
  Future<void> switchAccount(String userId) async {
    var profile = state[userId]!;
    ref.read(globalCurrentAccountProvider.notifier).setAccount(profile);
    // 刷新token，获取新的帐号配置
    var newProfile = await OAuth(ref).refreshToken(profile.refreshToken);
    // 保存到本地
    AccountStorage(prefs).updateAccountProfile(profile);
    AccountStorage(prefs).setCurrentAccountId(profile.user.id);
    // 更新全局状态
    ref.read(globalCurrentAccountProvider.notifier).setAccount(newProfile);
  }
}
