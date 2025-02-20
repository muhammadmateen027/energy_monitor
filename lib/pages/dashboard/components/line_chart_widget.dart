import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/monitoring_point/monitoring_point.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key, required this.data});

  final List<MonitoringPoint> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 300,
        width: data.length * 50.0, // Adjust the width based on the data length
        child: LineChart(
          key: UniqueKey(),
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (meta.min == value ||
                        meta.min + meta.appliedInterval == value) {
                      return const SizedBox.shrink(); // Skip first two labels
                    }
                    final date =
                        DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    return Text(
                        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value % 4 != 0) {
                      return const SizedBox
                          .shrink(); // Skip labels with interval of 4
                    }
                    return Text(value.toString());
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide top labels
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide right labels
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: data
                    .map((point) => FlSpot(
                        point.timestamp.millisecondsSinceEpoch.toDouble(),
                        point.value.toDouble()))
                    .toList(),
                isCurved: true,
                barWidth: 2,
                color: Colors.blue,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
