import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

import '../register/down_sampling_register.dart';

part 'battery_state.dart';

final class BatteryCubit extends EnergyBaseCubit<BatteryState> {
  BatteryCubit(this._batteryRepository, DataDownSampler dataDownSampler)
      : super(BatteryState.initial(DateTime.now()), dataDownSampler);

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
