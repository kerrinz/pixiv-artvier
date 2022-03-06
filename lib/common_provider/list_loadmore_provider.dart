import 'package:flutter/widgets.dart';

///
/// 含有加载更多内容的列表的provider
///
class ListLoadmoreProvider<T> with ChangeNotifier {
  List<T>? list;
  String? nextUrl; // 下一页的地址

  void setAll(List<T>? list, String? nextUrl) {
    this.list = list;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  void setList(List<T> list) {
    this.list = list;
    notifyListeners();
  }

  void addAll(List<T> list) {
    this.list = [...this.list ?? [], ...list];
    notifyListeners();
  }

  void setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  void clear() {
    list?.clear();
    notifyListeners();
  }
}
