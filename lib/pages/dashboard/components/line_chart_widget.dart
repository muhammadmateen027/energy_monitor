import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.data,
    required this.axisValues,
  });

  final List<MonitoringPoint> data;
  final AxisValues axisValues;

  DateTime date(double value) =>
      DateTime.fromMillisecondsSinceEpoch(value.toInt());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 500,
        width: data.length * 50.0,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: LineChart(
          key: UniqueKey(),
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(),
            ),
            clipData: FlClipData.all(),
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    if (value == axisValues.maxY) {
                      return SizedBox();
                    } else {
                      return Container(
                        margin:
                            EdgeInsets.only(top: 8, bottom: 0), // Add some gap
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    // Show titles at intervals of 1000000000 (or any other interval you prefer)
                    if (value % 1000000 == 0) {
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          DateTime.fromMillisecondsSinceEpoch(value.toInt())
                              .toLocal()
                              .toIso8601String()
                              .substring(11, 16), // Format the date
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Return an empty container for other values
                    }
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
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
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                      strokeWidth: 1,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                color: Colors.blue,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withValues(alpha: 0.1),
                ),
              ),
            ],
            maxX: axisValues.maxX,
            minX: axisValues.minX,
            maxY: axisValues.maxY,
            minY: axisValues.minY,
          ),
        ),
      ),
    );
  }
}
