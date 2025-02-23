import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

class LineChartContainer extends StatelessWidget {
  const LineChartContainer({
    super.key,
    required this.data,
    required this.axisValues,
    required this.lineColor,
  });

  final List<MonitoringPoint> data;
  final AxisValues axisValues;
  final Color lineColor;

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
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: leftTitles(),
              bottomTitles: bottomTitles(),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(
                  color: lineColor.withValues(alpha: 0.5),
                  width: 2,
                ),
                bottom: BorderSide(
                  color: lineColor.withValues(alpha: 0.5),
                  width: 2,
                ),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              ),
            ),
            lineBarsData: [
              LineChartBar(
                data: data,
                lineColor: lineColor,
              ).getLineChartBarData(),
            ],
            maxX: axisValues.maxX,
            minX: axisValues.minX,
            maxY: axisValues.maxY,
            minY: axisValues.minY,
            clipData: FlClipData.all(),
          ),
        ),
      ),
    );
  }

  AxisTitles leftTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 50,
        getTitlesWidget: (value, meta) {
          if (value == axisValues.minY || value == axisValues.maxY) {
            return SizedBox();
          } else {
            return Container(
              margin: EdgeInsets.only(top: 8, bottom: 0),
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
    );
  }

  AxisTitles bottomTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 50,
        getTitlesWidget: (value, meta) {
          if (value % 1000000 == 0) {
            return Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(value.toInt())
                    .toLocal()
                    .toIso8601String()
                    .substring(11, 16),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class LineChartBar extends StatelessWidget {
  const LineChartBar({
    super.key,
    required this.data,
    required this.lineColor,
  });

  final List<MonitoringPoint> data;
  final Color lineColor;

  LineChartBarData getLineChartBarData() {
    return LineChartBarData(
      spots: data
          .map((point) => FlSpot(
              point.timestamp.millisecondsSinceEpoch.toDouble(),
              point.value.toDouble()))
          .toList(),
      isCurved: true,
      curveSmoothness: 0.1,
      barWidth: 2,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: lineColor,
            strokeWidth: 1,
            strokeColor: Colors.white,
          );
        },
      ),
      color: lineColor,
      belowBarData: BarAreaData(
        show: true,
        color: lineColor.withValues(alpha: 0.1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder widget
  }
}
