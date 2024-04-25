import 'package:artvier/storage/database/table/download_task.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:artvier/config/enums.dart';
import 'package:path/path.dart' as p;

part 'downloads_db.g.dart';

@DriftDatabase(tables: [DownloadTaskTable])
class DownloadsDatabase extends _$DownloadsDatabase {
  DownloadsDatabase() : super(_openConnection());

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

  /// 更新任务的状态
  Future updateTaskStatus(int taskId, DownloadState downloadState) {
    return (update(downloadTaskTable)..where((t) => t.taskId.equals(taskId))).write(
      DownloadTaskTableCompanion(
        status: Value(downloadState),
      ),
    );
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
