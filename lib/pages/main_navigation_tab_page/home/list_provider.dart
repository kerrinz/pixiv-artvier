import 'package:flutter/widgets.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class ListProvider with ChangeNotifier {
  List<CommonIllust> rankingList = []; // 排行榜列表

  bool isLoading = true; // 是否正在加载中

  void setData({required List<CommonIllust> rankingList, bool isLoading = false}) {
    this.rankingList = rankingList;
    this.isLoading = isLoading;
    notifyListeners();
  }

  void setRankingList({required List<CommonIllust> list}) {
    rankingList = list;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}