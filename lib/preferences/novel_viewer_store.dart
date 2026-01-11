import 'dart:convert';

import 'package:artvier/base/base_storage.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';

class NovelViewerStorage extends BaseStorage {
  NovelViewerStorage(super.sharedPreferences);

  static const _textSize = "text_size";

  /// 小说浏览界面的主题，空时为默认，'custom' 时为自定义
  static const _pageTheme = "novel_viewer_page_theme";

  /// 自定义浏览界面的前景色
  static const _pageCustomTheme = "novel_viewer_page_custom_theme";

  /// 设置字体大小
  Future<bool> setTextSize(double textSize) async {
    return await sharedPreferences.setDouble(_textSize, textSize);
  }

  /// 获取字体大小
  double? textSize() {
    return sharedPreferences.getDouble(_textSize);
  }

  /// 设置主题，空时为默认，'custom' 时为自定义
  Future<bool> setPageTheme(String? themeName) async {
    return themeName == null
        ? await sharedPreferences.remove(_pageTheme)
        : await sharedPreferences.setString(_pageTheme, themeName);
  }

  /// 获取主题，空时为默认，'custom' 时为自定义
  String? get pageTheme => sharedPreferences.getString(_pageTheme);

  // /// 设置自定义主题前景、背景色
  Future<bool> setPageCustomTheme(NovelViewerTheme theme) async {
    final str = json.encode(theme.toJson());
    return await sharedPreferences.setString(_pageCustomTheme, str);
  }

  /// 获取自定义主题前景、背景色
  NovelViewerTheme? get pageCustomTheme {
    final str = sharedPreferences.getString(_pageCustomTheme);
    if (str == null || str.length <= 2) return null;
    NovelViewerTheme? theme;
    try {
      theme = NovelViewerTheme.fromJson(json.decode(str));
    } catch (e) {
      logger.e(e);
    }
    return theme;
  }
}
