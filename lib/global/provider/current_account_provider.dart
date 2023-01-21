import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/oauth.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/storage/model/account_profile.dart';
import 'package:pixgem/storage/account_storage.dart';

/// 当前登录的帐号
final globalCurrentAccountProvider = StateNotifierProvider<CurrentAccountNotifier, AccountProfile?>((ref) {
  final prefs = ref.watch(globalSharedPreferencesProvider);
  AccountProfile? currentAccount = AccountStorage(prefs).getCurrentAccountProfile();
  return CurrentAccountNotifier(currentAccount, ref: ref);
});

class CurrentAccountNotifier extends StateNotifier<AccountProfile?> {
  CurrentAccountNotifier(
    super.state, {
    required this.ref,
  });
  final Ref ref;

  String? codeVerifier;

  /// 退出登录
  logOut() {
    final prefs = ref.read(globalSharedPreferencesProvider);
    try {
      AccountStorage(prefs).removeCurrentAccount();
      state = null;
    } catch (e) {
      logger.e(e);
    }
  }

  /// 使用OAuth鉴权方式登录
  Future<void> oAuthLogin(String code) async {
    // 请求用户数据（含token）
    codeVerifier ??= OAuth.createCodeVerifier();
    try {
      AccountProfile profile = await OAuth(ref).requestToken(code, codeVerifier!);
      // 刷新一次token
      var newProfile = await OAuth(ref).refreshToken(profile.refreshToken);
      // 保存并使用新帐号信息
      await OAuth(ref).saveAndLoginToken(newProfile);
    } catch (e) {
      logger.e(e);
    }
  }

  String getLoginWebViewUrl() {
    codeVerifier = OAuth.createCodeVerifier();
    return OAuth.getLoginWebViewUrl(codeVerifier!);
  }

  /// 切换帐号信息
  void setAccount(AccountProfile? profile) {
    state = profile;
  }
}
