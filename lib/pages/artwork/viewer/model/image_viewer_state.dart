import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_viewer_state.freezed.dart';

/// 图片预览页的状态
@Freezed(
  copyWith: true,
)
class ImageViewerPageState with _$ImageViewerPageState {
  const factory ImageViewerPageState({
    /// 当前图片索引
    required int pageIndex,

    /// （分辨率）是否原图
    required bool isOriginal,
  }) = _ImageViewerPageState;
}
