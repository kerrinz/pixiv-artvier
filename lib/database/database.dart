// database.dart
import 'package:artvier/config/enums.dart';
import 'package:artvier/database/tables/search_history_table.dart';
import 'package:artvier/database/tables/viewing_history_table.dart';
import 'package:artvier/database/tables/download_task_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

AppDatabase appDatabase = AppDatabase();

@DriftDatabase(tables: [ViewingHistoryTable, DownloadTaskTable, SearchHistoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 添加浏览历史记录，重复时自动替换已有的记录
  Future<ViewingHistoryTableData> addRecordWithRemoveDuplicates(ViewingHistoryTableData data) async {
    delete(viewingHistoryTable)
      ..where((tbl) => Expression.and([tbl.type.equalsValue(data.type), tbl.worksId.equals(data.worksId)]))
      ..go();
    return await into(viewingHistoryTable).insertReturning(data);
  }

  /// 清空浏览历史
  Future<List<ViewingHistoryTableData>> clearAllViewingHistory() async {
    return delete(viewingHistoryTable).goAndReturn();
  }

  /// 统计浏览历史
  Future<int> countAllViewingHistory() async {
    var count = viewingHistoryTable.count();
    return count.getSingle();
  }

  /// 获取浏览历史列表
  Future<List<ViewingHistoryTableData>> getViewingHistoryList({int page = 1, int pageSize = 100}) async {
    return (viewingHistoryTable.select()
          ..orderBy([(u) => OrderingTerm.desc(u.lastTime)])
          ..limit(pageSize, offset: (page - 1) * pageSize))
        .get();
  }

  /// 添加下载任务
  Future<DownloadTaskTableData> addDownloadTask(DownloadTaskTableCompanion data) async {
    return await into(downloadTaskTable).insertReturning(data);
  }

  /// 更新下载任务的进度
  Future updateTaskBytes(int taskId, int receivedBytes, int totalBytes) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        receivedBytes: Value(receivedBytes),
        totalBytes: Value(totalBytes),
      ),
    );
  }

  /// 更新下载任务
  Future updateTask(DownloadTaskTableData data) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(data.taskId!))).write(data.toCompanion(true));
  }

  /// 更新下载任务的状态
  Future updateTaskStatus(int taskId, DownloadState downloadState) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        status: Value(downloadState),
      ),
    );
  }

  /// 重置下载任务的状态
  Future resetDownloadStatus() {
    return (update(downloadTaskTable)..where((t) => t.status.equalsValue(DownloadState.downloading)))
        .write(
          const DownloadTaskTableCompanion(
            status: Value(DownloadState.failed),
          ),
        )
        .then(
          (value) => (update(downloadTaskTable)..where((t) => t.status.equalsValue(DownloadState.waiting))).write(
            const DownloadTaskTableCompanion(
              status: Value(DownloadState.paused),
            ),
          ),
        );
  }

  /// 找寻下载任务
  Future<DownloadTaskTableData?> findTask(int taskId) {
    return (downloadTaskTable.select()..where((tbl) => tbl.taskId.equals(taskId))).getSingleOrNull();
  }

  ///获取全部下载任务
  Future<List<DownloadTaskTableData>> allDownloadTasks() async {
    return (downloadTaskTable.select()..orderBy([(u) => OrderingTerm.desc(u.taskId)])).get();
  }

  /// 统计搜索历史记录数量
  Future<int> countAllSearchHistory() async {
    var count = searchHistoryTable.count();
    return count.getSingle();
  }

  /// 获取所有搜索历史记录
  Future<List<SearchHistoryTableData>> allSearchHistory() async {
    return (searchHistoryTable.select()..orderBy([(u) => OrderingTerm.desc(u.lastTime)])).get();
  }

  /// 添加搜索历史记录，重复时自动替换已有的记录
  Future<SearchHistoryTableData> addSearchHistory(SearchHistoryTableData data) async {
    // 去重
    delete(searchHistoryTable)
      ..where((tbl) => Expression.and([tbl.searchText.trim().equals(data.searchText.trim())]))
      ..goAndReturn();
    return await into(searchHistoryTable).insertReturning(data);
  }

  /// 清空搜索历史记录
  Future<List<SearchHistoryTableData>> clearAllSearchHistory() async {
    return delete(searchHistoryTable).goAndReturn();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    if (await file.exists()) {
      return NativeDatabase(file);
    } else {
      return NativeDatabase.createInBackground(file);
    }
  });
}
