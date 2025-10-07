// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'database.dart';

// ignore_for_file: type=lint
class $ViewingHistoryTableTable extends ViewingHistoryTable
    with TableInfo<$ViewingHistoryTableTable, ViewingHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViewingHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<WorksType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WorksType>($ViewingHistoryTableTable.$convertertype);
  static const VerificationMeta _worksIdMeta =
      const VerificationMeta('worksId');
  @override
  late final GeneratedColumn<String> worksId = GeneratedColumn<String>(
      'works_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _previewImageUrlMeta =
      const VerificationMeta('previewImageUrl');
  @override
  late final GeneratedColumn<String> previewImageUrl = GeneratedColumn<String>(
      'preview_image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastTimeMeta =
      const VerificationMeta('lastTime');
  @override
  late final GeneratedColumn<DateTime> lastTime = GeneratedColumn<DateTime>(
      'last_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  List<GeneratedColumn> get $columns =>
      [title, type, worksId, authorName, previewImageUrl, lastTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viewing_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ViewingHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    }
    if (data.containsKey('preview_image_url')) {
      context.handle(
          _previewImageUrlMeta,
          previewImageUrl.isAcceptableOrUnknown(
              data['preview_image_url']!, _previewImageUrlMeta));
    }
    if (data.containsKey('last_time')) {
      context.handle(_lastTimeMeta,
          lastTime.isAcceptableOrUnknown(data['last_time']!, _lastTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ViewingHistoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ViewingHistoryTableData(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: $ViewingHistoryTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      worksId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}works_id'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name']),
      previewImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}preview_image_url']),
      lastTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_time'])!,
    );
  }

  @override
  $ViewingHistoryTableTable createAlias(String alias) {
    return $ViewingHistoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorksType, String, String> $convertertype =
      const EnumNameConverter<WorksType>(WorksType.values);
}

class ViewingHistoryTableData extends DataClass
    implements Insertable<ViewingHistoryTableData> {
  /// 标题
  final String title;

  /// 作品类型
  final WorksType type;

  /// 作品 Id
  final String worksId;

  /// 作者
  final String? authorName;

  /// 预览图片链接（必须是小图）
  final String? previewImageUrl;

  /// 最后浏览时间
  final DateTime lastTime;
  const ViewingHistoryTableData(
      {required this.title,
      required this.type,
      required this.worksId,
      this.authorName,
      this.previewImageUrl,
      required this.lastTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    {
      map['type'] = Variable<String>(
          $ViewingHistoryTableTable.$convertertype.toSql(type));
    }
    map['works_id'] = Variable<String>(worksId);
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    if (!nullToAbsent || previewImageUrl != null) {
      map['preview_image_url'] = Variable<String>(previewImageUrl);
    }
    map['last_time'] = Variable<DateTime>(lastTime);
    return map;
  }

  ViewingHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return ViewingHistoryTableCompanion(
      title: Value(title),
      type: Value(type),
      worksId: Value(worksId),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
      previewImageUrl: previewImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(previewImageUrl),
      lastTime: Value(lastTime),
    );
  }

  factory ViewingHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ViewingHistoryTableData(
      title: serializer.fromJson<String>(json['title']),
      type: $ViewingHistoryTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      worksId: serializer.fromJson<String>(json['worksId']),
      authorName: serializer.fromJson<String?>(json['authorName']),
      previewImageUrl: serializer.fromJson<String?>(json['previewImageUrl']),
      lastTime: serializer.fromJson<DateTime>(json['lastTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(
          $ViewingHistoryTableTable.$convertertype.toJson(type)),
      'worksId': serializer.toJson<String>(worksId),
      'authorName': serializer.toJson<String?>(authorName),
      'previewImageUrl': serializer.toJson<String?>(previewImageUrl),
      'lastTime': serializer.toJson<DateTime>(lastTime),
    };
  }

  ViewingHistoryTableData copyWith(
          {String? title,
          WorksType? type,
          String? worksId,
          Value<String?> authorName = const Value.absent(),
          Value<String?> previewImageUrl = const Value.absent(),
          DateTime? lastTime}) =>
      ViewingHistoryTableData(
        title: title ?? this.title,
        type: type ?? this.type,
        worksId: worksId ?? this.worksId,
        authorName: authorName.present ? authorName.value : this.authorName,
        previewImageUrl: previewImageUrl.present
            ? previewImageUrl.value
            : this.previewImageUrl,
        lastTime: lastTime ?? this.lastTime,
      );
  ViewingHistoryTableData copyWithCompanion(ViewingHistoryTableCompanion data) {
    return ViewingHistoryTableData(
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      worksId: data.worksId.present ? data.worksId.value : this.worksId,
      authorName:
          data.authorName.present ? data.authorName.value : this.authorName,
      previewImageUrl: data.previewImageUrl.present
          ? data.previewImageUrl.value
          : this.previewImageUrl,
      lastTime: data.lastTime.present ? data.lastTime.value : this.lastTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ViewingHistoryTableData(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('worksId: $worksId, ')
          ..write('authorName: $authorName, ')
          ..write('previewImageUrl: $previewImageUrl, ')
          ..write('lastTime: $lastTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(title, type, worksId, authorName, previewImageUrl, lastTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViewingHistoryTableData &&
          other.title == this.title &&
          other.type == this.type &&
          other.worksId == this.worksId &&
          other.authorName == this.authorName &&
          other.previewImageUrl == this.previewImageUrl &&
          other.lastTime == this.lastTime);
}

class ViewingHistoryTableCompanion
    extends UpdateCompanion<ViewingHistoryTableData> {
  final Value<String> title;
  final Value<WorksType> type;
  final Value<String> worksId;
  final Value<String?> authorName;
  final Value<String?> previewImageUrl;
  final Value<DateTime> lastTime;
  final Value<int> rowid;
  const ViewingHistoryTableCompanion({
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.worksId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.previewImageUrl = const Value.absent(),
    this.lastTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ViewingHistoryTableCompanion.insert({
    required String title,
    required WorksType type,
    required String worksId,
    this.authorName = const Value.absent(),
    this.previewImageUrl = const Value.absent(),
    this.lastTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        type = Value(type),
        worksId = Value(worksId);
  static Insertable<ViewingHistoryTableData> custom({
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? worksId,
    Expression<String>? authorName,
    Expression<String>? previewImageUrl,
    Expression<DateTime>? lastTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (worksId != null) 'works_id': worksId,
      if (authorName != null) 'author_name': authorName,
      if (previewImageUrl != null) 'preview_image_url': previewImageUrl,
      if (lastTime != null) 'last_time': lastTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ViewingHistoryTableCompanion copyWith(
      {Value<String>? title,
      Value<WorksType>? type,
      Value<String>? worksId,
      Value<String?>? authorName,
      Value<String?>? previewImageUrl,
      Value<DateTime>? lastTime,
      Value<int>? rowid}) {
    return ViewingHistoryTableCompanion(
      title: title ?? this.title,
      type: type ?? this.type,
      worksId: worksId ?? this.worksId,
      authorName: authorName ?? this.authorName,
      previewImageUrl: previewImageUrl ?? this.previewImageUrl,
      lastTime: lastTime ?? this.lastTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $ViewingHistoryTableTable.$convertertype.toSql(type.value));
    }
    if (worksId.present) {
      map['works_id'] = Variable<String>(worksId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (previewImageUrl.present) {
      map['preview_image_url'] = Variable<String>(previewImageUrl.value);
    }
    if (lastTime.present) {
      map['last_time'] = Variable<DateTime>(lastTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewingHistoryTableCompanion(')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('worksId: $worksId, ')
          ..write('authorName: $authorName, ')
          ..write('previewImageUrl: $previewImageUrl, ')
          ..write('lastTime: $lastTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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

class $SearchHistoryTableTable extends SearchHistoryTable
    with TableInfo<$SearchHistoryTableTable, SearchHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _searchTextMeta =
      const VerificationMeta('searchText');
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
      'search_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<SearchType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SearchType>($SearchHistoryTableTable.$convertertype);
  static const VerificationMeta _lastTimeMeta =
      const VerificationMeta('lastTime');
  @override
  late final GeneratedColumn<DateTime> lastTime = GeneratedColumn<DateTime>(
      'last_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  List<GeneratedColumn> get $columns => [searchText, type, lastTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SearchHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_text')) {
      context.handle(
          _searchTextMeta,
          searchText.isAcceptableOrUnknown(
              data['search_text']!, _searchTextMeta));
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('last_time')) {
      context.handle(_lastTimeMeta,
          lastTime.isAcceptableOrUnknown(data['last_time']!, _lastTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SearchHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryTableData(
      searchText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}search_text'])!,
      type: $SearchHistoryTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      lastTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_time'])!,
    );
  }

  @override
  $SearchHistoryTableTable createAlias(String alias) {
    return $SearchHistoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SearchType, String, String> $convertertype =
      const EnumNameConverter<SearchType>(SearchType.values);
}

class SearchHistoryTableData extends DataClass
    implements Insertable<SearchHistoryTableData> {
  /// 搜索文本
  final String searchText;

  /// 作品类型
  final SearchType type;

  /// 最后搜索时间
  final DateTime lastTime;
  const SearchHistoryTableData(
      {required this.searchText, required this.type, required this.lastTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_text'] = Variable<String>(searchText);
    {
      map['type'] =
          Variable<String>($SearchHistoryTableTable.$convertertype.toSql(type));
    }
    map['last_time'] = Variable<DateTime>(lastTime);
    return map;
  }

  SearchHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryTableCompanion(
      searchText: Value(searchText),
      type: Value(type),
      lastTime: Value(lastTime),
    );
  }

  factory SearchHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryTableData(
      searchText: serializer.fromJson<String>(json['searchText']),
      type: $SearchHistoryTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      lastTime: serializer.fromJson<DateTime>(json['lastTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchText': serializer.toJson<String>(searchText),
      'type': serializer
          .toJson<String>($SearchHistoryTableTable.$convertertype.toJson(type)),
      'lastTime': serializer.toJson<DateTime>(lastTime),
    };
  }

  SearchHistoryTableData copyWith(
          {String? searchText, SearchType? type, DateTime? lastTime}) =>
      SearchHistoryTableData(
        searchText: searchText ?? this.searchText,
        type: type ?? this.type,
        lastTime: lastTime ?? this.lastTime,
      );
  SearchHistoryTableData copyWithCompanion(SearchHistoryTableCompanion data) {
    return SearchHistoryTableData(
      searchText:
          data.searchText.present ? data.searchText.value : this.searchText,
      type: data.type.present ? data.type.value : this.type,
      lastTime: data.lastTime.present ? data.lastTime.value : this.lastTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryTableData(')
          ..write('searchText: $searchText, ')
          ..write('type: $type, ')
          ..write('lastTime: $lastTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(searchText, type, lastTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryTableData &&
          other.searchText == this.searchText &&
          other.type == this.type &&
          other.lastTime == this.lastTime);
}

class SearchHistoryTableCompanion
    extends UpdateCompanion<SearchHistoryTableData> {
  final Value<String> searchText;
  final Value<SearchType> type;
  final Value<DateTime> lastTime;
  final Value<int> rowid;
  const SearchHistoryTableCompanion({
    this.searchText = const Value.absent(),
    this.type = const Value.absent(),
    this.lastTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistoryTableCompanion.insert({
    required String searchText,
    required SearchType type,
    this.lastTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : searchText = Value(searchText),
        type = Value(type);
  static Insertable<SearchHistoryTableData> custom({
    Expression<String>? searchText,
    Expression<String>? type,
    Expression<DateTime>? lastTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (searchText != null) 'search_text': searchText,
      if (type != null) 'type': type,
      if (lastTime != null) 'last_time': lastTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistoryTableCompanion copyWith(
      {Value<String>? searchText,
      Value<SearchType>? type,
      Value<DateTime>? lastTime,
      Value<int>? rowid}) {
    return SearchHistoryTableCompanion(
      searchText: searchText ?? this.searchText,
      type: type ?? this.type,
      lastTime: lastTime ?? this.lastTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $SearchHistoryTableTable.$convertertype.toSql(type.value));
    }
    if (lastTime.present) {
      map['last_time'] = Variable<DateTime>(lastTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryTableCompanion(')
          ..write('searchText: $searchText, ')
          ..write('type: $type, ')
          ..write('lastTime: $lastTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ViewingHistoryTableTable viewingHistoryTable =
      $ViewingHistoryTableTable(this);
  late final $DownloadTaskTableTable downloadTaskTable =
      $DownloadTaskTableTable(this);
  late final $SearchHistoryTableTable searchHistoryTable =
      $SearchHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [viewingHistoryTable, downloadTaskTable, searchHistoryTable];
}

typedef $$ViewingHistoryTableTableCreateCompanionBuilder
    = ViewingHistoryTableCompanion Function({
  required String title,
  required WorksType type,
  required String worksId,
  Value<String?> authorName,
  Value<String?> previewImageUrl,
  Value<DateTime> lastTime,
  Value<int> rowid,
});
typedef $$ViewingHistoryTableTableUpdateCompanionBuilder
    = ViewingHistoryTableCompanion Function({
  Value<String> title,
  Value<WorksType> type,
  Value<String> worksId,
  Value<String?> authorName,
  Value<String?> previewImageUrl,
  Value<DateTime> lastTime,
  Value<int> rowid,
});

class $$ViewingHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $ViewingHistoryTableTable> {
  $$ViewingHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorksType, WorksType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get worksId => $composableBuilder(
      column: $table.worksId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastTime => $composableBuilder(
      column: $table.lastTime, builder: (column) => ColumnFilters(column));
}

class $$ViewingHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ViewingHistoryTableTable> {
  $$ViewingHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get worksId => $composableBuilder(
      column: $table.worksId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTime => $composableBuilder(
      column: $table.lastTime, builder: (column) => ColumnOrderings(column));
}

class $$ViewingHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViewingHistoryTableTable> {
  $$ViewingHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorksType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get worksId =>
      $composableBuilder(column: $table.worksId, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
      column: $table.authorName, builder: (column) => column);

  GeneratedColumn<String> get previewImageUrl => $composableBuilder(
      column: $table.previewImageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTime =>
      $composableBuilder(column: $table.lastTime, builder: (column) => column);
}

class $$ViewingHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ViewingHistoryTableTable,
    ViewingHistoryTableData,
    $$ViewingHistoryTableTableFilterComposer,
    $$ViewingHistoryTableTableOrderingComposer,
    $$ViewingHistoryTableTableAnnotationComposer,
    $$ViewingHistoryTableTableCreateCompanionBuilder,
    $$ViewingHistoryTableTableUpdateCompanionBuilder,
    (
      ViewingHistoryTableData,
      BaseReferences<_$AppDatabase, $ViewingHistoryTableTable,
          ViewingHistoryTableData>
    ),
    ViewingHistoryTableData,
    PrefetchHooks Function()> {
  $$ViewingHistoryTableTableTableManager(
      _$AppDatabase db, $ViewingHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViewingHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViewingHistoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViewingHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> title = const Value.absent(),
            Value<WorksType> type = const Value.absent(),
            Value<String> worksId = const Value.absent(),
            Value<String?> authorName = const Value.absent(),
            Value<String?> previewImageUrl = const Value.absent(),
            Value<DateTime> lastTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ViewingHistoryTableCompanion(
            title: title,
            type: type,
            worksId: worksId,
            authorName: authorName,
            previewImageUrl: previewImageUrl,
            lastTime: lastTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String title,
            required WorksType type,
            required String worksId,
            Value<String?> authorName = const Value.absent(),
            Value<String?> previewImageUrl = const Value.absent(),
            Value<DateTime> lastTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ViewingHistoryTableCompanion.insert(
            title: title,
            type: type,
            worksId: worksId,
            authorName: authorName,
            previewImageUrl: previewImageUrl,
            lastTime: lastTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ViewingHistoryTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ViewingHistoryTableTable,
    ViewingHistoryTableData,
    $$ViewingHistoryTableTableFilterComposer,
    $$ViewingHistoryTableTableOrderingComposer,
    $$ViewingHistoryTableTableAnnotationComposer,
    $$ViewingHistoryTableTableCreateCompanionBuilder,
    $$ViewingHistoryTableTableUpdateCompanionBuilder,
    (
      ViewingHistoryTableData,
      BaseReferences<_$AppDatabase, $ViewingHistoryTableTable,
          ViewingHistoryTableData>
    ),
    ViewingHistoryTableData,
    PrefetchHooks Function()>;
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
    extends Composer<_$AppDatabase, $DownloadTaskTableTable> {
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
    extends Composer<_$AppDatabase, $DownloadTaskTableTable> {
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
    extends Composer<_$AppDatabase, $DownloadTaskTableTable> {
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
    _$AppDatabase,
    $DownloadTaskTableTable,
    DownloadTaskTableData,
    $$DownloadTaskTableTableFilterComposer,
    $$DownloadTaskTableTableOrderingComposer,
    $$DownloadTaskTableTableAnnotationComposer,
    $$DownloadTaskTableTableCreateCompanionBuilder,
    $$DownloadTaskTableTableUpdateCompanionBuilder,
    (
      DownloadTaskTableData,
      BaseReferences<_$AppDatabase, $DownloadTaskTableTable,
          DownloadTaskTableData>
    ),
    DownloadTaskTableData,
    PrefetchHooks Function()> {
  $$DownloadTaskTableTableTableManager(
      _$AppDatabase db, $DownloadTaskTableTable table)
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
    _$AppDatabase,
    $DownloadTaskTableTable,
    DownloadTaskTableData,
    $$DownloadTaskTableTableFilterComposer,
    $$DownloadTaskTableTableOrderingComposer,
    $$DownloadTaskTableTableAnnotationComposer,
    $$DownloadTaskTableTableCreateCompanionBuilder,
    $$DownloadTaskTableTableUpdateCompanionBuilder,
    (
      DownloadTaskTableData,
      BaseReferences<_$AppDatabase, $DownloadTaskTableTable,
          DownloadTaskTableData>
    ),
    DownloadTaskTableData,
    PrefetchHooks Function()>;
typedef $$SearchHistoryTableTableCreateCompanionBuilder
    = SearchHistoryTableCompanion Function({
  required String searchText,
  required SearchType type,
  Value<DateTime> lastTime,
  Value<int> rowid,
});
typedef $$SearchHistoryTableTableUpdateCompanionBuilder
    = SearchHistoryTableCompanion Function({
  Value<String> searchText,
  Value<SearchType> type,
  Value<DateTime> lastTime,
  Value<int> rowid,
});

class $$SearchHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get searchText => $composableBuilder(
      column: $table.searchText, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SearchType, SearchType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get lastTime => $composableBuilder(
      column: $table.lastTime, builder: (column) => ColumnFilters(column));
}

class $$SearchHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get searchText => $composableBuilder(
      column: $table.searchText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTime => $composableBuilder(
      column: $table.lastTime, builder: (column) => ColumnOrderings(column));
}

class $$SearchHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoryTableTable> {
  $$SearchHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get searchText => $composableBuilder(
      column: $table.searchText, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SearchType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTime =>
      $composableBuilder(column: $table.lastTime, builder: (column) => column);
}

class $$SearchHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SearchHistoryTableTable,
    SearchHistoryTableData,
    $$SearchHistoryTableTableFilterComposer,
    $$SearchHistoryTableTableOrderingComposer,
    $$SearchHistoryTableTableAnnotationComposer,
    $$SearchHistoryTableTableCreateCompanionBuilder,
    $$SearchHistoryTableTableUpdateCompanionBuilder,
    (
      SearchHistoryTableData,
      BaseReferences<_$AppDatabase, $SearchHistoryTableTable,
          SearchHistoryTableData>
    ),
    SearchHistoryTableData,
    PrefetchHooks Function()> {
  $$SearchHistoryTableTableTableManager(
      _$AppDatabase db, $SearchHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> searchText = const Value.absent(),
            Value<SearchType> type = const Value.absent(),
            Value<DateTime> lastTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchHistoryTableCompanion(
            searchText: searchText,
            type: type,
            lastTime: lastTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String searchText,
            required SearchType type,
            Value<DateTime> lastTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchHistoryTableCompanion.insert(
            searchText: searchText,
            type: type,
            lastTime: lastTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SearchHistoryTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SearchHistoryTableTable,
    SearchHistoryTableData,
    $$SearchHistoryTableTableFilterComposer,
    $$SearchHistoryTableTableOrderingComposer,
    $$SearchHistoryTableTableAnnotationComposer,
    $$SearchHistoryTableTableCreateCompanionBuilder,
    $$SearchHistoryTableTableUpdateCompanionBuilder,
    (
      SearchHistoryTableData,
      BaseReferences<_$AppDatabase, $SearchHistoryTableTable,
          SearchHistoryTableData>
    ),
    SearchHistoryTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ViewingHistoryTableTableTableManager get viewingHistoryTable =>
      $$ViewingHistoryTableTableTableManager(_db, _db.viewingHistoryTable);
  $$DownloadTaskTableTableTableManager get downloadTaskTable =>
      $$DownloadTaskTableTableTableManager(_db, _db.downloadTaskTable);
  $$SearchHistoryTableTableTableManager get searchHistoryTable =>
      $$SearchHistoryTableTableTableManager(_db, _db.searchHistoryTable);
}
