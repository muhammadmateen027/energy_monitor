import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../register/down_sampling_register.dart';

part 'energy_base_state.dart';

abstract class EnergyBaseCubit<T extends EnergyBaseState> extends Cubit<T>
    with DownSamplingRegister {
  EnergyBaseCubit(super.initialState);

  void refreshData() => fetchData();

  Future<void> fetchData({DateTime? date}) async {
    emit(state.copyWith(
      dataState: DataState.loading(),
      monitoringPoints: [],
    ) as T);
    try {
      final points = await getData(date ?? state.selectedDate);
      final monitorPoints =
          points.map((e) => MonitoringPoint.fromDto(e, state.unit)).toList();
      final downSamplingData = await downSampling(monitorPoints);

      emit(
        state.copyWith(
          selectedDate: date ?? state.selectedDate,
          dataState: DataState.full(),
          monitoringPoints: downSamplingData,
          axisValues: _getAxisValues(downSamplingData),
        ) as T,
      );
    } on InternetConnectionException {
      emit(
        state.copyWith(
          dataState: DataState.error('Internet connection error'),
          monitoringPoints: [],
        ) as T,
      );
    } catch (e) {
      emit(
        state.copyWith(
          dataState: DataState.error('Unable to find relevant data.'),
          monitoringPoints: [],
        ) as T,
      );
    }
  }

  AxisValues _getAxisValues(List<MonitoringPoint> monitoringPoints) {
    return AxisValues.fromData(monitoringPoints);
  }

  // Abstract method for repository calls in child cubits
  Future<List<MonitoringEnergy>> getData(DateTime date);

  Future<void> clearData() async {
    emit(state.copyWith(dataState: DataState.loading()) as T);
    try {
      await clearRepositoryData();
      emit(
        state.copyWith(
          dataState: DataState.full(),
          monitoringPoints: [],
          axisValues: AxisValues.defaultValues(),
        ) as T,
      );
    } catch (e) {
      emit(
        state.copyWith(
          dataState: DataState.error('Failed to clear data'),
        ) as T,
      );
    }
  }

  // Abstract method for repository calls in child cubits
  Future<void> clearRepositoryData();

  void toggleUnit() async {
    final newUnit =
        state.unit.isWatts ? EnergyUnit.kilowatts : EnergyUnit.watts;

    final monitoringPoints = await compute(
      (List<MonitoringPoint> points) =>
          _convertMonitoringPoints(points, newUnit),
      state.monitoringPoints,
    );

    emit(
      state.copyWith(
        unit: newUnit,
        monitoringPoints: monitoringPoints,
        axisValues: _getAxisValues(monitoringPoints),
      ) as T,
    );
  }

  static List<MonitoringPoint> _convertMonitoringPoints(
      List<MonitoringPoint> points, EnergyUnit newUnit) {
    return points.map((entry) => entry.copyWith(newUnit)).toList();
  }
}
