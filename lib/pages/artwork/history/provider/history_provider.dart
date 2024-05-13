import 'dart:async';

import 'package:artvier/storage/viewing_history/viewing_history_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 浏览历史的状态管理
final viewingHistoryProvider =
    AutoDisposeAsyncNotifierProvider<DownloadsNotifier, List<ViewingHistoryTableData>>(DownloadsNotifier.new);

class DownloadsNotifier extends AutoDisposeAsyncNotifier<List<ViewingHistoryTableData>> {
  int page = 1;
  int pageSize = 1000;
  int count = 0;

  @override
  FutureOr<List<ViewingHistoryTableData>> build() async {
    count = await viewingHistoryDatabase.countAll();
    var value = await viewingHistoryDatabase.getList(page: page, pageSize: pageSize);
    return value;
  }

  /// 更新状态
  updateState(List<ViewingHistoryTableData> newState) {
    state = AsyncValue.data(newState);
  }

  /// 清空历史记录
  Future<List<ViewingHistoryTableData>> clearAll() async {
    // 旧表设计失误，以移除数据库作为清空
    await viewingHistoryDatabase.close();
    await viewingHistoryDatabase.deleteDatabase();
    state = const AsyncValue.data([]);
    viewingHistoryDatabase = ViewingHistoryDatabase();
    return [];
  }

  /// 重新加载状态
  reloadState() {
    return viewingHistoryDatabase.getList().then((value) {
      state = AsyncValue.data(value);
    });
  }

  /// 下一页
  Future<bool> nextPage() async {
    var value = await viewingHistoryDatabase.getList(page: page, pageSize: pageSize);
    update((p0) => value);
    return false;
  }
}
