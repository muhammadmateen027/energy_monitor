import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/pages/pages.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolarForm extends StatelessWidget {
  const SolarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SolarCubit(context.read<SolarRepository>())..fetchData(),
      child: const _SolarFormView(),
    );
  }
}

class _SolarFormView extends StatelessWidget {
  const _SolarFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolarCubit, SolarState>(
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
