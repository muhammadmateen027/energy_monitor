import 'package:bloc/bloc.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';
import 'package:equatable/equatable.dart';

part 'battery_state.dart';

final class BatteryCubit extends Cubit<BatteryState> {
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
