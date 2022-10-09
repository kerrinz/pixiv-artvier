import 'package:flutter/material.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustListProvider extends ChangeNotifier {
  /// 插画或漫画列表，[list.isEmpty]表示取得数据但无作品
  List<CommonIllust> list = [];
  LoadingStatus loadingStatus = LoadingStatus.loading;

  void setAll(List<CommonIllust> list, LoadingStatus status) {
    this.list = list;
    loadingStatus = status;
    notifyListeners();
  }

  /// 覆盖列表全部内容
  void resetList(List<CommonIllust> list) {
    this.list.clear();
    this.list.addAll(list);
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  void addAllToList({required List<CommonIllust> list}) {
    this.list.addAll(list);
    notifyListeners();
  }

  void clearList() {
    list.clear();
    notifyListeners();
  }
}
