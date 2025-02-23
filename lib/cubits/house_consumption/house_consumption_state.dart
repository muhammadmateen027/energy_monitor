part of 'house_consumption_cubit.dart';

class HouseConsumptionState extends EnergyBaseState {
  const HouseConsumptionState({
    required super.selectedDate,
    required super.dataState,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  HouseConsumptionState.initial(DateTime selectedDate)
      : super(
          dataState: DataState.none(),
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
          selectedDate: selectedDate,
        );

  @override
  HouseConsumptionState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
    DateTime? selectedDate,
  }) {
    return HouseConsumptionState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
