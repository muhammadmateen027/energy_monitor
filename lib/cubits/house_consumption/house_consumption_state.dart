part of 'house_consumption_cubit.dart';

final class HouseConsumptionState extends Equatable {
  const HouseConsumptionState({
    required this.dataState,
    required this.monitoringPoints,
    required this.axisValues,
  });

  HouseConsumptionState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[],
        axisValues = AxisValues.defaultValues();

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;
  final AxisValues axisValues;

  HouseConsumptionState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
  }) {
    return HouseConsumptionState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints, axisValues];
}
