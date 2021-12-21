import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

class IllustWaterfallProvider extends ChangeNotifier {
  List<CommonIllust> list = []; // 图片含基本信息的列表

  void setList(List<CommonIllust> list) {
    this.list = list;
    notifyListeners();
  }

  void updateIllust(CommonIllust illust, int index) {
    list[index] = illust;
    notifyListeners();
  }

  void addNextIllust({required List<CommonIllust> list}) {
    this.list = [...this.list, ...list];
    notifyListeners();
  }

  void clearList() {
    list.clear();
    notifyListeners();
  }
}
