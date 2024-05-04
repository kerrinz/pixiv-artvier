import 'package:artvier/config/enums.dart';
import 'package:drift/drift.dart';

/// 浏览历史的数据库表
class ViewingHistoryTable extends Table {
  /// 标题
  TextColumn get title => text()();

  /// 作品类型
  TextColumn get type => textEnum<WorksType>().unique()();

  /// 作品 Id
  TextColumn get worksId => text().unique()();

  /// 作者
  TextColumn get authorName => text().nullable()();

  /// 预览图片链接（必须是小图）
  TextColumn get previewImageUrl => text().nullable()();

  /// 最后浏览时间
  DateTimeColumn get lastTime => dateTime().withDefault(currentDate)();
}
