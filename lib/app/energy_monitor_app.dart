import 'package:energy_monitor/pages/dashboard/view/dashboard_page.dart';
import 'package:flutter/material.dart';

class EnergyMonitorApp extends StatelessWidget {
  const EnergyMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DashboardPage(),
    );
  }
}
