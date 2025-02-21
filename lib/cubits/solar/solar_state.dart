part of 'solar_cubit.dart';

final class SolarState extends EnergyBaseState {
  const SolarState({
    required super.dataState,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  SolarState.initial()
      : super(
          dataState: DataState.initial,
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
        );

  @override
  SolarState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
  }) {
    return SolarState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
    );
  }
}
