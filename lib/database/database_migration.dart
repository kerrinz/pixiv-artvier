// database_migration.dart
import 'dart:io';
import 'package:artvier/global/logger.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/database/deprecated/downloads/downloads_db.dart' hide DownloadTaskTableCompanion;
import 'package:artvier/database/deprecated/viewing_history/viewing_history_db.dart' hide ViewingHistoryTableCompanion;
import 'package:artvier/global/variable.dart';
import 'package:artvier/preferences/software_update_store.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 合并和迁移数据库
class DatabaseMigration {
  /// 是否需要合并
  static Future<bool> needsMigration() async {
    final softwareUpdateStorage = SoftwareUpdateStorage(globalSharedPreferences);
    final isAlreadyMigratedToV1 = softwareUpdateStorage.isAlreadyMigratedToV1();
    if (isAlreadyMigratedToV1) return false;

    final appDir = await getApplicationDocumentsDirectory();
    final viewingHistoryDb = File(p.join(appDir.path, 'viewing_history.db'));
    final downloadsDb = File(p.join(appDir.path, 'downloads.db'));

    return await viewingHistoryDb.exists() || await downloadsDb.exists();
  }

  /// 合并成为新数据库
  static Future<void> migrateToNewDatabase(AppDatabase newDatabase) async {
    final appDir = await getApplicationDocumentsDirectory();

    await _migrateViewingHistory(newDatabase, appDir);
    await _migrateDownloads(newDatabase, appDir);

    await _cleanupOldDatabases(appDir);

    // 标记合并迁移成功
    final softwareUpdateStorage = SoftwareUpdateStorage(globalSharedPreferences);
    softwareUpdateStorage.setAlreadyMigratedToV1(true);
  }

  /// 合并浏览历史记录
  static Future<void> _migrateViewingHistory(AppDatabase newDb, Directory appDir) async {
    final oldDbPath = p.join(appDir.path, 'viewing_history.db');
    final oldDbFile = File(oldDbPath);

    if (!await oldDbFile.exists()) return;

    // ignore: deprecated_member_use_from_same_package
    final oldDb = ViewingHistoryDatabase();

    try {
      final historyRecords = await oldDb.getList(pageSize: 10000);

      // 替代方案：手动创建 Companion
      for (final record in historyRecords) {
        await newDb.into(newDb.viewingHistoryTable).insert(
            ViewingHistoryTableCompanion(
              title: Value(record.title),
              type: Value(record.type),
              worksId: Value(record.worksId),
              authorName: Value(record.authorName),
              previewImageUrl: Value(record.previewImageUrl),
              lastTime: Value(record.lastTime),
            ),
            mode: InsertMode.insertOrReplace);
      }

      logger.d('迁移了 ${historyRecords.length} 条浏览历史记录');
    } finally {
      await oldDb.close();
    }
  }

  /// 合并下载记录
  static Future<void> _migrateDownloads(AppDatabase newDb, Directory appDir) async {
    final oldDbPath = p.join(appDir.path, 'downloads.db');
    final oldDbFile = File(oldDbPath);

    if (!await oldDbFile.exists()) return;

    // ignore: deprecated_member_use_from_same_package
    final oldDb = DownloadsDatabase();

    try {
      final downloadTasks = await oldDb.allDownloadTasks();

      for (final task in downloadTasks) {
        await newDb.into(newDb.downloadTaskTable).insert(
            DownloadTaskTableCompanion(
              taskId: Value(task.taskId),
              title: Value(task.title),
              worksId: Value(task.worksId),
              downloadUrl: Value(task.downloadUrl),
              savePath: Value(task.savePath),
              previewImageUrl: Value(task.previewImageUrl),
              totalBytes: Value(task.totalBytes),
              receivedBytes: Value(task.receivedBytes),
              type: Value(task.type),
              status: Value(task.status),
            ),
            mode: InsertMode.insertOrReplace);
      }

      logger.d('迁移了 ${downloadTasks.length} 条下载任务记录');
    } finally {
      await oldDb.close();
    }
  }

  /// 清除旧数据库
  static Future<void> _cleanupOldDatabases(Directory appDir) async {
    final viewingHistoryDb = File(p.join(appDir.path, 'viewing_history.db'));
    final downloadsDb = File(p.join(appDir.path, 'downloads.db'));

    if (await viewingHistoryDb.exists()) {
      await viewingHistoryDb.delete();
    }

    if (await downloadsDb.exists()) {
      await downloadsDb.delete();
    }
  }
}
