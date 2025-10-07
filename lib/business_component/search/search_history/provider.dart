import 'dart:async';

import 'package:artvier/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 搜索历史的状态管理
final searchHistoryProvider =
    AutoDisposeAsyncNotifierProvider<SearchHistoryNotifier, List<SearchHistoryTableData>>(SearchHistoryNotifier.new);

class SearchHistoryNotifier extends AutoDisposeAsyncNotifier<List<SearchHistoryTableData>> {
  @override
  FutureOr<List<SearchHistoryTableData>> build() async {
    var value = await appDatabase.allSearchHistory();
    return value;
  }

  /// 更新状态
  updateState(List<SearchHistoryTableData> newState) {
    state = AsyncValue.data(newState);
  }

  /// 添加搜索历史
  addSearchHistory(SearchHistoryTableData data) async {
    await appDatabase.addSearchHistory(data);
    reloadState();
  }

  /// 清空历史记录
  Future<List<SearchHistoryTableData>> clearAll() async {
    await appDatabase.clearAllSearchHistory();
    state = const AsyncValue.data([]);
    return [];
  }

  /// 重新加载状态
  reloadState() {
    return appDatabase.allSearchHistory().then((value) {
      state = AsyncValue.data(value);
    });
  }
}
