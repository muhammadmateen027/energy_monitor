import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/daos.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [MonitoringDataPoint], daos: [MonitoringDataPointDao])
class AppDatabase extends _$AppDatabase {
  /// Creates an instance of [AppDatabase].
  AppDatabase() : super(_connect());

  /// Creates an instance of [AppDatabase] for testing purposes.
  @visibleForTesting
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

/// Connects to the database and returns a [LazyDatabase] instance.
///
/// This function sets up the database connection by determining the
/// appropriate file path for the SQLite database and creating a
/// [NativeDatabase] instance.
///
/// Returns:
///   A [LazyDatabase] instance configured to use the SQLite database
///   located at the determined file path.
LazyDatabase _connect() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'energy_monitoring.db'));
    return NativeDatabase(file);
  });
}
