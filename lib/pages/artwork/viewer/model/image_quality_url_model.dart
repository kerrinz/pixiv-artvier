import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_quality_url_model.freezed.dart';

/// 图片多种画质的链接
@Freezed(
  copyWith: true,
)
class ImageQualityUrl with _$ImageQualityUrl {
  const factory ImageQualityUrl({
    /// 普通画质
    required String normal,

    /// 原图画质
    required String original,
  }) = _ImageQualityUrl;
}
