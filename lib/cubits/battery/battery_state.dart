part of 'battery_cubit.dart';

final class BatteryState extends Equatable {
  const BatteryState({
    required this.dataState,
    required this.monitoringPoints,
  });

  const BatteryState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[];

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;

  BatteryState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
  }) {
    return BatteryState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints];
}
