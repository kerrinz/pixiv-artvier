// 全局提供器
import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/model_store/downloading_illust.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/store/theme_store.dart';

class GlobalProvider extends BaseProvider {
  AccountProfile? get currentAccount => GlobalStore.currentAccount; // 当前帐号
  ThemeMode themeMode = ThemeMode.system; // 主题模式，默认跟随系统
  int downloadMode = DownloadStore.MODE_GALLERY; // 下载保存图片模式
  Map<String, DownloadingIllust> downloadingIllust = {}; // 下载中的插画
  Locale locale = const Locale('en', 'US'); // App语言

  // 是否已经登录（如果有用户信息，则证明登录过)
  bool get isLoggedIn => currentAccount != null;

  void setCurrentAccount(AccountProfile? profile) {
    GlobalStore.changeCurrentAccount(profile);
    notifyListeners(); // 通知更改（UI自动更新）
  }

  /// 设置主题模式。ifSave: 是否持久化存储
  void setThemeMode(ThemeMode themeMode, bool ifSave) {
    this.themeMode = themeMode;
    if (ifSave) ThemeStore.setThemeMode(themeMode);
    notifyListeners();
  }

  void setDownloadMode(int mode, bool ifSafe) {
    downloadMode = mode;
    if (ifSafe) DownloadStore.setDownloadMode(mode);
    notifyListeners();
  }

  void setDownloadingIllusts(Map<String, DownloadingIllust> map) {
    downloadingIllust = map;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}
