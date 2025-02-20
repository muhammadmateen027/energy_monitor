import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

class MonitoringPoint extends Equatable {
  const MonitoringPoint({
    required this.timestamp,
    required this.value,
  });

  factory MonitoringPoint.fromDto(MonitoringDataPoint dto) {
    return MonitoringPoint(
      timestamp: dto.timestamp,
      value: dto.value,
    );
  }

  final DateTime timestamp;
  final int value;

  @override
  List<Object?> get props => [timestamp, value];
}
