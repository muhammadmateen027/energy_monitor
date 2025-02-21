import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages.dart';

class HouseConsumptionForm extends StatelessWidget {
  const HouseConsumptionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HouseConsumptionCubit(context.read<HouseConsumptionRepository>())
            ..fetchData(),
      child: const _HouseConsumptionFormView(),
    );
  }
}

class _HouseConsumptionFormView extends StatelessWidget {
  const _HouseConsumptionFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseConsumptionCubit, HouseConsumptionState>(
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
