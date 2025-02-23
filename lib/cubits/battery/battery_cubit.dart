import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'battery_state.dart';

final class BatteryCubit extends EnergyBaseCubit<BatteryState> {
  BatteryCubit(this._batteryRepository)
      : super(BatteryState.initial(DateTime.now()));

  final BatteryRepository _batteryRepository;

  void fetchTodayData() => fetchData();

  @override
  Future<List<MonitoringEnergy>> getData(DateTime date) {
    return _batteryRepository.getBatteryConsumption(date);
  }

  @override
  Future<void> clearRepositoryData() {
    return _batteryRepository.clearBatteryData();
  }
}
