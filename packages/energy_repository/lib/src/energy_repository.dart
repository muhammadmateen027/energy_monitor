import 'package:energy_api_client/energy_api_client.dart';

import '../energy_repository.dart';
import 'data_type.dart';
import 'repositories/battery_repository.dart';
import 'repositories/house_consumption_repository.dart';
import 'repositories/solar_repository.dart';

class EnergyRepository
    implements SolarRepository, HouseConsumptionRepository, BatteryRepository {
  EnergyRepository({EnergyApiClient? apiClient})
      : _energyApiClient = apiClient ?? EnergyApiClient();

  final EnergyApiClient _energyApiClient;

  @override
  Future<void> clearBatteryData() {
    // TODO: implement clearBatteryData
    throw UnimplementedError();
  }

  @override
  Future<void> clearHouseData() {
    // TODO: implement clearHouseData
    throw UnimplementedError();
  }

  @override
  Future<void> clearSolarData() {
    // TODO: implement clearSolarData
    throw UnimplementedError();
  }

  @override
  Future<List<MonitoringDataPoint>> getBatteryConsumption(DateTime date) {
    return _loadData(DataType.battery, date);
  }

  @override
  Future<List<MonitoringDataPoint>> getHouseConsumption(DateTime date) {
    return _loadData(DataType.house, date);
  }

  @override
  Future<List<MonitoringDataPoint>> getSolarGeneration(DateTime date) {
    return _loadData(DataType.solar, date);
  }

  Future<List<MonitoringDataPoint>> _loadData(
          DataType dataType, DateTime date) async =>
      _fetchData(dataType, date);

  Future<List<MonitoringDataPoint>> _fetchData(
      DataType dataType, DateTime date) async {
    try {
      final monitoringDto = await _energyApiClient.getMonitoring(
        date: date.toDateString(),
        type: dataType.name,
      );

      return monitoringDto.data
          .map((dto) => MonitoringDataPoint.fromDto(dto))
          .toList();
    } on MonitoringFailure {
      throw DataNotFoundException();
    } on FormatException {
      throw DataNotFoundException();
    }
  }
}

extension DateTimeExtension on DateTime {
  String toDateString() {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
