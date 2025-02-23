import 'package:drift/drift.dart';

import '../../databases.dart';
import '../tables/tables.dart';
import '../utils/date_time_range.dart';

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

  Future<List<MonitoringDataPointEntry>> getEntriesByCategoryAndDate(
      String category, DateTime date) {
    final range = DateTimeRange.getDayRange(date);

    final entries = (select(monitoringDataPoint)
          ..where((tbl) =>
              tbl.category.equals(category) &
              tbl.timeStamp.isBetweenValues(range.start, range.end))
          ..orderBy([(t) => OrderingTerm(expression: t.timeStamp)]))
        .get();

    return entries;
  }

  Future<bool> exists(String category, DateTime date) async {
    final range = DateTimeRange.getDayRange(date);

    final query = select(monitoringDataPoint)
      ..where((tbl) =>
          tbl.category.equals(category) &
          tbl.timeStamp.isBetweenValues(range.start, range.end));
    final result = await query.get();

    return result.isNotEmpty;
  }

  Future<int> deleteEntriesByCategoryAndDate(String category, DateTime date) {
    final range = DateTimeRange.getDayRange(date);

    return (delete(monitoringDataPoint)
          ..where((tbl) =>
              tbl.category.equals(category) &
              tbl.timeStamp.isBetweenValues(range.start, range.end)))
        .go();
  }

  Future<int> deleteEntriesByCategory(String category) {
    return (delete(monitoringDataPoint)
          ..where((tbl) => tbl.category.equals(category)))
        .go();
  }

  Future<int> deleteAllEntries() {
    return delete(monitoringDataPoint).go();
  }
}
