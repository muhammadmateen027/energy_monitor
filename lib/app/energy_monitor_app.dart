import 'package:energy_monitor/pages/dashboard/view/dashboard_page.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/battery/battery_cubit.dart';
import '../cubits/house_consumption/house_consumption_cubit.dart';
import '../cubits/register/down_sampling_register.dart';
import '../cubits/solar/solar_cubit.dart';

class EnergyMonitorApp extends StatelessWidget {
  const EnergyMonitorApp({
    super.key,
    required this.solarRepository,
    required this.houseConsumptionRepository,
    required this.batteryRepository,
    required this.dataDownSampler,
  });

  final SolarRepository solarRepository;
  final HouseConsumptionRepository houseConsumptionRepository;
  final BatteryRepository batteryRepository;
  final DataDownSampler dataDownSampler;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SolarCubit(
            solarRepository,
            dataDownSampler,
          )..fetchData(),
        ),
        BlocProvider(
          create: (context) => HouseConsumptionCubit(
            houseConsumptionRepository,
            dataDownSampler,
          )..fetchData(),
        ),
        BlocProvider(
          create: (context) => BatteryCubit(
            batteryRepository,
            dataDownSampler,
          )..fetchData(),
        ),
      ],
      child: MaterialApp(
        home: const DashboardPage(),
      ),
    );
  }
}
