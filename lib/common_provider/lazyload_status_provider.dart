import 'package:flutter/widgets.dart';

/// 懒加载状态
enum LazyloadStatus {
  loading,
  failed,
  /// 没有更多了
  noMore,
}

/// 懒加载更新状态时专用的Provider
class LazyloadStatusProvider extends ChangeNotifier {
  // 懒加载状态
  LazyloadStatus lazyloadStatus;

  LazyloadStatusProvider({
    this.lazyloadStatus = LazyloadStatus.loading,
  });

  notify() => notifyListeners();

  void setLazyloadStatus(LazyloadStatus status) {
    if(lazyloadStatus != status) {
      lazyloadStatus = status;
      notifyListeners();
    }
  }
}
