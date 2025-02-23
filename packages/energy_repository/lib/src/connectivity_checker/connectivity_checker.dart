import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../energy_repository.dart';

abstract class ConnectivityChecker {
  Future<void> checkConnection();
}

class InternetConnectivityChecker implements ConnectivityChecker {
  InternetConnectivityChecker(this._internetConnection);

  final InternetConnection _internetConnection;

  @override
  Future<void> checkConnection() async {
    final hasConnection = await _internetConnection.hasInternetAccess;
    if (!hasConnection) throw InternetConnectionException();
  }
}
