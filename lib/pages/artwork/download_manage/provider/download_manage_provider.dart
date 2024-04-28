import 'dart:async';

import 'package:artvier/storage/database/downloads_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// TODO: 后续不再放全局，且不用的时候要 close 释放资源
final downloadsDatabase = DownloadsDatabase();

///下载队列的状态管理
final downloadTaskQueueProvider =
    AutoDisposeAsyncNotifierProvider<DownloadsNotifier, List<DownloadTaskTableData>>(DownloadsNotifier.new);

class DownloadsNotifier extends AutoDisposeAsyncNotifier<List<DownloadTaskTableData>> {
  @override
  FutureOr<List<DownloadTaskTableData>> build() {
    return downloadsDatabase.allDownloadTasks();
  }

  /// 更新状态
  updateState(List<DownloadTaskTableData> newState) {
    state = AsyncValue.data(newState);
  }

  /// 重新加载状态
  reloadState() {
    downloadsDatabase.allDownloadTasks().then((value) {
      state = AsyncValue.data(value);
    });
  }
}
