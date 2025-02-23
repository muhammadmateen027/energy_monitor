import 'package:flutter/foundation.dart';

import '../../models/monitoring_point/monitoring_point.dart';

class DataDownSampler {
  Future<List<MonitoringPoint>> downSampling(List<MonitoringPoint> data) async {
    return await compute(_downSampling, data);
  }

  static List<MonitoringPoint> _downSampling(List<MonitoringPoint> data) {
    if (data.length <= 2) return data;

    final threshold = 100;
    final sampled = <MonitoringPoint>[data.first];
    final bucketSize = (data.length - 2) / (threshold - 2);

    // Pre-calculate timestamps to avoid repeated millisecondsSinceEpoch calls
    final timestamps =
        data.map((p) => p.timestamp.millisecondsSinceEpoch).toList();
    var currentIndex = 0;

    for (int i = 0; i < threshold - 2; i++) {
      final rangeStart = (i * bucketSize).floor() + 1;
      final rangeEnd = ((i + 1) * bucketSize).floor() + 1;

      // Calculate averages in single pass
      var sumX = 0.0;
      var sumY = 0.0;
      final rangeLength = rangeEnd - rangeStart;

      for (var j = rangeStart; j < rangeEnd; j++) {
        sumX += timestamps[j];
        sumY += data[j].value;
      }

      final avgX = sumX / rangeLength;
      final avgY = sumY / rangeLength;

      // Find point with maximum area
      var maxArea = -1.0;
      var maxAreaPoint = data[rangeStart];
      final baseX = timestamps[currentIndex];
      final baseY = data[currentIndex].value;

      for (var j = rangeStart; j < rangeEnd; j++) {
        final point = data[j];
        final area = (baseX - avgX) * (point.value - baseY) -
            (baseX - timestamps[j]) * (avgY - baseY);

        if (area.abs() > maxArea) {
          maxArea = area.abs();
          maxAreaPoint = point;
        }
      }

      sampled.add(maxAreaPoint);
      currentIndex = data.indexOf(maxAreaPoint);
    }

    sampled.add(data.last);
    return sampled;
  }
}
