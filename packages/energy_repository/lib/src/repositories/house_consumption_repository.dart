import '../models/models.dart';

/// An abstract class that defines the contract for a HouseConsumptionRepository.
/// This repository is responsible for managing house consumption data.
abstract class HouseConsumptionRepository {
  /// Fetches the house consumption data for a given date.
  ///
  /// \param date The date for which to fetch the house consumption data.
  /// \returns A Future that resolves to a list of MonitoringDataPoint objects.
  Future<List<MonitoringEnergy>> getHouseConsumption(DateTime date);

  /// Clears all house consumption data.
  ///
  /// \returns A Future that completes when the data has been cleared.
  Future<void> clearHouseData();
}
