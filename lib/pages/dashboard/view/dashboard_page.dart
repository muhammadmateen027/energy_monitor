import 'package:energy_monitor/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((DashboardCubit cubit) => cubit.state.tab);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Monitor'),
      ),
      body: IndexedStack(
        index: selectedTab.index,
        children: const [SolarForm(), HouseConsumptionForm(), BatteryForm()],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: DashboardTab.solar,
              icon: const Icon(Icons.solar_power),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: DashboardTab.house,
              icon: const Icon(Icons.home),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: DashboardTab.battery,
              icon: const Icon(Icons.battery_4_bar),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final DashboardTab groupValue;
  final DashboardTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<DashboardCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value
          ? Theme.of(context).colorScheme.onSurface
          : Theme.of(context).colorScheme.primary,
      icon: icon,
    );
  }
}
