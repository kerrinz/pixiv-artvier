import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 小说列表的通用Provider，附带了请求加载状态的管理
class NovelListProvider extends ChangeNotifier {
  /// 小说列表，[list.isEmpty]表示取得数据但无作品
  List<CommonNovel> list = [];

  LoadingStatus loadingStatus = LoadingStatus.loading;

  void resetNovels(List<CommonNovel> list, {LoadingStatus status = LoadingStatus.success}) {
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

  void appendNovels(List<CommonNovel> list) {
    this.list.addAll(list);
    notifyListeners();
  }

  void clearNovels() {
    list.clear();
    notifyListeners();
  }
}
