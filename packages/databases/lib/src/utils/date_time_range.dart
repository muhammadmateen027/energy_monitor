import 'package:meta/meta.dart';

@internal
@visibleForTesting
class DateTimeRange {
  DateTimeRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  factory DateTimeRange.getDayRange(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    return DateTimeRange(start: startOfDay, end: endOfDay);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
