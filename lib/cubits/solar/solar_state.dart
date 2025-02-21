part of 'solar_cubit.dart';

final class SolarState extends Equatable {
  const SolarState({
    required this.dataState,
    required this.monitoringPoints,
    required this.axisValues,
  });

  SolarState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[],
        axisValues = AxisValues.defaultValues();

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;
  final AxisValues axisValues;

  SolarState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
  }) {
    return SolarState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints, axisValues];
}
