import 'package:json_annotation/json_annotation.dart';

part 'monitoring_dto.g.dart';

@JsonSerializable(createToJson: false)
class MonitoringDataPointDto {
  const MonitoringDataPointDto({
    required this.timestamp,
    required this.value,
  });

  factory MonitoringDataPointDto.fromJson(Map<String, dynamic> json) =>
      _$MonitoringDataPointDtoFromJson(json);

  final DateTime timestamp;
  final int value;
}
