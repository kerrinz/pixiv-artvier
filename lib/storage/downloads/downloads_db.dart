import 'package:artvier/storage/downloads/download_task_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:artvier/config/enums.dart';
import 'package:path/path.dart' as p;

part 'downloads_db.g.dart';

@DriftDatabase(tables: [DownloadTaskTable])
class DownloadsDatabase extends _$DownloadsDatabase {
  DownloadsDatabase() : super(_openConnection()) {
    resetStatus();
  }

  @override
  int get schemaVersion => 1;

  /// 添加下载任务
  Future<DownloadTaskTableData> addDownloadTask(DownloadTaskTableCompanion data) async {
    return await into(downloadTaskTable).insertReturning(data);
  }

  /// 更新任务的进度
  Future updateTaskBytes(int taskId, int receivedBytes, int totalBytes) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        receivedBytes: Value(receivedBytes),
        totalBytes: Value(totalBytes),
      ),
    );
  }

  /// 更新任务，taskId 不能为空
  Future updateTask(DownloadTaskTableData data) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(data.taskId!))).write(data.toCompanion(true));
  }

  /// 更新任务的状态
  Future updateTaskStatus(int taskId, DownloadState downloadState) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        status: Value(downloadState),
      ),
    );
  }

  /// 初次启动，将以前未下载完成的任务重置为下载失败，将等待的任务重置为暂停
  Future resetStatus() {
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

  /// 查找任务
  Future<DownloadTaskTableData?> findTask(int taskId) {
    return (downloadTaskTable.select()..where((tbl) => tbl.taskId.equals(taskId))).getSingleOrNull();
  }

  /// 下载任务列表（倒序）
  Future<List<DownloadTaskTableData>> allDownloadTasks() async {
    return (downloadTaskTable.select()
          ..orderBy([
            (u) => OrderingTerm.desc(u.taskId),
          ]))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'downloads.db'));
    if (await file.exists()) {
      return NativeDatabase(file);
    } else {
      return NativeDatabase.createInBackground(file);
    }
  });
}
