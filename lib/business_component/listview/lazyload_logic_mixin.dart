import 'package:artvier/global/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';

mixin LazyloadLogic {
  Future<bool> Function() get onLazyload;

  /// 懒加载状态
  final lazyloadStateProvider = StateProvider.autoDispose<LazyloadState>((ref) {
    return LazyloadState.idle;
  });

  /// 当懒加载组件进入界面视图范围内时触发
  Future<void> handleViewLazyloadWidget(WidgetRef ref, Function onLazyload) async {
    if ([LazyloadState.loading, LazyloadState.noMore].contains(ref.read(lazyloadStateProvider))) {
      // 已经在加载中或者没有更多数据，不允许触发
      return;
    }
    try {
      bool hasMore = await onLazyload();
      ref.read(lazyloadStateProvider.notifier).update((state) => hasMore ? LazyloadState.idle : LazyloadState.noMore);
    } catch (e) {
      logger.e(e.toString());
      ref.read(lazyloadStateProvider.notifier).update((state) => LazyloadState.error);
    }
  }

  /// 加载失败的重试
  Future<void> handleRetry(WidgetRef ref) async {
    ref.read(lazyloadStateProvider.notifier).update((state) => LazyloadState.loading);
    try {
      bool hasMore = await onLazyload();
      ref.read(lazyloadStateProvider.notifier).update((state) => hasMore ? LazyloadState.idle : LazyloadState.noMore);
    } catch (e) {
      logger.e(e.toString());
      ref.read(lazyloadStateProvider.notifier).update((state) => LazyloadState.error);
    }
  }
}
