import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

import '../register/down_sampling_register.dart';

part 'house_consumption_state.dart';

final class HouseConsumptionCubit extends Cubit<HouseConsumptionState>
    with DownSamplingRegister {
  HouseConsumptionCubit(this._houseConsumptionRepository)
      : super(HouseConsumptionState.initial());

  final HouseConsumptionRepository _houseConsumptionRepository;

  void fetchData({DateTime? dateTime}) {
    final date = dateTime ?? DateTime.now();

    _fetchData(date);
  }

  Future<void> _fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points =
          await _houseConsumptionRepository.getHouseConsumption(date);

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
