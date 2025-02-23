import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/src/utils/date_time_extension.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../energy_repository.dart';
import 'connectivity_checker/connectivity_checker.dart';
import 'data_parser/data_parser.dart';
import 'data_type.dart';

class EnergyRepository
    implements SolarRepository, HouseConsumptionRepository, BatteryRepository {
  EnergyRepository({
    required MonitoringDataPointDao dataPointDao,
    required EnergyApiClient apiClient,
    required InternetConnection internetConnection,
    DataParser? dataParser,
  })  : _energyApiClient = apiClient,
        _dataPointDao = dataPointDao,
        _dataParser = dataParser ?? IsolateDataParser(),
        _connectivityChecker = InternetConnectivityChecker(internetConnection);

  final EnergyApiClient _energyApiClient;
  final MonitoringDataPointDao _dataPointDao;
  final DataParser _dataParser;
  final ConnectivityChecker _connectivityChecker;

  @override
  Future<List<MonitoringEnergy>> getSolarGeneration(DateTime date) =>
      _loadData(DataType.solar, date);

  @override
  Future<List<MonitoringEnergy>> getHouseConsumption(DateTime date) =>
      _loadData(DataType.house, date);

  @override
  Future<List<MonitoringEnergy>> getBatteryConsumption(DateTime date) =>
      _loadData(DataType.battery, date);

  Future<List<MonitoringEnergy>> _loadData(
      DataType dataType, DateTime date) async {
    try {
      if (await _hasLocalData(dataType, date)) {
        return _getLocalData(dataType, date);
      }

      await _connectivityChecker.checkConnection();
      return _fetchAndStoreRemoteData(dataType, date);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> _hasLocalData(DataType dataType, DateTime date) async =>
      await _dataPointDao.exists(dataType.name, date);

  Future<List<MonitoringEnergy>> _getLocalData(
      DataType dataType, DateTime date) async {
    final entries =
        await _dataPointDao.getEntriesByCategoryAndDate(dataType.name, date);
    return entries
        .map((entry) => MonitoringEnergy.fromDaoEntry(entry))
        .toList();
  }

  Future<List<MonitoringEnergy>> _fetchAndStoreRemoteData(
      DataType dataType, DateTime date) async {
    try {
      final monitoringDto = await _energyApiClient.getMonitoring(
        date: date.toDateString(),
        type: dataType.name,
      );

      final dataPoints = await _dataParser.parseDto(monitoringDto);
      await _storeDataPoints(dataPoints, dataType);
      return dataPoints;
    } on MonitoringFailure {
      throw DataNotFoundException();
    }
  }

  Future<void> _storeDataPoints(
    List<MonitoringEnergy> dataPoints,
    DataType dataType,
  ) async {
    final entries =
        await _dataParser.convertToCompanion(dataPoints, dataType.name);
    await _dataPointDao.insertEntries(entries);
  }

  @override
  Future<void> clearSolarData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.solar.name);

  @override
  Future<void> clearHouseData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.house.name);

  @override
  Future<void> clearBatteryData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.battery.name);
}
