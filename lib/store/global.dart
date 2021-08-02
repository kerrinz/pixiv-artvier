import 'dart:convert';

import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStore {
  // 当前账号的配置信息，（token过期时间也在里面）
  static AccountProfile? currentAccount;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");


  /* 初始化全局信息，会在APP启动时执行 */
  static Future init() async {
    // 初始化账号配置
    await AccountStore().init();
    String? id = await AccountStore.getCurrentAccountId();
    if (id != null) {
      try {
        // 获取用户配置信息
        AccountProfile? profile = await AccountStore.getCurrentAccountProfile(userId: id);
        currentAccount = profile;
      } catch (e) {
        print(e);
      }
    }

    //初始化网络请求相关配置
    ApiApp().init();

  }

  // 更新当前账号
  static void changeCurrentAccount(AccountProfile profile) {
    currentAccount = profile;
    ApiApp().init(); // 重新初始化dio请求
  }
}
