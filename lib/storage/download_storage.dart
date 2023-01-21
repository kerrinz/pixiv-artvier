import 'package:pixgem/config/enums.dart';
import 'package:pixgem/base/base_storage.dart';

/// 废弃，后续转用数据库
class DownloadStorage extends BaseStorage {
  DownloadStorage(super.sharedPreferences); // 自定义下载路径

  // static const _unfinishedImageDownloadList = "unfinished_image_download_list";
  // static const _fnishedImageDownloadList = "finished_image_download_list";

  /// 将[DownloadState] 映射成int类型
  static const Map<int, DownloadState> downloadStateMap = {
    0: DownloadState.success,
    1: DownloadState.downloading,
    2: DownloadState.pause,
    3: DownloadState.waiting,
    4: DownloadState.failed,
  };
}
