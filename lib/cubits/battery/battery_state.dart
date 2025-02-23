part of 'battery_cubit.dart';

class BatteryState extends EnergyBaseState {
  const BatteryState({
    required super.dataState,
    required super.selectedDate,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  BatteryState.initial(DateTime selectedDate)
      : super(
          dataState: DataState.none(),
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
          selectedDate: selectedDate,
        );

  @override
  BatteryState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
    DateTime? selectedDate,
  }) {
    return BatteryState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
