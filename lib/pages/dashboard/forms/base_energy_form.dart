import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';
import '../components/components.dart';

class BaseEnergyForm<T extends EnergyBaseCubit<EnergyBaseState>>
    extends StatelessWidget {
  const BaseEnergyForm({
    required this.create,
    required this.lineColor,
    super.key,
  });

  final T Function(BuildContext) create;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: _EnergyMonitoringView<T>(lineColor: lineColor),
    );
  }
}

class _EnergyMonitoringView<T extends EnergyBaseCubit<EnergyBaseState>>
    extends StatelessWidget {
  const _EnergyMonitoringView({
    required this.lineColor,
    super.key,
  });

  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<T>().refreshData(),
      child: BlocBuilder<T, EnergyBaseState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EnergyHeader(
                          lineColor: lineColor,
                          selectedDate: state.selectedDate,
                          onDateSelected: (date) =>
                              context.read<T>().fetchData(date: date),
                          onClearData: () => context.read<T>().clearData(),
                          onRefresh: () => context.read<T>().refreshData(),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: _buildChartSection(context, state),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildChartSection(BuildContext context, EnergyBaseState state) {
    if (state.dataState.hasException) {
      return EnergyDataError(
        errorMessage: state.dataState.exception.toString(),
        onPressed: () => context.read<T>().refreshData(),
      );
    }

    if (state.dataState.isFull && state.monitoringPoints.isEmpty) {
      return const EnergyDataEmpty();
    }

    return EnergyChartCard(
      monitoringPoints: state.monitoringPoints,
      axisValues: state.axisValues,
      lineColor: lineColor,
      unit: state.unit,
      onUnitToggle: () => context.read<T>().toggleUnit(),
    );
  }
}
