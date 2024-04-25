import 'package:artvier/config/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';

part 'image_viewer_page_arguments.freezed.dart';

/// 图片浏览页的传递参数
@Freezed(
  copyWith: true,
)
class ImageViewerPageArguments with _$ImageViewerPageArguments {
  const factory ImageViewerPageArguments({
    /// 图片列表
    required List<ImageQualityUrl> urlList,

    /// 资源类型
    required DownloadType downloadType,

    /// 作品 id
    required String worksId,

    /// 作品标题
    required String title,

    /// 初始查看第几张图片
    required int index,
  }) = _ImageViewerPageArguments;
}
