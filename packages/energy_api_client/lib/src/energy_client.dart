import 'package:dio/dio.dart';

import '../energy_api_client.dart';
import 'config/api_config.dart';
import 'utils/utils.dart';

/// A client for interacting with the Energy API.
///
/// This client uses the Dio package to make HTTP requests to the Energy API.
/// It provides methods to fetch monitoring data for different types and dates.
class EnergyApiClient {
  /// Creates an instance of [EnergyApiClient].
  ///
  /// If a [dio] instance is not provided, a default instance is created with
  /// the base URL from [ApiConfig].
  EnergyApiClient({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: ApiConfig.baseUrl))
          ..interceptors.add(LogInterceptor(responseBody: true));

  final Dio _dio;

  /// Fetches monitoring data for the given [date] and [type].
  ///
  /// This method runs in an isolate to avoid blocking the main thread.
  /// It returns a list of [MonitoringDataPointDto] objects.
  ///
  /// Throws a [MonitoringFailure] if the request fails or the response status
  /// code is not 200.
  Future<List<MonitoringDataPointDto>> getMonitoring(
      {required String date, required String type}) async {
    try {
      final result = await runInIsolate(() async {
        final response = await _dio.get(
          '/monitoring',
          queryParameters: {
            'date': date,
            'type': type,
          },
        );

        if (response.statusCode != 200) {
          throw MonitoringFailure();
        }

        return (response.data as List<dynamic>)
            .map((element) => MonitoringDataPointDto.fromJson(element))
            .toList();
      });

      return result;
    } on DioException {
      throw MonitoringFailure();
    } catch (e) {
      throw MonitoringFailure();
    }
  }
}
