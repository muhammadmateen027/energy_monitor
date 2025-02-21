part of 'house_consumption_cubit.dart';

class HouseConsumptionState extends EnergyBaseState {
  const HouseConsumptionState({
    required super.dataState,
    required super.monitoringPoints,
    required super.axisValues,
    super.unit,
  });

  HouseConsumptionState.initial()
      : super(
          dataState: DataState.initial,
          monitoringPoints: const <MonitoringPoint>[],
          axisValues: AxisValues.defaultValues(),
          unit: EnergyUnit.watts,
        );

  @override
  HouseConsumptionState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
    AxisValues? axisValues,
    EnergyUnit? unit,
  }) {
    return HouseConsumptionState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
      axisValues: axisValues ?? this.axisValues,
      unit: unit ?? this.unit,
    );
  }
}
