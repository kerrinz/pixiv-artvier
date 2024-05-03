import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/oauth.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';
import 'package:artvier/global/model/account_profile/account_profile.dart';
import 'package:artvier/storage/account_storage.dart';

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
      // 更新登录状态
      state = newProfile;
    } catch (e) {
      logger.e(e);
    }
  }

  /// 使用 refresh_token 登录
  Future<bool> loginByRefreshToken(String refreshToken) async {
    try {
      // 刷新一次token
      var newProfile = await OAuth(ref).refreshToken(refreshToken);
      // 保存并使用新帐号信息
      await OAuth(ref).saveAndLoginToken(newProfile);
      // 更新登录状态
      state = newProfile;
      return true;
    } catch (e) {
      logger.e(e);
      rethrow;
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
