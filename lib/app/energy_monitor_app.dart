import 'package:energy_monitor/pages/dashboard/view/dashboard_page.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergyMonitorApp extends StatelessWidget {
  const EnergyMonitorApp({
    super.key,
    required this.solarRepository,
    required this.houseConsumptionRepository,
    required this.batteryRepository,
  });

  final SolarRepository solarRepository;

  final HouseConsumptionRepository houseConsumptionRepository;
  final BatteryRepository batteryRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SolarRepository>(
          create: (context) => solarRepository,
        ),
        RepositoryProvider<HouseConsumptionRepository>(
          create: (context) => houseConsumptionRepository,
        ),
        RepositoryProvider<BatteryRepository>(
          create: (context) => batteryRepository,
        ),
      ],
      child: MaterialApp(
        home: const DashboardPage(),
      ),
    );
  }
}
