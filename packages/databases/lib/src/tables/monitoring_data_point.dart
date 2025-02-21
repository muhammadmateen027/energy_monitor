import 'package:drift/drift.dart';

@DataClassName('MonitoringDataPointEntry')
class MonitoringDataPoint extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text()();

  DateTimeColumn get amount => dateTime()();

  IntColumn get description => integer()();
}
