import '../models/models.dart';

/// An abstract class that defines the contract for a BatteryRepository.
/// This repository is responsible for managing battery consumption data.
abstract class BatteryRepository {
  /// Fetches the battery consumption data for a given date.
  ///
  /// \param date The date for which to fetch the battery consumption data.
  /// \returns A Future that resolves to a list of MonitoringDataPoint objects.
  Future<List<MonitoringEnergy>> getBatteryConsumption(DateTime date);

  /// Clears all battery consumption data.
  ///
  /// \returns A Future that completes when the data has been cleared.
  Future<void> clearBatteryData();
}
