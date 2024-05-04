import 'package:artvier/config/enums.dart';
import 'package:artvier/storage/viewing_history/viewing_history_table.dart';
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'viewing_history_db.g.dart';

final ViewingHistoryDatabase viewingHistoryDatabase = ViewingHistoryDatabase();

@DriftDatabase(tables: [ViewingHistoryTable])
class ViewingHistoryDatabase extends _$ViewingHistoryDatabase {
  ViewingHistoryDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 添加记录，并且移除重复项
  Future<ViewingHistoryTableData> addRecordWithRemoveDuplicates(ViewingHistoryTableData data) async {
    delete(viewingHistoryTable)
      ..where((tbl) => Expression.and([tbl.type.equalsValue(data.type), tbl.worksId.equals(data.worksId)]))
      ..go();
    return await into(viewingHistoryTable).insertReturning(data);
  }

  /// 清空记录
  Future<List<ViewingHistoryTableData>> clearAll() async {
    return delete(viewingHistoryTable).goAndReturn();
  }

  /// 统计数量
  Future<int> countAll() async {
    var count = viewingHistoryTable.count();
    return count.getSingle();
  }

  /// 历史记录列表（按时间倒序）
  Future<List<ViewingHistoryTableData>> getList({int page = 1, int pageSize = 100}) async {
    return (viewingHistoryTable.select()
          ..orderBy([
            (u) => OrderingTerm.desc(u.lastTime),
          ])
          ..limit(pageSize, offset: (page - 1) * pageSize))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'viewing_history.db'));
    if (await file.exists()) {
      return NativeDatabase(file);
    } else {
      return NativeDatabase.createInBackground(file);
    }
  });
}
