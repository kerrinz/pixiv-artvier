import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgem/pages/artwork/viewer/model/image_quality_url_model.dart';

part 'image_viewer_page_arguments.freezed.dart';

/// 图片浏览页的传递参数
@Freezed(
  copyWith: true,
)
class ImageViewerPageArguments with _$ImageViewerPageArguments {
  const factory ImageViewerPageArguments({
    /// 普通画质
    required List<ImageQualityUrl> urlList,

    /// 初始查看第几张图片
    required int index
  }) = _ImageViewerPageArguments;
}
