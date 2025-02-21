import '../../models/monitoring_point/monitoring_point.dart';

mixin DownSamplingRegister {
  List<MonitoringPoint> downSampling(List<MonitoringPoint> data) {
    if (data.length <= 2) {
      return data;
    }

    final int threshold = 100; // Adjust the threshold as needed
    final List<MonitoringPoint> sampled = [data.first];

    final double bucketSize = (data.length - 2) / (threshold - 2);
    int a = 0;

    for (int i = 0; i < threshold - 2; i++) {
      final int rangeStart = (i * bucketSize).floor() + 1;
      final int rangeEnd = ((i + 1) * bucketSize).floor() + 1;

      final List<MonitoringPoint> range = data.sublist(rangeStart, rangeEnd);

      double avgX = 0;
      double avgY = 0;
      for (var point in range) {
        avgX += point.timestamp.millisecondsSinceEpoch;
        avgY += point.value;
      }
      avgX /= range.length;
      avgY /= range.length;

      double maxArea = -1;
      MonitoringPoint nextPoint = range.first;

      for (var point in range) {
        final double area = (data[a].timestamp.millisecondsSinceEpoch - avgX) *
                (point.value - data[a].value) -
            (data[a].timestamp.millisecondsSinceEpoch -
                    point.timestamp.millisecondsSinceEpoch) *
                (avgY - data[a].value);

        if (area.abs() > maxArea) {
          maxArea = area.abs();
          nextPoint = point;
        }
      }

      sampled.add(nextPoint);
      a = data.indexOf(nextPoint);
    }

    sampled.add(data.last);
    return sampled;
  }
}
