import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'solar_state.dart';

final class SolarCubit extends EnergyBaseCubit<SolarState> {
  SolarCubit(this._solarRepository) : super(SolarState.initial());

  final SolarRepository _solarRepository;

  void fetchTodayData() => fetchData(DateTime.now());

  @override
  Future<void> fetchData(DateTime date) async {
    try {
      emit(state.copyWith(dataState: DataState.loading));

      final points = await _solarRepository.getSolarGeneration(date);

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
    } catch (e) {
      emit(state.copyWith(dataState: DataState.failure));
    }
  }
}
