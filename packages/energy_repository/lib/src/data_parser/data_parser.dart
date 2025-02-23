import 'dart:isolate';

import 'package:databases/databases.dart';
import 'package:energy_api_client/energy_api_client.dart';

import '../models/models.dart';

abstract class DataParser {
  Future<List<MonitoringEnergy>> parseDto(List<MonitoringDataPointDto> dto);

  Future<List<MonitoringDataPointCompanion>> convertToCompanion(
      List<MonitoringEnergy> dataPoints, String category);
}

// Implementation of data parsing using isolates
class IsolateDataParser implements DataParser {
  @override
  Future<List<MonitoringEnergy>> parseDto(
      List<MonitoringDataPointDto> dto) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateFunction, [receivePort.sendPort, dto]);
    return await receivePort.first;
  }

  @override
  Future<List<MonitoringDataPointCompanion>> convertToCompanion(
      List<MonitoringEnergy> dataPoints, String category) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_companionIsolateFunction, [
      receivePort.sendPort,
      dataPoints,
      category,
    ]);
    return await receivePort.first;
  }

  static void _isolateFunction(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final List<MonitoringDataPointDto> dto = args[1];
    final result = dto.map((d) => MonitoringEnergy.fromDto(d)).toList();
    sendPort.send(result);
  }

  static void _companionIsolateFunction(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final List<MonitoringEnergy> dataPoints = args[1];
    final String category = args[2];
    final result = dataPoints
        .map((dataPoint) => MonitoringDataPointCompanion.insert(
              category: category,
              timeStamp: dataPoint.timestamp,
              value: dataPoint.value,
            ))
        .toList();
    sendPort.send(result);
  }
}
