import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

import '../register/down_sampling_register.dart';

part 'battery_state.dart';

final class BatteryCubit extends Cubit<BatteryState> with DownSamplingRegister {
  BatteryCubit(this._batteryRepository) : super(BatteryState.initial());

  final BatteryRepository _batteryRepository;

  void fetchData({DateTime? dateTime}) {
    final date = dateTime ?? DateTime.now();

    _fetchData(date);
  }

  Future<void> _fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points = await _batteryRepository.getBatteryConsumption(date);
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
    } on Exception {
      emit(state.copyWith(dataState: DataState.failure));
    }
  }
}
