part of 'monitoring_point.dart';

enum EnergyUnit {
  watts,
  kilowatts;

  bool get isWatts => this == EnergyUnit.watts;

  bool get isKilowatts => this == EnergyUnit.kilowatts;

  String get symbol => switch (this) {
        EnergyUnit.watts => 'W',
        EnergyUnit.kilowatts => 'kW',
      };
}

extension TemperatureUnitsX on EnergyUnit {
  bool get isWatts => this == EnergyUnit.watts;

  bool get isKilowatts => this == EnergyUnit.kilowatts;
}
