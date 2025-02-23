import 'dart:math';

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

    // Calculate Y-axis values with proper padding
    final values = data.map((e) => e.value.toDouble());
    final minValue = values.reduce(min);
    final maxValue = values.reduce(max);

    // Add 10% padding to min/max for better visualization
    final range = maxValue - minValue;
    final padding = range * 0.1;

    final minY = (minValue - padding).roundToDouble();
    final maxY = (maxValue + padding).roundToDouble();

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
