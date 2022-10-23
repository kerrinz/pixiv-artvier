import 'package:flutter/widgets.dart';

class PreviewProvider with ChangeNotifier {
  bool isHdMode = false; // 是否高清模式
  int currentPage = 0; // 当前页

  void setHdMode(bool isHdMode) {
    this.isHdMode = isHdMode;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }
}
