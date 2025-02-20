part of 'house_consumption_cubit.dart';

final class HouseConsumptionState extends Equatable {
  const HouseConsumptionState({
    required this.dataState,
    required this.monitoringPoints,
  });

  const HouseConsumptionState.initial()
      : dataState = DataState.initial,
        monitoringPoints = const <MonitoringPoint>[];

  final DataState dataState;
  final List<MonitoringPoint> monitoringPoints;

  HouseConsumptionState copyWith({
    DataState? dataState,
    List<MonitoringPoint>? monitoringPoints,
  }) {
    return HouseConsumptionState(
      dataState: dataState ?? this.dataState,
      monitoringPoints: monitoringPoints ?? this.monitoringPoints,
    );
  }

  @override
  List<Object> get props => [dataState, monitoringPoints];
}
