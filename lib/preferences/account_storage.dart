// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:artvier/global/model/account_profile/account_profile.dart';
import 'package:artvier/base/base_storage.dart';

/// 账号集合的结构：[Map<String, AccountProfile>]
/// 单账号结构：AccountProfile
class AccountStorage extends BaseStorage {
  AccountStorage(super.sharedPreferences);

  // 当前账号id
  static const _currentAccountIdKey = "current_account_id";
  // 已缓存的所有账号的信息
  static const _allAccountsProfileKey = "all_accounts_profile";

  // 设置所有账号信息
  Future setAllAccountsProfile(Map<String, AccountProfile> accounts) async {
    await prefs.setString(_allAccountsProfileKey, json.encode(accounts));
  }

  // 获取某所有账号信息
  Map<String, AccountProfile>? getAllAccountsProfile() {
    String? str = prefs.getString(_allAccountsProfileKey);
    if (str == null) return null;
    return AccountsProfile.getAccountsMap(str);
  }

  // 添加或覆盖单个账号信息
  Future updateAccountProfile(AccountProfile profile) async {
    Map<String, AccountProfile>? map = getAllAccountsProfile();
    map ??= {};
    map[profile.user.id] = profile;
    return setAllAccountsProfile(map);
  }

  // 设置当前所处的账号id
  Future setCurrentAccountId(String id) async {
    await prefs.setString(_currentAccountIdKey, id);
  }

  // 获取当前所处的账号id
  String? getCurrentAccountId() {
    return prefs.getString(_currentAccountIdKey);
  }

  // 获取当前信息（若指定userId，则返回该userId的信息）
  AccountProfile? getCurrentAccountProfile({String? userId}) {
    String? currentId = userId ?? getCurrentAccountId();
    if (currentId == null) return null;
    Map<String, AccountProfile>? accountsMap = getAllAccountsProfile();
    if (accountsMap == null) return null;
    return accountsMap[currentId];
  }

  // 删除某个账号的缓存信息
  Future removeAccount({required String userId}) async {
    Map<String, AccountProfile>? map = getAllAccountsProfile();
    if (map != null) {
      map.remove(userId);
      await prefs.setString(_allAccountsProfileKey, AccountsProfile.getAccountsString(map));
    }
  }

  // 删除当前账号
  Future removeCurrentAccount() async {
    String? id = prefs.getString(_currentAccountIdKey);
    if (id != null) {
      await prefs.remove(_currentAccountIdKey);
      await removeAccount(userId: id);
    }
  }
}
