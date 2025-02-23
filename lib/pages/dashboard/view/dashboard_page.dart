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
        body: IndexedStack(
          index: selectedTab.index,
          children: const [SolarForm(), HouseConsumptionForm(), BatteryForm()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomAppBar(
            height: 70,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: AutomaticNotchedShape(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HomeTabButton(
                  groupValue: selectedTab,
                  value: DashboardTab.solar,
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.solar_power, size: 28),
                      Text('Solar', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                _HomeTabButton(
                  groupValue: selectedTab,
                  value: DashboardTab.house,
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home, size: 28),
                      Text('House', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                _HomeTabButton(
                  groupValue: selectedTab,
                  value: DashboardTab.battery,
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.battery_4_bar, size: 28),
                      Text('Battery', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
