import 'package:databases/databases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late MonitoringDataPointDao dao;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dao = database.monitoringDataPointDao;
  });

  tearDown(() async {
    await database.close();
  });

  group('MonitoringDataPointDao Tests', () {
    test('should insert multiple new entries', () async {
      final entries = [
        MonitoringDataPointCompanion.insert(
          category: 'Solar',
          timeStamp: DateTime(2024, 1, 20),
          value: 1,
        ),
        MonitoringDataPointCompanion.insert(
          category: 'Wind',
          timeStamp: DateTime(2024, 1, 21),
          value: 2,
        ),
      ];

      await dao.insertEntries(entries);

      final resultSolar =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(resultSolar.length, 1);
      expect(resultSolar.first.category, 'Solar');
      expect(resultSolar.first.timeStamp, DateTime(2024, 1, 20));
      expect(resultSolar.first.value, 1);

      final resultWind =
          await dao.getEntriesByCategoryAndDate('Wind', DateTime(2024, 1, 21));
      expect(resultWind.length, 1);
      expect(resultWind.first.category, 'Wind');
      expect(resultWind.first.timeStamp, DateTime(2024, 1, 21));
      expect(resultWind.first.value, 2);
    });

    test('should insert a new entry if it does not exist', () async {
      final entry = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 20),
        value: 1,
      );

      await dao.insertEntries([entry]);

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 1);
      expect(result.first.category, 'Solar');
      expect(result.first.timeStamp, DateTime(2024, 1, 20));
      expect(result.first.value, 1);
    });

    test('should read entries by category and date', () async {
      final entry1 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 20),
        value: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 21),
        value: 2,
      );

      await dao.insertEntries([entry1, entry2]);

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 1);
      expect(result.first.category, 'Solar');
      expect(result.first.timeStamp, DateTime(2024, 1, 20));
      expect(result.first.value, 1);
    });

    test('should check if an entry exists by category and date', () async {
      final entry = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 20),
        value: 1,
      );

      await dao.insertEntries([entry]);

      final exists = await dao.exists('Solar', DateTime(2024, 1, 20));
      expect(exists, true);

      final notExists = await dao.exists('Wind', DateTime(2024, 1, 20));
      expect(notExists, false);
    });

    test('should delete entries by category and date', () async {
      final entry1 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 20),
        value: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 21),
        value: 2,
      );

      await dao.insertEntries([entry1, entry2]);

      await dao.deleteEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 0);

      final remaining =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 21));
      expect(remaining.length, 1);
    });

    test('should delete all entries from the database', () async {
      final entry1 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        timeStamp: DateTime(2024, 1, 20),
        value: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Wind',
        timeStamp: DateTime(2024, 1, 21),
        value: 2,
      );

      await dao.insertEntries([entry1, entry2]);

      await dao.deleteAllEntries();

      final result1 =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result1.length, 0);

      final result2 =
          await dao.getEntriesByCategoryAndDate('Wind', DateTime(2024, 1, 21));
      expect(result2.length, 0);
    });
  });
}
