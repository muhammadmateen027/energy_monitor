import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:energy_repository/src/utils/date_time_extension.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../energy_repository.dart';
import 'connectivity_checker/connectivity_checker.dart';
import 'data_parser/data_parser.dart';
import 'data_type.dart';

/// A repository that handles data operations for solar, house consumption,
/// and battery consumption.
///
/// This class implements the `SolarRepository`, `HouseConsumptionRepository`,
/// and `BatteryRepository` interfaces.
class EnergyRepository
    implements SolarRepository, HouseConsumptionRepository, BatteryRepository {
  /// Creates an instance of `EnergyRepository`.
  ///
  /// The [dataPointDao], [apiClient], and [internetConnection] parameters
  /// are required. The [dataParser] parameter is optional and defaults to
  /// `IsolateDataParser` if not provided.
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

  /// Fetches solar generation data for the given [date].
  @override
  Future<List<MonitoringEnergy>> getSolarGeneration(DateTime date) =>
      _loadData(DataType.solar, date);

  /// Fetches house consumption data for the given [date].
  @override
  Future<List<MonitoringEnergy>> getHouseConsumption(DateTime date) =>
      _loadData(DataType.house, date);

  /// Fetches battery consumption data for the given [date].
  @override
  Future<List<MonitoringEnergy>> getBatteryConsumption(DateTime date) =>
      _loadData(DataType.battery, date);

  /// Loads data for the given [dataType] and [date].
  ///
  /// This method first checks if local data is available. If not, it fetches
  /// and stores remote data.
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

  /// Checks if local data is available for the given [dataType] and [date].
  Future<bool> _hasLocalData(DataType dataType, DateTime date) async =>
      await _dataPointDao.exists(dataType.name, date);

  /// Retrieves local data for the given [dataType] and [date].
  Future<List<MonitoringEnergy>> _getLocalData(
      DataType dataType, DateTime date) async {
    final entries =
        await _dataPointDao.getEntriesByCategoryAndDate(dataType.name, date);
    return entries
        .map((entry) => MonitoringEnergy.fromDaoEntry(entry))
        .toList();
  }

  /// Fetches and stores remote data for the given [dataType] and [date].
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

  /// Stores the given [dataPoints] for the specified [dataType].
  Future<void> _storeDataPoints(
    List<MonitoringEnergy> dataPoints,
    DataType dataType,
  ) async {
    final entries =
        await _dataParser.convertToCompanion(dataPoints, dataType.name);
    await _dataPointDao.insertEntries(entries);
  }

  /// Clears solar data from the local database.
  @override
  Future<void> clearSolarData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.solar.name);

  /// Clears house consumption data from the local database.
  @override
  Future<void> clearHouseData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.house.name);

  /// Clears battery data from the local database.
  @override
  Future<void> clearBatteryData() async =>
      _dataPointDao.deleteEntriesByCategory(DataType.battery.name);
}
