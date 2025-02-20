part of 'solar_cubit.dart';

final class SolarState extends Equatable {
  const SolarState({
    required this.dataState,
    required this.monitoringPoints,
  });

  const SolarState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[];

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;

  SolarState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
  }) {
    return SolarState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints];
}
