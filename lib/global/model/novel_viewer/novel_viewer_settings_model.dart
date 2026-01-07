import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_viewer_settings_model.freezed.dart';
part 'novel_viewer_settings_model.g.dart';

/// 小说阅读器设置
@Freezed(
  copyWith: true,
)
class NovelViewerSettingsModel with _$NovelViewerSettingsModel {
  const factory NovelViewerSettingsModel({
    required double textSize,

    /// 主题名称，空时为默认，'custom' 时为自定义
    String? themeName,

    /// 自定义主题
    NovelViewerTheme? customTheme,
  }) = _NovelViewerSettingsModel;
}

/// 小说阅读器预设主题
@Freezed(
  copyWith: true,
)
class NovelViewerPresetTheme with _$NovelViewerPresetTheme {
  const factory NovelViewerPresetTheme({
    NovelViewerTheme? theme,
    String? name,
  }) = _NovelViewerPresetTheme;
}

/// 小说阅读器主题
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
)
class NovelViewerTheme with _$NovelViewerTheme {
  const factory NovelViewerTheme({
    required int foreground,
    required int background,
  }) = _NovelViewerTheme;

  factory NovelViewerTheme.fromJson(Map<String, dynamic> srcJson) => _$NovelViewerThemeFromJson(srcJson);
}
