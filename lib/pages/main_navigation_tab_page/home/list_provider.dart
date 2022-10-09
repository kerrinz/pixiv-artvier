import 'package:flutter/widgets.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class HomeTabPageIllustProvider with ChangeNotifier {
  /// 排行榜列表
  /// [List.isEmpty]表示取得数据但无作品
  List<CommonIllust> rankingList = [];
  /// 推荐列表
  List<CommonIllust> recomendlist = [];
  LoadingStatus loadingStatus = LoadingStatus.loading;

  /// 覆盖全部
  void resetAll(
    List<CommonIllust> rankingList,
    List<CommonIllust> recomendlist,
    LoadingStatus status,
  ) {
    this.rankingList.clear();
    this.recomendlist.clear();
    this.rankingList.addAll(rankingList);
    this.recomendlist.addAll(recomendlist);
    loadingStatus = status;
    notifyListeners();
  }

  /// 覆盖推荐列表内容
  void resetRecomendList(List<CommonIllust> recomendlist) {
    this.recomendlist.clear();
    this.recomendlist.addAll(recomendlist);
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  // 添加更多到推荐列表
  void addAllToRecomendList(List<CommonIllust> moreList) {
    recomendlist.addAll(moreList);
    notifyListeners();
  }

  void clearAllList() {
    rankingList.clear();
    recomendlist.clear();
    notifyListeners();
  }
}
