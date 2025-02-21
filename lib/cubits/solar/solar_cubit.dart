import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

import '../register/down_sampling_register.dart';

part 'solar_state.dart';

final class SolarCubit extends Cubit<SolarState> with DownSamplingRegister {
  SolarCubit(this._solarRepository) : super(SolarState.initial());

  final SolarRepository _solarRepository;

  void fetchData({DateTime? dateTime}) {
    final date = dateTime ?? DateTime.now();

    _fetchData(date);
  }

  Future<void> _fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points = await _solarRepository.getSolarGeneration(date);

      log('Total: ${points.length}');
      final monitorPoints =
          points.map((e) => MonitoringPoint.fromDto(e)).toList();

      final downSamplingData = downSampling(monitorPoints);

      emit(
        state.copyWith(
          dataState: DataState.success,
          monitoringPoints: downSamplingData,
          axisValues: AxisValues.fromData(downSamplingData),
        ),
      );
    } catch (e, s) {
      log('Exception: $e, S: $s');
      emit(state.copyWith(dataState: DataState.failure));
    }
  }
}
