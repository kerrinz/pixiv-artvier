import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';

/// 自定义泛型列表的Provider
class TListProvider<T> extends ChangeNotifier {
  List<T> list = [];

  LoadingStatus loadingStatus = LoadingStatus.loading;

  void resetNovels(List<T> list, {LoadingStatus status = LoadingStatus.success}) {
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

  void appendNovels(List<T> list) {
    this.list.addAll(list);
    notifyListeners();
  }

  void clearNovels() {
    list.clear();
    notifyListeners();
  }
}
