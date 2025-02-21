part of 'energy_base_cubit.dart';

abstract class EnergyBaseState extends Equatable {
  const EnergyBaseState({
    required this.dataState,
    required this.monitoringPoints,
    required this.axisValues,
    this.unit = EnergyUnit.watts,
  });

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;
  final AxisValues axisValues;
  final EnergyUnit unit;

  EnergyBaseState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
  });

  @override
  List<Object> get props => [
        dataState,
        monitoringPoints,
        axisValues,
        unit,
      ];
}
