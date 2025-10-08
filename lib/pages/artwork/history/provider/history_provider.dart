import 'dart:async';

import 'package:artvier/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 浏览历史的状态管理
final viewingHistoryProvider =
    AutoDisposeAsyncNotifierProvider<ViewingHistoryNotifier, List<ViewingHistoryTableData>>(ViewingHistoryNotifier.new);

class ViewingHistoryNotifier extends AutoDisposeAsyncNotifier<List<ViewingHistoryTableData>> {
  int page = 1;
  int pageSize = 1000;
  int count = 0;

  @override
  FutureOr<List<ViewingHistoryTableData>> build() async {
    count = await appDatabase.countAllViewingHistory();
    var value = await appDatabase.getViewingHistoryList(page: page, pageSize: pageSize);
    return value;
  }

  /// 更新状态
  updateState(List<ViewingHistoryTableData> newState) {
    state = AsyncValue.data(newState);
  }

  /// 清空历史记录
  Future<List<ViewingHistoryTableData>> clearAll() async {
    await appDatabase.clearAllViewingHistory();
    state = const AsyncValue.data([]);
    return [];
  }

  /// 重新加载状态
  reloadState() {
    return appDatabase.getViewingHistoryList().then((value) {
      state = AsyncValue.data(value);
    });
  }

  /// 下一页
  Future<bool> nextPage() async {
    var value = await appDatabase.getViewingHistoryList(page: page, pageSize: pageSize);
    update((p0) => value);
    return false;
  }
}
