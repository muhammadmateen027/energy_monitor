import 'package:energy_api_client/energy_api_client.dart';
import 'package:equatable/equatable.dart';

class MonitoringDataPoint extends Equatable {
  const MonitoringDataPoint({
    required this.timestamp,
    required this.value,
  });

  factory MonitoringDataPoint.fromDto(MonitoringDataPointDto dto) {
    return MonitoringDataPoint(
      timestamp: dto.timestamp,
      value: dto.value,
    );
  }

  final DateTime timestamp;
  final int value;

  @override
  List<Object?> get props => [timestamp, value];
}
