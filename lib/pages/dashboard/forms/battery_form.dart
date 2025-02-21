import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/pages/dashboard/components/line_chart_widget.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryForm extends StatelessWidget {
  const BatteryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BatteryCubit(context.read<BatteryRepository>())..fetchData(),
      child: const _BatteryFormView(),
    );
  }
}

class _BatteryFormView extends StatelessWidget {
  const _BatteryFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatteryCubit, BatteryState>(
      builder: (context, state) {
        if (state.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.dataState == DataState.success) {
          return LineChartWidget(
            data: state.monitoringPoints,
            axisValues: state.axisValues,
            key: UniqueKey(),
          );
        } else {
          return const Center(child: Text('Failed to load data'));
        }
      },
    );
  }
}
