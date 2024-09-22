import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_hosting_model.freezed.dart';

/// 图片源（图床）
@Freezed(
  copyWith: true,
)
class ImageHostingModel with _$ImageHostingModel {
  const factory ImageHostingModel({
    /// 图片源
    required String host, 

    /// 是否开启自定义图片源
    required bool isEnabled,
  }) = _ImageHostingModel;
}
