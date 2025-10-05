import 'dart:async';

import 'package:artvier/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///下载队列的状态管理
final downloadTaskQueueProvider =
    AutoDisposeAsyncNotifierProvider<DownloadsNotifier, List<DownloadTaskTableData>>(DownloadsNotifier.new);

class DownloadsNotifier extends AutoDisposeAsyncNotifier<List<DownloadTaskTableData>> {
  @override
  FutureOr<List<DownloadTaskTableData>> build() {
    return appDatabase.allDownloadTasks();
  }

  /// 更新状态
  updateState(List<DownloadTaskTableData> newState) {
    state = AsyncValue.data(newState);
  }

  /// 重新加载状态
  reloadState() {
    appDatabase.allDownloadTasks().then((value) {
      state = AsyncValue.data(value);
    });
  }
}
