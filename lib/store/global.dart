import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/model_store/downloading_illust.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStore {
  static late GlobalProvider globalProvider; // 全局提供器

  static late SharedPreferences globalSharedPreferences; // 全局持久化存储实例

  // 当前账号的配置信息（含token和过期时间），未登录为null
  static AccountProfile? currentAccount;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /* 初始化全局信息，会在APP启动时执行 */
  static Future init() async {
    // globalProvider = GlobalProvider(); // 已经在程序入口处初始化完成
    globalSharedPreferences = await SharedPreferences.getInstance();

    // 初始化账号配置
    String? id = AccountStore.getCurrentAccountId();
    if (id != null) {
      try {
        // 获取用户配置信息
        AccountProfile? profile = AccountStore.getCurrentAccountProfile(userId: id);
        currentAccount = profile; // 设置全局帐号变量，但不通知提供器
      } catch (e) {
        print(e);
      }
    }
    // 初始化网络请求相关配置
    ApiBase().init();
    // 初始化主题配置
    ThemeMode themeMode = ThemeStore.getThemeMode();
    globalProvider.setThemeMode(themeMode, false);
    // 初始化下载配置
    int downloadMode = DownloadStore.getDownloadMode();
    globalProvider.setDownloadMode(downloadMode, false);
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
  ThemeMode themeMode = ThemeMode.system; // 主题模式
  int downloadMode = DownloadStore.MODE_GALLERY; // 下载保存图片模式
  Map<String, DownloadingIllust> downloadingIllust = {}; // 下载中的插画

  // 是否已经登录（如果有用户信息，则证明登录过)
  bool get isLoggedIn => currentAccount != null;

  void setCurrentAccount(AccountProfile? profile) {
    GlobalStore.changeCurrentAccount(profile);
    notifyListeners(); // 通知更改（UI自动更新）
  }

  void setThemeMode(ThemeMode themeMode, bool ifSave) {
    // ifSave: 是否持久化存储
    this.themeMode = themeMode;
    if (ifSave) ThemeStore.setThemeMode(themeMode);
    notifyListeners();
  }

  void setDownloadMode(int mode, bool ifSafe) {
    this.downloadMode = mode;
    if (ifSafe) ThemeStore.setThemeMode(themeMode);
    notifyListeners();
  }

  void setDownloadingIllusts(Map<String, DownloadingIllust> map) {
    this.downloadingIllust = map;
    notifyListeners();
  }
}
