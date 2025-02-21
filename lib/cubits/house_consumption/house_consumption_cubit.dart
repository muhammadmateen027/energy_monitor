import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'house_consumption_state.dart';

final class HouseConsumptionCubit
    extends EnergyBaseCubit<HouseConsumptionState> {
  HouseConsumptionCubit(this._houseConsumptionRepository)
      : super(HouseConsumptionState.initial());

  final HouseConsumptionRepository _houseConsumptionRepository;

  void fetchTodayData() => fetchData(DateTime.now());

  @override
  Future<void> fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points =
          await _houseConsumptionRepository.getHouseConsumption(date);

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
