import 'package:databases/databases.dart';
import 'package:drift/drift.dart';
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
    test('should insert a new entry if it does not exist', () async {
      final entry = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      final id = await dao.insertOrUpdate(entry);
      expect(id, 1);

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 1);
      expect(result.first.category, 'Solar');
      expect(result.first.amount, DateTime(2024, 1, 20));
      expect(result.first.description, 1);
    });

    test('should update an existing entry if it exists', () async {
      final entry = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      await dao.insertOrUpdate(entry);

      final updatedEntry = MonitoringDataPointCompanion(
        category: Value('Solar'),
        amount: Value(DateTime(2024, 1, 20)),
        description: Value(2),
      );

      final id = await dao.insertOrUpdate(updatedEntry);
      expect(id, 1);

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 1);
      expect(result.first.category, 'Solar');
      expect(result.first.amount, DateTime(2024, 1, 20));
      expect(result.first.description, 2);
    });

    test('should read entries by category and date', () async {
      final entry1 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 21),
        description: 2,
      );

      await dao.insertOrUpdate(entry1);
      await dao.insertOrUpdate(entry2);

      final result =
          await dao.getEntriesByCategoryAndDate('Solar', DateTime(2024, 1, 20));
      expect(result.length, 1);
      expect(result.first.category, 'Solar');
      expect(result.first.amount, DateTime(2024, 1, 20));
      expect(result.first.description, 1);
    });

    test('should check if an entry exists by category and date', () async {
      final entry = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      await dao.insertOrUpdate(entry);

      final exists = await dao.exists('Solar', DateTime(2024, 1, 20));
      expect(exists, true);

      final notExists = await dao.exists('Wind', DateTime(2024, 1, 20));
      expect(notExists, false);
    });

    test('should delete entries by category and date', () async {
      final entry1 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Solar',
        amount: DateTime(2024, 1, 21),
        description: 2,
      );

      await dao.insertOrUpdate(entry1);
      await dao.insertOrUpdate(entry2);

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
        amount: DateTime(2024, 1, 20),
        description: 1,
      );

      final entry2 = MonitoringDataPointCompanion.insert(
        category: 'Wind',
        amount: DateTime(2024, 1, 21),
        description: 2,
      );

      await dao.insertOrUpdate(entry1);
      await dao.insertOrUpdate(entry2);

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
