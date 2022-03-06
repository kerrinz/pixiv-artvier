import 'package:flutter/material.dart';

class ListProvider<T> extends ChangeNotifier {
  List<T>? list; // 为null表示未获得数据，isEmpty表示取得数据但无内容

  void setList(List<T>? list) {
    this.list = list;
    notifyListeners();
  }

  void updateItem(T item, int index) {
    list?[index] = item;
    notifyListeners();
  }

  void addAll(List<T> list) {
    list.addAll(list);
    // this.list = [...this.list ?? [], ...list];
    notifyListeners();
  }

  void clear() {
    list?.clear();
    notifyListeners();
  }
}
