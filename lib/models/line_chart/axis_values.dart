import 'package:equatable/equatable.dart';

import '../monitoring_point/monitoring_point.dart';

class AxisValues extends Equatable {
  const AxisValues({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  factory AxisValues.fromData(List<MonitoringPoint> data) {
    if (data.isEmpty) {
      return AxisValues.defaultValues();
    }

    final minX = data.first.timestamp.millisecondsSinceEpoch.toDouble();
    final maxX = data.last.timestamp.millisecondsSinceEpoch.toDouble();

    final minY =
        data.map((e) => e.value).reduce((a, b) => a < b ? a : b).toDouble() - 2;
    final maxY =
        data.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble() + 2;

    return AxisValues(minX: minX, maxX: maxX, minY: minY, maxY: maxY);
  }

  factory AxisValues.defaultValues() {
    return const AxisValues(
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
    );
  }

  @override
  List<Object?> get props => [minX, maxX, minY, maxY];
}
