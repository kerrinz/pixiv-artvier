// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'viewing_history_db.dart';

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

abstract class _$ViewingHistoryDatabase extends GeneratedDatabase {
  _$ViewingHistoryDatabase(QueryExecutor e) : super(e);
  $ViewingHistoryDatabaseManager get managers =>
      $ViewingHistoryDatabaseManager(this);
  late final $ViewingHistoryTableTable viewingHistoryTable =
      $ViewingHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [viewingHistoryTable];
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
    extends Composer<_$ViewingHistoryDatabase, $ViewingHistoryTableTable> {
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
    extends Composer<_$ViewingHistoryDatabase, $ViewingHistoryTableTable> {
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
    extends Composer<_$ViewingHistoryDatabase, $ViewingHistoryTableTable> {
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
    _$ViewingHistoryDatabase,
    $ViewingHistoryTableTable,
    ViewingHistoryTableData,
    $$ViewingHistoryTableTableFilterComposer,
    $$ViewingHistoryTableTableOrderingComposer,
    $$ViewingHistoryTableTableAnnotationComposer,
    $$ViewingHistoryTableTableCreateCompanionBuilder,
    $$ViewingHistoryTableTableUpdateCompanionBuilder,
    (
      ViewingHistoryTableData,
      BaseReferences<_$ViewingHistoryDatabase, $ViewingHistoryTableTable,
          ViewingHistoryTableData>
    ),
    ViewingHistoryTableData,
    PrefetchHooks Function()> {
  $$ViewingHistoryTableTableTableManager(
      _$ViewingHistoryDatabase db, $ViewingHistoryTableTable table)
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
    _$ViewingHistoryDatabase,
    $ViewingHistoryTableTable,
    ViewingHistoryTableData,
    $$ViewingHistoryTableTableFilterComposer,
    $$ViewingHistoryTableTableOrderingComposer,
    $$ViewingHistoryTableTableAnnotationComposer,
    $$ViewingHistoryTableTableCreateCompanionBuilder,
    $$ViewingHistoryTableTableUpdateCompanionBuilder,
    (
      ViewingHistoryTableData,
      BaseReferences<_$ViewingHistoryDatabase, $ViewingHistoryTableTable,
          ViewingHistoryTableData>
    ),
    ViewingHistoryTableData,
    PrefetchHooks Function()>;

class $ViewingHistoryDatabaseManager {
  final _$ViewingHistoryDatabase _db;
  $ViewingHistoryDatabaseManager(this._db);
  $$ViewingHistoryTableTableTableManager get viewingHistoryTable =>
      $$ViewingHistoryTableTableTableManager(_db, _db.viewingHistoryTable);
}
