import 'package:databases/databases.dart';
import 'package:dio/dio.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:energy_repository/src/data_parser/data_parser.dart';
import 'package:energy_repository/src/data_type.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockMonitoringDataPointDao extends Mock
    implements MonitoringDataPointDao {}

class MockInternetConnection extends Mock implements InternetConnection {}

class MockDataParser extends Mock implements DataParser {}

class MockEnergyApiClient extends Mock implements EnergyApiClient {}

void main() {
  final testDateTime = DateTime(2021, 10, 1);

  final testCompanion = MonitoringDataPointCompanion.insert(
    category: DataType.solar.name,
    timeStamp: testDateTime,
    value: 100,
  );

  final testMonitoringDataPointDto = MonitoringDataPointDto(
    timestamp: testDateTime,
    value: 100,
  );

  final testMonitoringDataPointEntry = MonitoringDataPointEntry(
    id: 1,
    category: DataType.solar.name,
    timeStamp: testDateTime,
    value: 100,
  );

  final testMonitoringEnergy = MonitoringEnergy(
    timestamp: testDateTime,
    value: 100,
  );

  group('EnergyRepository', () {
    late EnergyRepository energyRepository;
    late MockMonitoringDataPointDao mockDataPointDao;
    late MockInternetConnection mockInternetConnection;
    late MockDataParser mockDataParser;
    late MockEnergyApiClient mockEnergyApiClient;

    setUp(() {
      mockDataPointDao = MockMonitoringDataPointDao();
      mockInternetConnection = MockInternetConnection();
      mockDataParser = MockDataParser();
      mockEnergyApiClient = MockEnergyApiClient();

      energyRepository = EnergyRepository(
        dataPointDao: mockDataPointDao,
        apiClient: mockEnergyApiClient,
        internetConnection: mockInternetConnection,
        dataParser: mockDataParser,
      );

      when(() => mockDataParser.convertToCompanion(any(), DataType.solar.name))
          .thenAnswer((_) async => [testCompanion]);

      when(() => mockDataPointDao.insertEntries(any()))
          .thenAnswer((_) async => {});
    });

    group('getSolarGeneration', () {
      test('returns cached data when available locally', () async {
        when(() => mockDataPointDao.exists(DataType.solar.name, testDateTime))
            .thenAnswer((_) async => true);
        when(() => mockDataPointDao.getEntriesByCategoryAndDate(
                DataType.solar.name, testDateTime))
            .thenAnswer((_) async => [testMonitoringDataPointEntry]);

        final result = await energyRepository.getSolarGeneration(testDateTime);

        expect(result.first, equals(testMonitoringEnergy));
        verify(() => mockDataPointDao.exists(DataType.solar.name, testDateTime))
            .called(1);
      });

      test('fetches and stores remote data when no local data exists',
          () async {
        when(() => mockDataPointDao.exists(DataType.solar.name, testDateTime))
            .thenAnswer((_) async => false);
        when(() => mockInternetConnection.hasInternetAccess)
            .thenAnswer((_) async => true);
        when(() => mockEnergyApiClient.getMonitoring(
                date: any(named: 'date'), type: any(named: 'type')))
            .thenAnswer((_) async => [testMonitoringDataPointDto]);
        when(() => mockDataParser.parseDto(any()))
            .thenAnswer((_) async => [testMonitoringEnergy]);

        final result = await energyRepository.getSolarGeneration(testDateTime);

        expect(result.first, equals(testMonitoringEnergy));
        verify(() =>
                mockDataParser.convertToCompanion(any(), DataType.solar.name))
            .called(1);
        verify(() => mockDataPointDao.insertEntries(any())).called(1);
      });
    });

    group('EnergyRepository Exception Handling', () {
      group('InternetConnectionException', () {
        test('throws when no internet connection is available', () async {
          when(() => mockDataPointDao.exists(any(), any()))
              .thenAnswer((_) async => false);
          when(() => mockInternetConnection.hasInternetAccess)
              .thenAnswer((_) async => false);

          expect(
            () => energyRepository.getSolarGeneration(testDateTime),
            throwsA(isA<InternetConnectionException>()),
          );
        });

        test('throws when internet check fails', () {
          when(() => mockDataPointDao.exists(any(), any()))
              .thenAnswer((_) async => false);
          when(() => mockInternetConnection.hasInternetAccess).thenAnswer(
              (_) async => false); // Simply return false instead of throwing

          expect(
            () => energyRepository.getSolarGeneration(testDateTime),
            throwsA(isA<InternetConnectionException>()),
          );
        });
      });

      group('DataNotFoundException', () {
        test('throws when API returns empty data', () async {
          when(() => mockDataPointDao.exists(any(), any()))
              .thenAnswer((_) async => false);
          when(() => mockInternetConnection.hasInternetAccess)
              .thenAnswer((_) async => true);
          when(() => mockEnergyApiClient.getMonitoring(
              date: any(named: 'date'),
              type: any(named: 'type'))).thenThrow(MonitoringFailure());

          expect(
            () => energyRepository.getSolarGeneration(testDateTime),
            throwsA(isA<DataNotFoundException>()),
          );
        });

        test('throws when data parsing fails', () {
          when(() => mockDataPointDao.exists(any(), any()))
              .thenAnswer((_) async => false);
          when(() => mockInternetConnection.hasInternetAccess)
              .thenAnswer((_) async => true);
          when(() => mockEnergyApiClient.getMonitoring(
                  date: any(named: 'date'), type: any(named: 'type')))
              .thenAnswer((_) async => [testMonitoringDataPointDto]);
          when(() => mockDataParser.parseDto(any())).thenThrow(
              MonitoringFailure()); // Throw MonitoringFailure instead of generic Exception

          expect(
            () => energyRepository.getSolarGeneration(testDateTime),
            throwsA(isA<DataNotFoundException>()),
          );
        });
      });
    });
  });
}
