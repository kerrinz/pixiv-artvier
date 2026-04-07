import 'package:artvier/config/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_load_settings_model.freezed.dart';

/// 资源加载设置的数据模型
@Freezed(
  copyWith: true,
)
class ResourceLoadSettingsModel with _$ResourceLoadSettingsModel {
  const factory ResourceLoadSettingsModel({
    /// 列表画质
    required ListPreviewQuality listPreviewQuality,

    /// 插画详情页画质
    required DetailsPageQuality illustDetailsQuality,

    /// 漫画详情页画质
    required DetailsPageQuality mangaDetailsQuality,
  }) = _ResourceLoadSettingsModel;
}
