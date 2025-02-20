import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

part 'house_consumption_state.dart';

final class HouseConsumptionCubit extends Cubit<HouseConsumptionState> {
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
      emit(
        state.copyWith(
          dataState: DataState.success,
          monitoringPoints:
              points.map((e) => MonitoringPoint.fromDto(e)).toList(),
        ),
      );
    } on Exception {
      emit(state.copyWith(dataState: DataState.failure));
    }
  }
}
