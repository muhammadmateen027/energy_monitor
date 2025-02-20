import 'package:dio/dio.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {
  @override
  final Interceptors interceptors = Interceptors();
}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('EnergyRepository', () {
    late EnergyRepository energyRepository;
    late MockDio mockDio;
    late EnergyApiClient mockEnergyApiClient;

    setUp(() {
      mockDio = MockDio();
      mockEnergyApiClient = EnergyApiClient(dio: mockDio);
      energyRepository = EnergyRepository(apiClient: mockEnergyApiClient);
    });

    group('getSolarGeneration', () {
      test('returns list of MonitoringDataPoint when the request is successful',
          () async {
        final response = Response(
          data: {
            'data': [
              {'timestamp': '2021-10-01T00:00:00Z', 'value': 100}
            ]
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenAnswer((_) async => response);

        final result = await energyRepository
            .getSolarGeneration(DateTime.parse('2021-10-01'));

        expect(result, isA<List<MonitoringDataPoint>>());
        expect(result.first.timestamp, DateTime.parse('2021-10-01T00:00:00Z'));
        expect(result.first.value, 100);
      });

      test('throws DataNotFoundException when the request fails', () async {
        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () async => await energyRepository
              .getSolarGeneration(DateTime.parse('2021-10-01')),
          throwsA(isA<DataNotFoundException>()),
        );
      });

      test('throws DataNotFoundException when the status code is not 200',
          () async {
        final response = Response(
          data: [],
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );

        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenAnswer((_) async => response);

        expect(
          () async => await energyRepository
              .getSolarGeneration(DateTime.parse('2021-10-01')),
          throwsA(isA<DataNotFoundException>()),
        );
      });
      test('throws DataNotFoundException when an exception occurs', () async {
        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenThrow(Exception('Unexpected error'));

        expect(
          () async => await energyRepository
              .getSolarGeneration(DateTime.parse('2021-10-01')),
          throwsA(isA<DataNotFoundException>()),
        );
      });

      test('returns empty list when data is empty', () async {
        final response = Response(
          data: {'data': []},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenAnswer((_) async => response);

        final result = await energyRepository
            .getSolarGeneration(DateTime.parse('2021-10-01'));

        expect(result, isEmpty);
      });

      test('throws DataNotFoundException when data is null', () async {
        final response = Response(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenAnswer((_) async => response);

        expect(
          () async => await energyRepository
              .getSolarGeneration(DateTime.parse('2021-10-01')),
          throwsA(isA<DataNotFoundException>()),
        );
      });
    });
  });
}
