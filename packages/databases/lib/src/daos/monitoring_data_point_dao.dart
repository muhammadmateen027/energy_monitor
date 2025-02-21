import 'package:drift/drift.dart';

import '../../databases.dart';
import '../tables/tables.dart';

part 'monitoring_data_point_dao.g.dart';

@DriftAccessor(tables: [MonitoringDataPoint])
class MonitoringDataPointDao extends DatabaseAccessor<AppDatabase>
    with _$MonitoringDataPointDaoMixin {
  MonitoringDataPointDao(super.db);

  Future<void> insertEntries(List<MonitoringDataPointCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(monitoringDataPoint, entries);
    });
  }

  Future<int> insertOrUpdate(MonitoringDataPointCompanion entry) async {
    final existingEntry = await (select(monitoringDataPoint)
          ..where((tbl) =>
              tbl.amount.equals(entry.amount.value) &
              tbl.category.equals(entry.category.value)))
        .getSingleOrNull();

    if (existingEntry != null) {
      return (update(monitoringDataPoint)
            ..where((tbl) => tbl.id.equals(existingEntry.id)))
          .write(entry);
    } else {
      return into(monitoringDataPoint).insert(entry);
    }
  }

  Future<List<MonitoringDataPointEntry>> getEntriesByCategoryAndDate(
      String category, DateTime date) {
    return (select(monitoringDataPoint)
          ..where(
              (tbl) => tbl.category.equals(category) & tbl.amount.equals(date)))
        .get();
  }

  Future<bool> exists(String category, DateTime date) async {
    final query = select(monitoringDataPoint)
      ..where((tbl) => tbl.category.equals(category) & tbl.amount.equals(date));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<int> deleteEntriesByCategoryAndDate(String category, DateTime date) {
    return (delete(monitoringDataPoint)
          ..where(
              (tbl) => tbl.category.equals(category) & tbl.amount.equals(date)))
        .go();
  }

  Future<int> deleteAllEntries() {
    return delete(monitoringDataPoint).go();
  }
}
