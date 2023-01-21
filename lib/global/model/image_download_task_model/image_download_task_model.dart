import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_download_task_model.freezed.dart';
part 'image_download_task_model.g.dart';

/// 美术作品下载进程的数据模型
///
/// 注：一件（插画漫画）作品有多张图片
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
)
class ImageDownloadTaskModel with _$ImageDownloadTaskModel {
  const factory ImageDownloadTaskModel({
    /// 所属作品的ID
    required String worksId,

    /// 图片在作品中的索引，eg: p0, p1 p2 p3
    required int pIndex,

    /// 参阅[DownloadStorage.downloadStateMap]
    required int downloadState,

    /// 已下载进度（字节）
    double? receivedBytes,

    /// 图片总大小（字节）
    double? totalBytes,

    required String url,
    required String title,
  }) = _ImageDownloadTaskModel;

  factory ImageDownloadTaskModel.fromJson(Map<String, dynamic> json) => _$ImageDownloadTaskModelFromJson(json);
}
