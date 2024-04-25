import 'package:artvier/config/enums.dart';
import 'package:drift/drift.dart';

/// 下载任务的数据库表
class DownloadTaskTable extends Table {
  /// 任务 Id
  IntColumn get taskId => integer().nullable().withDefault(const Constant(1)).autoIncrement()();

  /// 标题
  TextColumn get title => text()();

  /// 作品 Id
  TextColumn get worksId => text()();

  /// 下载链接
  TextColumn get downloadUrl => text()();

  /// 保存路径
  TextColumn get savePath => text().nullable()();

  /// 预览图片链接（必须是小图）
  TextColumn get previewImageUrl => text().nullable()();

  /// 总大小
  Column<int> get totalBytes => integer().withDefault(const Constant(0))();
  
  /// 已下载大小
  Column<int> get receivedBytes => integer().withDefault(const Constant(0))();

  /// 资源类型
  TextColumn get type => textEnum<DownloadType>()();

  /// 下载状态
  TextColumn get status => textEnum<DownloadState>()();
}
