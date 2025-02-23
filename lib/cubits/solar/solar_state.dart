part of 'solar_cubit.dart';

final class SolarState extends EnergyBaseState {
  const SolarState({
    required super.dataState,
    required super.selectedDate,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  SolarState.initial(DateTime selectedDate)
      : super(
          dataState: DataState.none(),
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
          selectedDate: selectedDate,
        );

  @override
  SolarState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
    DateTime? selectedDate,
  }) {
    return SolarState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
