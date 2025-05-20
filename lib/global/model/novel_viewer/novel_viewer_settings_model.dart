import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_viewer_settings_model.freezed.dart';

/// 图片源（图床）
@Freezed(
  copyWith: true,
)
class NovelViewerSettingsModel with _$NovelViewerSettingsModel {
  const factory NovelViewerSettingsModel({
    required double textSize,
  }) = _NovelViewerSettingsModel;
}
