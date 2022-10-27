import 'package:flutter/widgets.dart';

/// 加载状态
enum LoadingStatus {
  loading,
  failed,
  success,
}

/// 请求数据的加载状态时专用的Provider
class LoadingRequestProvider extends ChangeNotifier {
  // 懒加载状态
  LoadingStatus loadingStatus = LoadingStatus.loading;

  LoadingRequestProvider({
    this.loadingStatus = LoadingStatus.loading,
  });

  notify() => notifyListeners();

  void setLazyloadStatus(LoadingStatus status) {
    if (loadingStatus != status) {
      loadingStatus = status;
      notifyListeners();
    }
  }
}
