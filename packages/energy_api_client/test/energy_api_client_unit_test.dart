import 'package:dio/dio.dart';
import 'package:energy_api_client/energy_api_client.dart';
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

  group('EnergyApiClient', () {
    late EnergyApiClient apiClient;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      apiClient = EnergyApiClient(dio: mockDio);
    });

    group('getMonitoring', () {
      test('returns List of MonitoringDto when the request is successful',
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

        final result = await apiClient.getMonitoring(
          date: '2021-10-01',
          type: 'type',
        );

        expect(result, isA<List<MonitoringDataPointDto>>());
        expect(result.first.timestamp, DateTime.parse('2021-10-01T00:00:00Z'));
        expect(result.first.value, 100);
      });

      test('throws MonitoringFailure when the request fails', () async {
        when(() => mockDio.get(any(),
                queryParameters: any(named: 'queryParameters')))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () async => await apiClient.getMonitoring(
            date: '2021-10-01',
            type: 'type',
          ),
          throwsA(isA<MonitoringFailure>()),
        );
      });

      test('throws MonitoringFailure when the status code is not 200',
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
          () async => await apiClient.getMonitoring(
            date: '2021-10-01',
            type: 'type',
          ),
          throwsA(isA<MonitoringFailure>()),
        );
      });
    });
  });
}
