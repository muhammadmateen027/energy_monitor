part of 'battery_cubit.dart';

class BatteryState extends EnergyBaseState {
  const BatteryState({
    required super.dataState,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  BatteryState.initial()
      : super(
          dataState: DataState.initial,
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
        );

  @override
  BatteryState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
  }) {
    return BatteryState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
    );
  }
}
