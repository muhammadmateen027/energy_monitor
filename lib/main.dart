import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';

import 'app/energy_monitor_app.dart';

void main() {
  final BatteryRepository batteryRepository = EnergyRepository();
  final HouseConsumptionRepository houseConsumptionRepository =
      EnergyRepository();
  final SolarRepository solarRepository = EnergyRepository();

  runApp(
    EnergyMonitorApp(
      solarRepository: solarRepository,
      houseConsumptionRepository: houseConsumptionRepository,
      batteryRepository: batteryRepository,
    ),
  );
}
