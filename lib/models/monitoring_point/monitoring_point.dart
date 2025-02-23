import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

part 'energy_unit.dart';

class MonitoringPoint extends Equatable {
  const MonitoringPoint({
    required this.timestamp,
    required this.value,
    this.unit = EnergyUnit.watts,
  });

  factory MonitoringPoint.fromDto(MonitoringEnergy dto, EnergyUnit unit) {
    final value =
        unit.isKilowatts ? dto.value.toDouble() / 1000 : dto.value.toDouble();
    return MonitoringPoint(
      timestamp: dto.timestamp,
      value: value,
      unit: unit,
    );
  }

  final DateTime timestamp;
  final double value;
  final EnergyUnit unit;

  MonitoringPoint copyWith(EnergyUnit newUnit) {
    if (newUnit == unit) return this;

    final newValue = newUnit.isKilowatts
        ? value / 1000 // Convert to kilowatts
        : value * 1000; // Convert to watts

    return MonitoringPoint(
      timestamp: timestamp,
      value: newValue,
      unit: newUnit,
    );
  }

  String get displayValue => '${value.toStringAsFixed(2)} ${unit.symbol}';

  @override
  List<Object?> get props => [timestamp, value, unit];
}
