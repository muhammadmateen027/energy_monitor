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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<DateTime> amount = GeneratedColumn<DateTime>(
      'amount', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<int> description = GeneratedColumn<int>(
      'description', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category, amount, description];
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
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
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
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}description'])!,
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
  final DateTime amount;
  final int description;
  const MonitoringDataPointEntry(
      {required this.id,
      required this.category,
      required this.amount,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<DateTime>(amount);
    map['description'] = Variable<int>(description);
    return map;
  }

  MonitoringDataPointCompanion toCompanion(bool nullToAbsent) {
    return MonitoringDataPointCompanion(
      id: Value(id),
      category: Value(category),
      amount: Value(amount),
      description: Value(description),
    );
  }

  factory MonitoringDataPointEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonitoringDataPointEntry(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<DateTime>(json['amount']),
      description: serializer.fromJson<int>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<DateTime>(amount),
      'description': serializer.toJson<int>(description),
    };
  }

  MonitoringDataPointEntry copyWith(
          {int? id, String? category, DateTime? amount, int? description}) =>
      MonitoringDataPointEntry(
        id: id ?? this.id,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        description: description ?? this.description,
      );
  MonitoringDataPointEntry copyWithCompanion(
      MonitoringDataPointCompanion data) {
    return MonitoringDataPointEntry(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringDataPointEntry(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, amount, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonitoringDataPointEntry &&
          other.id == this.id &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description);
}

class MonitoringDataPointCompanion
    extends UpdateCompanion<MonitoringDataPointEntry> {
  final Value<int> id;
  final Value<String> category;
  final Value<DateTime> amount;
  final Value<int> description;
  const MonitoringDataPointCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
  });
  MonitoringDataPointCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required DateTime amount,
    required int description,
  })  : category = Value(category),
        amount = Value(amount),
        description = Value(description);
  static Insertable<MonitoringDataPointEntry> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<DateTime>? amount,
    Expression<int>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
    });
  }

  MonitoringDataPointCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<DateTime>? amount,
      Value<int>? description}) {
    return MonitoringDataPointCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
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
    if (amount.present) {
      map['amount'] = Variable<DateTime>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<int>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringDataPointCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description')
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
  required DateTime amount,
  required int description,
});
typedef $$MonitoringDataPointTableUpdateCompanionBuilder
    = MonitoringDataPointCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<DateTime> amount,
  Value<int> description,
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

  ColumnFilters<DateTime> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<DateTime> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<DateTime> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
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
            Value<DateTime> amount = const Value.absent(),
            Value<int> description = const Value.absent(),
          }) =>
              MonitoringDataPointCompanion(
            id: id,
            category: category,
            amount: amount,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            required DateTime amount,
            required int description,
          }) =>
              MonitoringDataPointCompanion.insert(
            id: id,
            category: category,
            amount: amount,
            description: description,
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
