// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:artvier/base/base_storage.dart';

class ThemeStorage extends BaseStorage {
  ThemeStorage(super.sharedPreferences);

  // 当前主题模式
  static const _themeMode = "theme_mode";

  /// 将[ThemeMode] 映射成int类型
  static const Map<int, ThemeMode> themeModeMap = {
    0: ThemeMode.system,
    1: ThemeMode.light,
    2: ThemeMode.dark,
  };

  // 设置主题模式
  Future<bool> setThemeMode(ThemeMode themeMode) async {
    return await sharedPreferences.setInt(
      _themeMode,
      themeModeMap.entries.firstWhere((element) => element.value == themeMode).key,
    );
  }

  // 获取主题模式
  ThemeMode themeMode() {
    int? result = sharedPreferences.getInt(_themeMode);
    return themeModeMap[themeModeMap.keys.contains(result) ? result : 0]!;
  }
}
