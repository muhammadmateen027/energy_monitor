import '../models/models.dart';

/// An abstract class that defines the contract for a SolarRepository.
/// This repository is responsible for managing solar generation data.
abstract class SolarRepository {
  /// Fetches the solar generation data for a given date.
  ///
  /// \param date The date for which to fetch the solar generation data.
  /// \returns A Future that resolves to a list of MonitoringDataPoint objects.
  Future<List<MonitoringDataPoint>> getSolarGeneration(DateTime date);

  /// Clears all solar generation data.
  ///
  /// \returns A Future that completes when the data has been cleared.
  Future<void> clearSolarData();
}
