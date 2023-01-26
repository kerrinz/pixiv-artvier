// import 'dart:io';
// import 'package:pixgem/request/my_http_overrides.dart';
// import 'package:pixgem/storage/network_store.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GlobalStore {
//   static late SharedPreferences globalSharedPreferences;

//   static String? proxy; // 代理配置，为null则不走代理

//   /// 是否为release版
//   static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

//   /// 初始化全局信息，会在APP启动时执行
//   static Future init() async {
//     globalSharedPreferences = await SharedPreferences.getInstance();
//     // 网络请求相关配置
//     proxy = NetworkStorage.getProxyEnable() ? NetworkStorage.getNetworkProxy() : null;
//     // 代理设置
//     HttpOverrides.global = MyHttpOverrides();
//   }
// }
