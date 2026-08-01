// database.dart
import 'package:artvier/config/enums.dart';
import 'package:artvier/database/tables/novel_reading_progress_table.dart';
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

/// 小说阅读进度最多保留条数（按 lastTime 淘汰最旧）
const int kNovelReadingProgressLimit = 1000;

@DriftDatabase(tables: [ViewingHistoryTable, DownloadTaskTable, SearchHistoryTable, NovelReadingProgressTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(novelReadingProgressTable);
          }
        },
      );

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

  /// 添加搜索历史记录，重复时自动替换已有的记录
  Future<List<SearchHistoryTableData>> deleteSearchHistory(String searchText) async {
    final statement = delete(searchHistoryTable)
      ..where((tbl) => Expression.and([tbl.searchText.trim().equals(searchText.trim())]));
    return statement.goAndReturn();
  }

  /// 清空搜索历史记录
  Future<List<SearchHistoryTableData>> clearAllSearchHistory() async {
    return delete(searchHistoryTable).goAndReturn();
  }

  /// 获取单本小说的阅读进度
  Future<NovelReadingProgressTableData?> getNovelReadingProgress(String novelId) {
    return (novelReadingProgressTable.select()..where((tbl) => tbl.novelId.equals(novelId))).getSingleOrNull();
  }

  /// 保存小说阅读进度；超出上限时淘汰最旧记录
  Future<void> saveNovelReadingProgress({
    required String novelId,
    required int paragraphIndex,
    required int page,
  }) async {
    await into(novelReadingProgressTable).insertOnConflictUpdate(
      NovelReadingProgressTableCompanion.insert(
        novelId: novelId,
        paragraphIndex: paragraphIndex,
        page: Value(page),
        lastTime: Value(DateTime.now()),
      ),
    );

    final count = await novelReadingProgressTable.count().getSingle();
    if (count <= kNovelReadingProgressLimit) return;

    final overflow = count - kNovelReadingProgressLimit;
    final oldest = await (novelReadingProgressTable.select()
          ..orderBy([(u) => OrderingTerm.asc(u.lastTime)])
          ..limit(overflow))
        .get();
    if (oldest.isEmpty) return;

    await (delete(novelReadingProgressTable)
          ..where((tbl) => tbl.novelId.isIn(oldest.map((e) => e.novelId))))
        .go();
  }

  /// 删除单本小说的阅读进度
  Future<int> deleteNovelReadingProgress(String novelId) {
    return (delete(novelReadingProgressTable)..where((tbl) => tbl.novelId.equals(novelId))).go();
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
