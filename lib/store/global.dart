import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStore {
  static late GlobalProvider globalProvider; // 全局提供器

  // 当前账号的配置信息（含token和过期时间），未登录为null
  static AccountProfile? currentAccount;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /* 初始化全局信息，会在APP启动时执行 */
  static Future init() async {
    globalProvider = GlobalProvider();

    // 初始化账号配置
    await AccountStore().init();
    String? id = await AccountStore.getCurrentAccountId();
    if (id != null) {
      try {
        // 获取用户配置信息
        AccountProfile? profile = await AccountStore.getCurrentAccountProfile(userId: id);
        currentAccount = profile; // 设置全局帐号变量，但不通知提供器
      } catch (e) {
        print(e);
      }
    }
    //初始化网络请求相关配置
    ApiBase().init();
  }

  // 更新当前账号配置（不通知更新UI）
  static void changeCurrentAccount(AccountProfile? profile) {
    currentAccount = profile;
    ApiBase().init(); // 重新初始化dio请求
  }
}

// 全局提供器
class GlobalProvider with ChangeNotifier {
  AccountProfile? get currentAccount => GlobalStore.currentAccount; // 当前帐号

  // 是否已经登录（如果有用户信息，则证明登录过)
  bool get isLoggedIn => currentAccount != null;

  void setCurrentAccount(AccountProfile? profile) {
    GlobalStore.changeCurrentAccount(profile);
    notifyListeners(); // 通知更改（UI自动更新）
  }
}
