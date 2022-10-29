import 'package:pixgem/common_provider/base_provider.dart';

/// 加载状态
enum LoadingStatus {
  loading,
  failed,
  success,
}

/// 请求数据的加载状态时专用的Provider
class LoadingRequestProvider extends BaseProvider {
  // 懒加载状态
  LoadingStatus loadingStatus = LoadingStatus.loading;

  LoadingRequestProvider({
    this.loadingStatus = LoadingStatus.loading,
  });

  void setLoadingStatus(LoadingStatus status) {
    if (loadingStatus != status) {
      loadingStatus = status;
      notifyListeners();
    }
  }
}
