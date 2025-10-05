// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'downloads_db.dart';

// ignore_for_file: type=lint
class $DownloadTaskTableTable extends DownloadTaskTable
    with TableInfo<$DownloadTaskTableTable, DownloadTaskTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadTaskTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
      'task_id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
      defaultValue: const Constant(1));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _worksIdMeta =
      const VerificationMeta('worksId');
  @override
  late final GeneratedColumn<String> worksId = GeneratedColumn<String>(
      'works_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _downloadUrlMeta =
      const VerificationMeta('downloadUrl');
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
      'download_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _savePathMeta =
      const VerificationMeta('savePath');
  @override
  late final GeneratedColumn<String> savePath = GeneratedColumn<String>(
      'save_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _previewImageUrlMeta =
      const VerificationMeta('previewImageUrl');
  @override
  late final GeneratedColumn<String> previewImageUrl = GeneratedColumn<String>(
      'preview_image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalBytesMeta =
      const VerificationMeta('totalBytes');
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
      'total_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _receivedBytesMeta =
      const VerificationMeta('receivedBytes');
  @override
  late final GeneratedColumn<int> receivedBytes = GeneratedColumn<int>(
      'received_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<DownloadType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DownloadType>($DownloadTaskTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<DownloadState, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DownloadState>(
              $DownloadTaskTableTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
        taskId,
        title,
        worksId,
        downloadUrl,
        savePath,
        previewImageUrl,
        totalBytes,
        receivedBytes,
        type,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_task_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DownloadTaskTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('works_id')) {
      context.handle(_worksIdMeta,
          worksId.isAcceptableOrUnknown(data['works_id']!, _worksIdMeta));
    } else if (isInserting) {
      context.missing(_worksIdMeta);
    }
    if (data.containsKey('download_url')) {
      context.handle(
          _downloadUrlMeta,
          downloadUrl.isAcceptableOrUnknown(
              data['download_url']!, _downloadUrlMeta));
    } else if (isInserting) {
      context.missing(_downloadUrlMeta);
    }
    if (data.containsKey('save_path')) {
      context.handle(_savePathMeta,
          savePath.isAcceptableOrUnknown(data['save_path']!, _savePathMeta));
    }
    if (data.containsKey('preview_image_url')) {
      context.handle(
          _previewImageUrlMeta,
          previewImageUrl.isAcceptableOrUnknown(
              data['preview_image_url']!, _previewImageUrlMeta));
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
          _totalBytesMeta,
          totalBytes.isAcceptableOrUnknown(
              data['total_bytes']!, _totalBytesMeta));
    }
    if (data.containsKey('received_bytes')) {
      context.handle(
          _receivedBytesMeta,
          receivedBytes.isAcceptableOrUnknown(
              data['received_bytes']!, _receivedBytesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId};
  @override
  DownloadTaskTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadTaskTableData(
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      worksId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}works_id'])!,
      downloadUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}download_url'])!,
      savePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}save_path']),
      previewImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}preview_image_url']),
      totalBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_bytes'])!,
      receivedBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}received_bytes'])!,
      type: $DownloadTaskTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      status: $DownloadTaskTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
    );
  }

  @override
  $DownloadTaskTableTable createAlias(String alias) {
    return $DownloadTaskTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DownloadType, String, String> $convertertype =
      const EnumNameConverter<DownloadType>(DownloadType.values);
  static JsonTypeConverter2<DownloadState, String, String> $converterstatus =
      const EnumNameConverter<DownloadState>(DownloadState.values);
}

class DownloadTaskTableData extends DataClass
    implements Insertable<DownloadTaskTableData> {
  /// 任务 Id
  final int? taskId;

  /// 标题
  final String title;

  /// 作品 Id
  final String worksId;

  /// 下载链接
  final String downloadUrl;

  /// 保存路径
  final String? savePath;

  /// 预览图片链接（必须是小图）
  final String? previewImageUrl;

  /// 总大小
  final int totalBytes;

  /// 已下载大小
  final int receivedBytes;

  /// 资源类型
  final DownloadType type;

  /// 下载状态
  final DownloadState status;
  const DownloadTaskTableData(
      {this.taskId,
      required this.title,
      required this.worksId,
      required this.downloadUrl,
      this.savePath,
      this.previewImageUrl,
      required this.totalBytes,
      required this.receivedBytes,
      required this.type,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<int>(taskId);
    }
    map['title'] = Variable<String>(title);
    map['works_id'] = Variable<String>(worksId);
    map['download_url'] = Variable<String>(downloadUrl);
    if (!nullToAbsent || savePath != null) {
      map['save_path'] = Variable<String>(savePath);
    }
    if (!nullToAbsent || previewImageUrl != null) {
      map['preview_image_url'] = Variable<String>(previewImageUrl);
    }
    map['total_bytes'] = Variable<int>(totalBytes);
    map['received_bytes'] = Variable<int>(receivedBytes);
    {
      map['type'] =
          Variable<String>($DownloadTaskTableTable.$convertertype.toSql(type));
    }
    {
      map['status'] = Variable<String>(
          $DownloadTaskTableTable.$converterstatus.toSql(status));
    }
    return map;
  }

  DownloadTaskTableCompanion toCompanion(bool nullToAbsent) {
    return DownloadTaskTableCompanion(
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      title: Value(title),
      worksId: Value(worksId),
      downloadUrl: Value(downloadUrl),
      savePath: savePath == null && nullToAbsent
          ? const Value.absent()
          : Value(savePath),
      previewImageUrl: previewImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(previewImageUrl),
      totalBytes: Value(totalBytes),
      receivedBytes: Value(receivedBytes),
      type: Value(type),
      status: Value(status),
    );
  }

  factory DownloadTaskTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadTaskTableData(
      taskId: serializer.fromJson<int?>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      worksId: serializer.fromJson<String>(json['worksId']),
      downloadUrl: serializer.fromJson<String>(json['downloadUrl']),
      savePath: serializer.fromJson<String?>(json['savePath']),
      previewImageUrl: serializer.fromJson<String?>(json['previewImageUrl']),
      totalBytes: serializer.fromJson<int>(json['totalBytes']),
      receivedBytes: serializer.fromJson<int>(json['receivedBytes']),
      type: $DownloadTaskTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      status: $DownloadTaskTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<int?>(taskId),
      'title': serializer.toJson<String>(title),
      'worksId': serializer.toJson<String>(worksId),
      'downloadUrl': serializer.toJson<String>(downloadUrl),
      'savePath': serializer.toJson<String?>(savePath),
      'previewImageUrl': serializer.toJson<String?>(previewImageUrl),
      'totalBytes': serializer.toJson<int>(totalBytes),
      'receivedBytes': serializer.toJson<int>(receivedBytes),
      'type': serializer
          .toJson<String>($DownloadTaskTableTable.$convertertype.toJson(type)),
      'status': serializer.toJson<String>(
          $DownloadTaskTableTable.$converterstatus.toJson(status)),
    };
  }

  DownloadTaskTableData copyWith(
          {Value<int?> taskId = const Value.absent(),
          String? title,
          String? worksId,
          String? downloadUrl,
          Value<String?> savePath = const Value.absent(),
          Value<String?> previewImageUrl = const Value.absent(),
          int? totalBytes,
          int? receivedBytes,
          DownloadType? type,
          DownloadState? status}) =>
      DownloadTaskTableData(
        taskId: taskId.present ? taskId.value : this.taskId,
        title: title ?? this.title,
        worksId: worksId ?? this.worksId,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        savePath: savePath.present ? savePath.value : this.savePath,
        previewImageUrl: previewImageUrl.present
            ? previewImageUrl.value
            : this.previewImageUrl,
        totalBytes: totalBytes ?? this.totalBytes,
        receivedBytes: receivedBytes ?? this.receivedBytes,
        type: type ?? this.type,
        status: status ?? this.status,
      );
  DownloadTaskTableData copyWithCompanion(DownloadTaskTableCompanion data) {
    return DownloadTaskTableData(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      worksId: data.worksId.present ? data.worksId.value : this.worksId,
      downloadUrl:
          data.downloadUrl.present ? data.downloadUrl.value : this.downloadUrl,
      savePath: data.savePath.present ? data.savePath.value : this.savePath,
      previewImageUrl: data.previewImageUrl.present
          ? data.previewImageUrl.value
          : this.previewImageUrl,
      totalBytes:
          data.totalBytes.present ? data.totalBytes.value : this.totalBytes,
      receivedBytes: data.receivedBytes.present
          ? data.receivedBytes.value
          : this.receivedBytes,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTaskTableData(')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('worksId: $worksId, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('savePath: $savePath, ')
          ..write('previewImageUrl: $previewImageUrl, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('receivedBytes: $receivedBytes, ')
          ..write('type: $type, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, title, worksId, downloadUrl, savePath,
      previewImageUrl, totalBytes, receivedBytes, type, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadTaskTableData &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.worksId == this.worksId &&
          other.downloadUrl == this.downloadUrl &&
          other.savePath == this.savePath &&
          other.previewImageUrl == this.previewImageUrl &&
          other.totalBytes == this.totalBytes &&
          other.receivedBytes == this.receivedBytes &&
          other.type == this.type &&
          other.status == this.status);
}

class DownloadTaskTableCompanion
    extends UpdateCompanion<DownloadTaskTableData> {
  final Value<int?> taskId;
  final Value<String> title;
  final Value<String> worksId;
  final Value<String> downloadUrl;
  final Value<String?> savePath;
  final Value<String?> previewImageUrl;
  final Value<int> totalBytes;
  final Value<int> receivedBytes;
  final Value<DownloadType> type;
  final Value<DownloadState> status;
  const DownloadTaskTableCompanion({
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.worksId = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.savePath = const Value.absent(),
    this.previewImageUrl = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.receivedBytes = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
  });
  DownloadTaskTableCompanion.insert({
    this.taskId = const Value.absent(),
    required String title,
    required String worksId,
    required String downloadUrl,
    this.savePath = const Value.absent(),
    this.previewImageUrl = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.receivedBytes = const Value.absent(),
    required DownloadType type,
    required DownloadState status,
  })  : title = Value(title),
        worksId = Value(worksId),
        downloadUrl = Value(downloadUrl),
        type = Value(type),
        status = Value(status);
  static Insertable<DownloadTaskTableData> custom({
    Expression<int>? taskId,
    Expression<String>? title,
    Expression<String>? worksId,
    Expression<String>? downloadUrl,
    Expression<String>? savePath,
    Expression<String>? previewImageUrl,
    Expression<int>? totalBytes,
    Expression<int>? receivedBytes,
    Expression<String>? type,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (worksId != null) 'works_id': worksId,
      if (downloadUrl != null) 'download_url': downloadUrl,
      if (savePath != null) 'save_path': savePath,
      if (previewImageUrl != null) 'preview_image_url': previewImageUrl,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (receivedBytes != null) 'received_bytes': receivedBytes,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
    });
  }

  DownloadTaskTableCompanion copyWith(
      {Value<int?>? taskId,
      Value<String>? title,
      Value<String>? worksId,
      Value<String>? downloadUrl,
      Value<String?>? savePath,
      Value<String?>? previewImageUrl,
      Value<int>? totalBytes,
      Value<int>? receivedBytes,
      Value<DownloadType>? type,
      Value<DownloadState>? status}) {
    return DownloadTaskTableCompanion(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      worksId: worksId ?? this.worksId,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      savePath: savePath ?? this.savePath,
      previewImageUrl: previewImageUrl ?? this.previewImageUrl,
      totalBytes: totalBytes ?? this.totalBytes,
      receivedBytes: receivedBytes ?? this.receivedBytes,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (worksId.present) {
      map['works_id'] = Variable<String>(worksId.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    if (savePath.present) {
      map['save_path'] = Variable<String>(savePath.value);
    }
    if (previewImageUrl.present) {
      map['preview_image_url'] = Variable<String>(previewImageUrl.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (receivedBytes.present) {
      map['received_bytes'] = Variable<int>(receivedBytes.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $DownloadTaskTableTable.$convertertype.toSql(type.value));
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $DownloadTaskTableTable.$converterstatus.toSql(status.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTaskTableCompanion(')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('worksId: $worksId, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('savePath: $savePath, ')
          ..write('previewImageUrl: $previewImageUrl, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('receivedBytes: $receivedBytes, ')
          ..write('type: $type, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$DownloadsDatabase extends GeneratedDatabase {
  _$DownloadsDatabase(QueryExecutor e) : super(e);
  $DownloadsDatabaseManager get managers => $DownloadsDatabaseManager(this);
  late final $DownloadTaskTableTable downloadTaskTable =
      $DownloadTaskTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [downloadTaskTable];
}

typedef $$DownloadTaskTableTableCreateCompanionBuilder
    = DownloadTaskTableCompanion Function({
  Value<int?> taskId,
  required String title,
  required String worksId,
  required String downloadUrl,
  Value<String?> savePath,
  Value<String?> previewImageUrl,
  Value<int> totalBytes,
  Value<int> receivedBytes,
  required DownloadType type,
  required DownloadState status,
});
typedef $$DownloadTaskTableTableUpdateCompanionBuilder
    = DownloadTaskTableCompanion Function({
  Value<int?> taskId,
  Value<String> title,
  Value<String> worksId,
  Value<String> downloadUrl,
  Value<String?> savePath,
  Value<String?> previewImageUrl,
  Value<int> totalBytes,
  Value<int> receivedBytes,
  Value<DownloadType> type,
  Value<DownloadState> status,
});

class $$DownloadTaskTableTableFilterComposer
    extends Composer<_$DownloadsDatabase, $DownloadTaskTableTable> {
  $$DownloadTaskTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get worksId => $composableBuilder(
      column: $table.worksId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get savePath => $composableBuilder(
      column: $table.savePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get receivedBytes => $composableBuilder(
      column: $table.receivedBytes, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DownloadType, DownloadType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<DownloadState, DownloadState, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$DownloadTaskTableTableOrderingComposer
    extends Composer<_$DownloadsDatabase, $DownloadTaskTableTable> {
  $$DownloadTaskTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get worksId => $composableBuilder(
      column: $table.worksId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get savePath => $composableBuilder(
      column: $table.savePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get receivedBytes => $composableBuilder(
      column: $table.receivedBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$DownloadTaskTableTableAnnotationComposer
    extends Composer<_$DownloadsDatabase, $DownloadTaskTableTable> {
  $$DownloadTaskTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get worksId =>
      $composableBuilder(column: $table.worksId, builder: (column) => column);

  GeneratedColumn<String> get downloadUrl => $composableBuilder(
      column: $table.downloadUrl, builder: (column) => column);

  GeneratedColumn<String> get savePath =>
      $composableBuilder(column: $table.savePath, builder: (column) => column);

  GeneratedColumn<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl, builder: (column) => column);

  GeneratedColumn<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => column);

  GeneratedColumn<int> get receivedBytes => $composableBuilder(
      column: $table.receivedBytes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DownloadType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DownloadState, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$DownloadTaskTableTableTableManager extends RootTableManager<
    _$DownloadsDatabase,
    $DownloadTaskTableTable,
    DownloadTaskTableData,
    $$DownloadTaskTableTableFilterComposer,
    $$DownloadTaskTableTableOrderingComposer,
    $$DownloadTaskTableTableAnnotationComposer,
    $$DownloadTaskTableTableCreateCompanionBuilder,
    $$DownloadTaskTableTableUpdateCompanionBuilder,
    (
      DownloadTaskTableData,
      BaseReferences<_$DownloadsDatabase, $DownloadTaskTableTable,
          DownloadTaskTableData>
    ),
    DownloadTaskTableData,
    PrefetchHooks Function()> {
  $$DownloadTaskTableTableTableManager(
      _$DownloadsDatabase db, $DownloadTaskTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadTaskTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadTaskTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadTaskTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> taskId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> worksId = const Value.absent(),
            Value<String> downloadUrl = const Value.absent(),
            Value<String?> savePath = const Value.absent(),
            Value<String?> previewImageUrl = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<int> receivedBytes = const Value.absent(),
            Value<DownloadType> type = const Value.absent(),
            Value<DownloadState> status = const Value.absent(),
          }) =>
              DownloadTaskTableCompanion(
            taskId: taskId,
            title: title,
            worksId: worksId,
            downloadUrl: downloadUrl,
            savePath: savePath,
            previewImageUrl: previewImageUrl,
            totalBytes: totalBytes,
            receivedBytes: receivedBytes,
            type: type,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int?> taskId = const Value.absent(),
            required String title,
            required String worksId,
            required String downloadUrl,
            Value<String?> savePath = const Value.absent(),
            Value<String?> previewImageUrl = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<int> receivedBytes = const Value.absent(),
            required DownloadType type,
            required DownloadState status,
          }) =>
              DownloadTaskTableCompanion.insert(
            taskId: taskId,
            title: title,
            worksId: worksId,
            downloadUrl: downloadUrl,
            savePath: savePath,
            previewImageUrl: previewImageUrl,
            totalBytes: totalBytes,
            receivedBytes: receivedBytes,
            type: type,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DownloadTaskTableTableProcessedTableManager = ProcessedTableManager<
    _$DownloadsDatabase,
    $DownloadTaskTableTable,
    DownloadTaskTableData,
    $$DownloadTaskTableTableFilterComposer,
    $$DownloadTaskTableTableOrderingComposer,
    $$DownloadTaskTableTableAnnotationComposer,
    $$DownloadTaskTableTableCreateCompanionBuilder,
    $$DownloadTaskTableTableUpdateCompanionBuilder,
    (
      DownloadTaskTableData,
      BaseReferences<_$DownloadsDatabase, $DownloadTaskTableTable,
          DownloadTaskTableData>
    ),
    DownloadTaskTableData,
    PrefetchHooks Function()>;

class $DownloadsDatabaseManager {
  final _$DownloadsDatabase _db;
  $DownloadsDatabaseManager(this._db);
  $$DownloadTaskTableTableTableManager get downloadTaskTable =>
      $$DownloadTaskTableTableTableManager(_db, _db.downloadTaskTable);
}
