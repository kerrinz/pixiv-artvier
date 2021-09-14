import 'dart:convert';

import 'package:pixgem/model_store/account_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * 账号集合的结构：Map<String, AccountProfile>
 * 单账号结构：AccountProfile
 * */

class AccountStore {
  // 当前账号id
  static const CURRENT_ACCOUNT_ID = "current_account_id";
  // 已缓存的所有账号的信息
  // ignore: non_constant_identifier_names
  static const ALL_ACCOUNTS_PROFILE = "all_accounts_profile";
  static var _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // 设置所有账号信息
  static Future setAllAccountsProfile(Map<String, AccountProfile> accounts) async {
    await _preferences.setString(ALL_ACCOUNTS_PROFILE, json.encode(accounts));
  }

  // 获取某所有账号信息
  static Future<Map<String, AccountProfile>?> getAllAccountsProfile() async {
    String? str =  await _preferences.getString(ALL_ACCOUNTS_PROFILE);
    if (str == null) return null;
    return AccountsProfile.getAccountsMap(str);
  }

  // 添加或覆盖单个账号信息
  static Future updateAccountProfile(AccountProfile profile) async {
    Map<String, AccountProfile>? map = await getAllAccountsProfile();
    if (map == null) {
      print("allAccountsProfile no found, create a new profile");
      map = new Map();
    }
    map[profile.user.id] = profile;
    return setAllAccountsProfile(map);
  }

  // 设置当前所处的账号id
  static Future setCurrentAccountId({required String id}) async {
    await _preferences.setString(CURRENT_ACCOUNT_ID, id);
  }

  // 获取当前所处的账号id
  static Future<String?> getCurrentAccountId() async {
    return await _preferences.getString(CURRENT_ACCOUNT_ID);
  }

  // 获取当前信息（若指定userId，则返回该userId的信息）
  static Future<AccountProfile?> getCurrentAccountProfile({String? userId}) async {
    String? currentId = userId ?? await AccountStore.getCurrentAccountId();
    if (currentId == null) return null;
    Map<String, AccountProfile>? accountsMap = await AccountStore.getAllAccountsProfile();
    if (accountsMap == null) return null;
    return accountsMap[currentId];
  }

  // 退出当前账号
  static Future logoutCurrent() async {
    String id = await _preferences.getString(CURRENT_ACCOUNT_ID);
    await _preferences.remove(CURRENT_ACCOUNT_ID);
    await removeAccountProfileById(userId: id);
  }

  // 删除某个账号的缓存信息
  static Future removeAccountProfileById({required String userId}) async {
    Map<String, AccountProfile>? map = await getAllAccountsProfile();
    if (map != null) {
      map.remove(userId);
      await _preferences.setString(ALL_ACCOUNTS_PROFILE, AccountsProfile.getAccountsString(map));
    }
  }

}
