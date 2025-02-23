import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'solar_state.dart';

final class SolarCubit extends EnergyBaseCubit<SolarState> {
  SolarCubit(this._solarRepository) : super(SolarState.initial(DateTime.now()));

  final SolarRepository _solarRepository;

  void fetchTodayData() => fetchData();

  @override
  Future<List<MonitoringEnergy>> getData(DateTime date) =>
      _solarRepository.getSolarGeneration(date);

  @override
  Future<void> clearRepositoryData() {
    return _solarRepository.clearSolarData();
  }
}
