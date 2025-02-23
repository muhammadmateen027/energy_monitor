// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MonitoringDataPointTable extends MonitoringDataPoint
    with TableInfo<$MonitoringDataPointTable, MonitoringDataPointEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonitoringDataPointTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
      'value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category, timeStamp, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monitoring_data_point';
  @override
  VerificationContext validateIntegrity(
      Insertable<MonitoringDataPointEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonitoringDataPointEntry map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonitoringDataPointEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_stamp'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $MonitoringDataPointTable createAlias(String alias) {
    return $MonitoringDataPointTable(attachedDatabase, alias);
  }
}

class MonitoringDataPointEntry extends DataClass
    implements Insertable<MonitoringDataPointEntry> {
  final int id;
  final String category;
  final DateTime timeStamp;
  final int value;
  const MonitoringDataPointEntry(
      {required this.id,
      required this.category,
      required this.timeStamp,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    map['value'] = Variable<int>(value);
    return map;
  }

  MonitoringDataPointCompanion toCompanion(bool nullToAbsent) {
    return MonitoringDataPointCompanion(
      id: Value(id),
      category: Value(category),
      timeStamp: Value(timeStamp),
      value: Value(value),
    );
  }

  factory MonitoringDataPointEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonitoringDataPointEntry(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
      'value': serializer.toJson<int>(value),
    };
  }

  MonitoringDataPointEntry copyWith(
          {int? id, String? category, DateTime? timeStamp, int? value}) =>
      MonitoringDataPointEntry(
        id: id ?? this.id,
        category: category ?? this.category,
        timeStamp: timeStamp ?? this.timeStamp,
        value: value ?? this.value,
      );
  MonitoringDataPointEntry copyWithCompanion(
      MonitoringDataPointCompanion data) {
    return MonitoringDataPointEntry(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringDataPointEntry(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, timeStamp, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonitoringDataPointEntry &&
          other.id == this.id &&
          other.category == this.category &&
          other.timeStamp == this.timeStamp &&
          other.value == this.value);
}

class MonitoringDataPointCompanion
    extends UpdateCompanion<MonitoringDataPointEntry> {
  final Value<int> id;
  final Value<String> category;
  final Value<DateTime> timeStamp;
  final Value<int> value;
  const MonitoringDataPointCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.value = const Value.absent(),
  });
  MonitoringDataPointCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required DateTime timeStamp,
    required int value,
  })  : category = Value(category),
        timeStamp = Value(timeStamp),
        value = Value(value);
  static Insertable<MonitoringDataPointEntry> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<DateTime>? timeStamp,
    Expression<int>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (value != null) 'value': value,
    });
  }

  MonitoringDataPointCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<DateTime>? timeStamp,
      Value<int>? value}) {
    return MonitoringDataPointCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      timeStamp: timeStamp ?? this.timeStamp,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringDataPointCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MonitoringDataPointTable monitoringDataPoint =
      $MonitoringDataPointTable(this);
  late final MonitoringDataPointDao monitoringDataPointDao =
      MonitoringDataPointDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [monitoringDataPoint];
}

typedef $$MonitoringDataPointTableCreateCompanionBuilder
    = MonitoringDataPointCompanion Function({
  Value<int> id,
  required String category,
  required DateTime timeStamp,
  required int value,
});
typedef $$MonitoringDataPointTableUpdateCompanionBuilder
    = MonitoringDataPointCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<DateTime> timeStamp,
  Value<int> value,
});

class $$MonitoringDataPointTableFilterComposer
    extends Composer<_$AppDatabase, $MonitoringDataPointTable> {
  $$MonitoringDataPointTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$MonitoringDataPointTableOrderingComposer
    extends Composer<_$AppDatabase, $MonitoringDataPointTable> {
  $$MonitoringDataPointTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$MonitoringDataPointTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonitoringDataPointTable> {
  $$MonitoringDataPointTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get timeStamp =>
      $composableBuilder(column: $table.timeStamp, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MonitoringDataPointTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonitoringDataPointTable,
    MonitoringDataPointEntry,
    $$MonitoringDataPointTableFilterComposer,
    $$MonitoringDataPointTableOrderingComposer,
    $$MonitoringDataPointTableAnnotationComposer,
    $$MonitoringDataPointTableCreateCompanionBuilder,
    $$MonitoringDataPointTableUpdateCompanionBuilder,
    (
      MonitoringDataPointEntry,
      BaseReferences<_$AppDatabase, $MonitoringDataPointTable,
          MonitoringDataPointEntry>
    ),
    MonitoringDataPointEntry,
    PrefetchHooks Function()> {
  $$MonitoringDataPointTableTableManager(
      _$AppDatabase db, $MonitoringDataPointTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonitoringDataPointTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonitoringDataPointTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonitoringDataPointTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<DateTime> timeStamp = const Value.absent(),
            Value<int> value = const Value.absent(),
          }) =>
              MonitoringDataPointCompanion(
            id: id,
            category: category,
            timeStamp: timeStamp,
            value: value,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            required DateTime timeStamp,
            required int value,
          }) =>
              MonitoringDataPointCompanion.insert(
            id: id,
            category: category,
            timeStamp: timeStamp,
            value: value,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonitoringDataPointTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonitoringDataPointTable,
    MonitoringDataPointEntry,
    $$MonitoringDataPointTableFilterComposer,
    $$MonitoringDataPointTableOrderingComposer,
    $$MonitoringDataPointTableAnnotationComposer,
    $$MonitoringDataPointTableCreateCompanionBuilder,
    $$MonitoringDataPointTableUpdateCompanionBuilder,
    (
      MonitoringDataPointEntry,
      BaseReferences<_$AppDatabase, $MonitoringDataPointTable,
          MonitoringDataPointEntry>
    ),
    MonitoringDataPointEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MonitoringDataPointTableTableManager get monitoringDataPoint =>
      $$MonitoringDataPointTableTableManager(_db, _db.monitoringDataPoint);
}
