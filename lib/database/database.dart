// database.dart
import 'package:artvier/config/enums.dart';
import 'package:artvier/database/tables/viewing_history_table.dart';
import 'package:artvier/database/tables/download_task_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

AppDatabase appDatabase = AppDatabase();

@DriftDatabase(tables: [ViewingHistoryTable, DownloadTaskTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 从 ViewingHistoryDatabase 迁移的方法
  Future<ViewingHistoryTableData> addRecordWithRemoveDuplicates(ViewingHistoryTableData data) async {
    delete(viewingHistoryTable)
      ..where((tbl) => Expression.and([tbl.type.equalsValue(data.type), tbl.worksId.equals(data.worksId)]))
      ..go();
    return await into(viewingHistoryTable).insertReturning(data);
  }

  Future<List<ViewingHistoryTableData>> clearAllViewingHistory() async {
    return delete(viewingHistoryTable).goAndReturn();
  }

  Future<int> countAllViewingHistory() async {
    var count = viewingHistoryTable.count();
    return count.getSingle();
  }

  Future<List<ViewingHistoryTableData>> getViewingHistoryList({int page = 1, int pageSize = 100}) async {
    return (viewingHistoryTable.select()
          ..orderBy([(u) => OrderingTerm.desc(u.lastTime)])
          ..limit(pageSize, offset: (page - 1) * pageSize))
        .get();
  }

  // 从 DownloadsDatabase 迁移的方法
  Future<DownloadTaskTableData> addDownloadTask(DownloadTaskTableCompanion data) async {
    return await into(downloadTaskTable).insertReturning(data);
  }

  Future updateTaskBytes(int taskId, int receivedBytes, int totalBytes) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        receivedBytes: Value(receivedBytes),
        totalBytes: Value(totalBytes),
      ),
    );
  }

  Future updateTask(DownloadTaskTableData data) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(data.taskId!))).write(data.toCompanion(true));
  }

  Future updateTaskStatus(int taskId, DownloadState downloadState) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        status: Value(downloadState),
      ),
    );
  }

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

  Future<DownloadTaskTableData?> findTask(int taskId) {
    return (downloadTaskTable.select()..where((tbl) => tbl.taskId.equals(taskId))).getSingleOrNull();
  }

  Future<List<DownloadTaskTableData>> allDownloadTasks() async {
    return (downloadTaskTable.select()..orderBy([(u) => OrderingTerm.desc(u.taskId)])).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    return NativeDatabase(file);
  });
}
