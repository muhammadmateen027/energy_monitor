part of 'battery_cubit.dart';

final class BatteryState extends Equatable {
  const BatteryState({
    required this.dataState,
    required this.monitoringPoints,
    required this.axisValues,
  });

  BatteryState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[],
        axisValues = AxisValues.defaultValues();

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;
  final AxisValues axisValues;

  BatteryState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
  }) {
    return BatteryState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints, axisValues];
}
