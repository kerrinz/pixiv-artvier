import 'package:shared_preferences/shared_preferences.dart';

// 全局变量集中地

late final SharedPreferences globalSharedPreferences; // TODO: 全部 SharedPreferences 转到该对象上

/// 基本请求头
late final Map<String, String> globalBaseHttpHeaders;
