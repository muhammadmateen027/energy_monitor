part of 'monitoring_point.dart';

enum EnergyUnit { watts, kilowatts }

extension TemperatureUnitsX on EnergyUnit {
  bool get isWatts => this == EnergyUnit.watts;

  bool get isKilowatts => this == EnergyUnit.kilowatts;
}
