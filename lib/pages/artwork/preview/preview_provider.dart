import 'package:pixgem/common_provider/base_provider.dart';

class PreviewProvider extends BaseProvider {
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
