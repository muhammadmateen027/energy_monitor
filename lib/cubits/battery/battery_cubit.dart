import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'battery_state.dart';

final class BatteryCubit extends EnergyBaseCubit<BatteryState> {
  BatteryCubit(this._batteryRepository) : super(BatteryState.initial());

  final BatteryRepository _batteryRepository;

  void fetchTodayData() => fetchData(DateTime.now());

  @override
  Future<void> fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points = await _batteryRepository.getBatteryConsumption(date);
      final monitorPoints =
          points.map((e) => MonitoringPoint.fromDto(e, state.unit)).toList();

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
