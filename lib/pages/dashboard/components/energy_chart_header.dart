import 'package:flutter/material.dart';

import '../../../models/models.dart';
import 'components.dart';

class EnergyChartCard extends StatelessWidget {
  const EnergyChartCard({
    required this.monitoringPoints,
    required this.axisValues,
    required this.lineColor,
    required this.unit,
    required this.onUnitToggle,
    super.key,
  });

  final List<MonitoringPoint> monitoringPoints;
  final AxisValues axisValues;
  final Color lineColor;
  final EnergyUnit unit;
  final VoidCallback onUnitToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          ChartHeader(
            lineColor: lineColor,
            unit: unit,
            onUnitToggle: onUnitToggle,
          ),
          Expanded(
            child: LineChartContainer(
              data: monitoringPoints,
              axisValues: axisValues,
              lineColor: lineColor,
            ),
          ),
        ],
      ),
    );
  }
}
