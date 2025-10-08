import 'package:artvier/config/enums.dart';
import 'package:drift/drift.dart';

/// 搜索历史的数据库表
class SearchHistoryTable extends Table {
  /// 搜索文本
  TextColumn get searchText => text()();

  /// 作品类型
  TextColumn get type => textEnum<SearchType>()();

  /// 最后搜索时间
  DateTimeColumn get lastTime => dateTime().withDefault(currentDate)();
}
