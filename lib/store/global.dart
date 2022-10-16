import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/request/my_http_overrides.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/network_store.dart';
import 'package:pixgem/store/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStore {
  /// 全局提供器
  static late GlobalProvider globalProvider;

  /// 全局持久化存储实例
  static late SharedPreferences globalSharedPreferences;

  static String codeVerifier = "";

  static late String? codeChallenge;

  /// 当前账号的配置信息（含token和过期时间），未登录为null
  static AccountProfile? currentAccount;

  static String? proxy; // 代理配置，为null则不走代理

  /// 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    // globalProvider = GlobalProvider();
    // globalSharedPreferences = await SharedPreferences.getInstance();
    // 以上均已在程序入口处初始化完成

    // 账号配置
    String? id = AccountStore.getCurrentAccountId();
    if (id != null) {
      // 获取用户配置信息
      AccountProfile? profile = AccountStore.getCurrentAccountProfile(userId: id);
      currentAccount = profile; // 设置全局帐号变量，但不通知Provider
    }
    // 网络请求相关配置
    proxy = NetworkStore.getProxyEnable() ? NetworkStore.getNetworkProxy() : null;
    ApiBase.init();
    // 代理设置
    HttpOverrides.global = MyHttpOverrides();
    // 主题配置
    ThemeMode themeMode = ThemeStore.getThemeMode();
    globalProvider.setThemeMode(themeMode, false);
    // 下载配置
    int downloadMode = DownloadStore.getDownloadMode();
    globalProvider.setDownloadMode(downloadMode, false);
  }

  /// 更新当前账号配置（不通知更新UI）
  static void changeCurrentAccount(AccountProfile? profile) {
    currentAccount = profile;
    ApiBase.init(); // 重新初始化dio请求
  }
}
