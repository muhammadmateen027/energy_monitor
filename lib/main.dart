import 'package:bloc/bloc.dart';
import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'app/energy_monitor_app.dart';
import 'cubits/register/down_sampling_register.dart';
import 'energy_monitor_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const EnergyMonitorBlocObserver();

  final AppDatabase appDatabase = AppDatabase();
  final EnergyApiClient energyApiClient = EnergyApiClient();
  final InternetConnection internetConnection = InternetConnection();
  final DataDownSampler dataDownSampler = DataDownSampler();

  final energyRepository = EnergyRepository(
    dataPointDao: appDatabase.monitoringDataPointDao,
    apiClient: energyApiClient,
    internetConnection: internetConnection,
  );

  final BatteryRepository batteryRepository = energyRepository;
  final HouseConsumptionRepository houseConsumptionRepository =
      energyRepository;
  final SolarRepository solarRepository = energyRepository;

  runApp(EnergyMonitorApp(
    solarRepository: solarRepository,
    houseConsumptionRepository: houseConsumptionRepository,
    batteryRepository: batteryRepository,
    dataDownSampler: dataDownSampler,
  ));
}
