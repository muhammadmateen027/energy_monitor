import 'package:dio/dio.dart';

import '../energy_api_client.dart';
import 'config/api_config.dart';
import 'utils/utils.dart';

class EnergyApiClient {
  EnergyApiClient({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: ApiConfig.baseUrl))
          ..interceptors.add(LogInterceptor(responseBody: true));

  final Dio _dio;

  Future<MonitoringDto> getMonitoring(
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

        return MonitoringDto.fromJson(response.data);
      });

      return result;
    } on DioException {
      throw MonitoringFailure();
    } catch (e) {
      throw MonitoringFailure();
    }
  }
}
