import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStore {
  // 当前模式
  static const MODE = "theme_mode";
  static late SharedPreferences _preferences;
  // 主题模式（因为要存储所以得用int对应ThemeMode的枚举）
  static const MODE_SYSTEM = 0; // 自动
  static const MODE_LIGHT = 1; // 亮色
  static const MODE_DARK = 2; // 暗色

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static ThemeMode transferToThemeMode(int mode) {
    switch (mode) {
      case MODE_LIGHT:
        return ThemeMode.light;
      case MODE_DARK:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
  static int transferByThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return MODE_LIGHT;
      case ThemeMode.dark:
        return MODE_DARK;
      default:
        return MODE_SYSTEM;
    }
  }

  // 设置主题模式
  static Future setThemeMode(ThemeMode themeMode) async {
    return await _preferences.setInt(MODE, transferByThemeMode(themeMode));
  }

  // 获取主题模式
  static ThemeMode getThemeMode() {
    int? result = _preferences.getInt(MODE);
    return transferToThemeMode(result ?? MODE_SYSTEM);
  }
}

