import 'package:drift/drift.dart';

@DataClassName('MonitoringDataPointEntry')
class MonitoringDataPoint extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text()();

  DateTimeColumn get timeStamp => dateTime()();

  IntColumn get value => integer()();
}
