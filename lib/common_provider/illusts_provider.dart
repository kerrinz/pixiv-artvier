import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustListProvider extends ChangeNotifier {
  List<CommonIllust>? list; // 插画列表，为null表示未获得数据，isEmpty表示取得数据但无插画

  void setList(List<CommonIllust>? list) {
    this.list = list;
    notifyListeners();
  }

  void updateIllust(CommonIllust illust, int index) {
    list?[index] = illust;
    notifyListeners();
  }

  void addNextIllust({required List<CommonIllust> list}) {
    this.list = [...this.list ?? [], ...list];
    notifyListeners();
  }

  void clearList() {
    list?.clear();
    notifyListeners();
  }
}
