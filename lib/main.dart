import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'app/energy_monitor_app.dart';

void main() {
  final AppDatabase appDatabase = AppDatabase();
  final EnergyApiClient energyApiClient = EnergyApiClient();
  final InternetConnection internetConnection = InternetConnection();

  final BatteryRepository batteryRepository = EnergyRepository(
    dataPointDao: appDatabase.monitoringDataPointDao,
    apiClient: energyApiClient,
    internetConnection: internetConnection,
  );
  final HouseConsumptionRepository houseConsumptionRepository =
      EnergyRepository(
    dataPointDao: appDatabase.monitoringDataPointDao,
    apiClient: energyApiClient,
    internetConnection: internetConnection,
  );
  final SolarRepository solarRepository = EnergyRepository(
    dataPointDao: appDatabase.monitoringDataPointDao,
    apiClient: energyApiClient,
    internetConnection: internetConnection,
  );

  runApp(
    EnergyMonitorApp(
      solarRepository: solarRepository,
      houseConsumptionRepository: houseConsumptionRepository,
      batteryRepository: batteryRepository,
    ),
  );
}
