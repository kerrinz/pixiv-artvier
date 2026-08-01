import 'package:drift/drift.dart';

/// 小说阅读进度
class NovelReadingProgressTable extends Table {
  /// 小说 Id
  TextColumn get novelId => text()();

  /// 当前段落序号（正文行 / 章节标题），从 0 起
  IntColumn get paragraphIndex => integer()();

  /// 当前页码，与书签一致，从 1 起
  IntColumn get page => integer().withDefault(const Constant(1))();

  /// 最后阅读时间
  DateTimeColumn get lastTime => dateTime().withDefault(currentDate)();

  @override
  Set<Column> get primaryKey => {novelId};
}
