import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/storage/theme_storage.dart';

/// 全局主题模式，浅色、深色、跟随系统
final globalThemeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  // 本地缓存的主题模式（不存在则默认跟随系统）
  var localThemeMode = ThemeStorage(ref.watch(globalSharedPreferencesProvider)).themeMode();

  return ThemeModeNotifier(localThemeMode, ref: ref);
});

class ThemeModeNotifier extends BaseStateNotifier<ThemeMode> {
  ThemeModeNotifier(super.state, {required super.ref});

  /// 切换主题模式
  /// - 返回是否成功
  Future<bool> switchThemeMode(ThemeMode themeMode) async {
    if (await ThemeStorage(prefs).setThemeMode(themeMode)) {
      state = themeMode;
      return true;
    } else {
      return false;
    }
  }
}
