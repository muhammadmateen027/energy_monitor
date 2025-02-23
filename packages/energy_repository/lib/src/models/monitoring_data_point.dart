import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';
import 'package:equatable/equatable.dart';

class MonitoringEnergy extends Equatable {
  const MonitoringEnergy({
    required this.timestamp,
    required this.value,
  });

  factory MonitoringEnergy.fromDto(MonitoringDataPointDto dto) {
    return MonitoringEnergy(
      timestamp: dto.timestamp,
      value: dto.value,
    );
  }

  factory MonitoringEnergy.fromDaoEntry(MonitoringDataPointEntry entry) {
    return MonitoringEnergy(
      timestamp: entry.timeStamp,
      value: entry.value,
    );
  }

  final DateTime timestamp;
  final int value;

  @override
  List<Object?> get props => [timestamp, value];
}
