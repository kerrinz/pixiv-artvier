import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 插画列表的通用Provider，附带了请求加载状态的管理
class IllustListProvider extends ChangeNotifier {
  /// 插画或漫画列表，[list.isEmpty]表示取得数据但无作品
  List<CommonIllust> list = [];

  LoadingStatus loadingStatus = LoadingStatus.loading;

  void resetIllusts(List<CommonIllust> list, {LoadingStatus status = LoadingStatus.success}) {
    this.list.clear();
    this.list.addAll(list);
    if (loadingStatus != status) loadingStatus = status;
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    if (loadingStatus != status) {
      loadingStatus = status;
      notifyListeners();
    }
  }

  void appendIllusts(List<CommonIllust> list) {
    this.list.addAll(list);
    notifyListeners();
  }

  void clearIllusts() {
    list.clear();
    notifyListeners();
  }
}
