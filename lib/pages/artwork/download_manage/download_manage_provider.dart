import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class DownloadManageProvider extends BaseProvider {
  List<CommonIllust> downloadingIllusts = []; // 正在下载的列表
  List<CommonIllust> downloadedIllusts = []; // 已下载的列表

  void setDownloadingIllusts(List<CommonIllust> list) {
    downloadingIllusts = list;
    notifyListeners();
  }

  // 添加下载任务（可多个）
  void addDownloadingIllusts(List<CommonIllust> list) {
    downloadingIllusts.insertAll(0, list);
    notifyListeners();
  }

  // 删除下载任务（可多个）
  void removeDownloadingIllusts(List<CommonIllust> list) {
    downloadingIllusts.insertAll(0, list);
    notifyListeners();
  }

  void setDownloadedIllusts(List<CommonIllust> list) {
    downloadedIllusts = list;
    notifyListeners();
  }
}
