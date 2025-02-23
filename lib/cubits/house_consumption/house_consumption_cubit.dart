import 'package:energy_monitor/cubits/cubits.dart';
import 'package:energy_monitor/models/models.dart';
import 'package:energy_monitor/utils/utils.dart';
import 'package:energy_repository/energy_repository.dart';

part 'house_consumption_state.dart';

final class HouseConsumptionCubit
    extends EnergyBaseCubit<HouseConsumptionState> {
  HouseConsumptionCubit(this._houseConsumptionRepository)
      : super(HouseConsumptionState.initial(DateTime.now()));

  final HouseConsumptionRepository _houseConsumptionRepository;

  void fetchTodayData() => fetchData();

  @override
  Future<List<MonitoringEnergy>> getData(DateTime date) {
    return _houseConsumptionRepository.getHouseConsumption(date);
  }

  @override
  Future<void> clearRepositoryData() {
    return _houseConsumptionRepository.clearHouseData();
  }
}
