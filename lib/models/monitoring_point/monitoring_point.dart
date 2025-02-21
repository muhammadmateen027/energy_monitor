import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

part 'energy_unit.dart';

class MonitoringPoint extends Equatable {
  const MonitoringPoint({
    required this.timestamp,
    required this.value,
  });

  factory MonitoringPoint.fromDto(MonitoringDataPoint dto, EnergyUnit unit) {
    return MonitoringPoint(
      timestamp: dto.timestamp,
      value: unit.isKilowatts ? dto.value * 1000 : dto.value,
    );
  }

  final DateTime timestamp;
  final int value;

  MonitoringPoint copyWith(EnergyUnit unit) {
    return MonitoringPoint(
      timestamp: timestamp,
      value: unit.isKilowatts ? value * 1000 : value,
    );
  }

  @override
  List<Object?> get props => [timestamp, value];
}
