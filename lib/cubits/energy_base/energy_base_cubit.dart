import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../register/down_sampling_register.dart';

part 'energy_base_state.dart';

/// An abstract base class for Cubits that manage energy data.
///
/// This class provides common functionality for fetching, refreshing,
/// and clearing energy data, as well as toggling the unit of measurement.
abstract class EnergyBaseCubit<T extends EnergyBaseState> extends Cubit<T> {
  /// Creates an instance of [EnergyBaseCubit].
  ///
  /// The [initialState] parameter is the initial state of the Cubit.
  /// The [dataDownSampler] parameter is used for down-sampling the data.
  EnergyBaseCubit(super.initialState, this.dataDownSampler);

  /// The [DataDownSampler] instance used for down-sampling the data.
  final DataDownSampler dataDownSampler;

  /// Refreshes the energy data by calling [fetchData].
  void refreshData() => fetchData();

  /// Fetches energy data for the given [date].
  ///
  /// If [date] is not provided, the current state's selected date is used.
  /// Emits loading, success, or error states based on the result.
  Future<void> fetchData({DateTime? date}) async {
    emit(state.copyWith(
      dataState: DataState.loading(),
      monitoringPoints: [],
    ) as T);
    try {
      final points = await getData(date ?? state.selectedDate);
      final monitorPoints =
          points.map((e) => MonitoringPoint.fromDto(e, state.unit)).toList();
      final downSamplingData =
          await dataDownSampler.downSampling(monitorPoints);

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

  /// Generates axis values from the given [monitoringPoints].
  AxisValues _getAxisValues(List<MonitoringPoint> monitoringPoints) {
    return AxisValues.fromData(monitoringPoints);
  }

  /// Abstract method to fetch data from the repository.
  ///
  /// This method should be implemented by child Cubits to fetch specific data.
  Future<List<MonitoringEnergy>> getData(DateTime date);

  /// Clears the energy data from the repository.
  ///
  /// Emits loading, success, or error states based on the result.
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

  /// Abstract method to clear data from the repository.
  ///
  /// This method should be implemented by child Cubits to clear specific data.
  Future<void> clearRepositoryData();

  /// Toggles the unit of measurement between watts and kilowatts.
  ///
  /// Converts the current monitoring points to the new unit and updates the state.
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

  /// Converts the given [points] to the specified [newUnit].
  static List<MonitoringPoint> _convertMonitoringPoints(
      List<MonitoringPoint> points, EnergyUnit newUnit) {
    return points.map((entry) => entry.copyWith(newUnit)).toList();
  }
}
