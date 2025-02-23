import 'dart:developer';

import 'package:bloc/bloc.dart';

/// A custom [BlocObserver] for monitoring state changes and errors in the application.
///
/// This observer logs state changes and errors for all Blocs and Cubits in the application.
class EnergyMonitorBlocObserver extends BlocObserver {
  /// Creates an instance of [EnergyMonitorBlocObserver].
  const EnergyMonitorBlocObserver();

  /// Called whenever a [Bloc] or [Cubit] changes its state.
  ///
  /// The [bloc] parameter is the instance of the [Bloc] or [Cubit] that changed its state.
  /// The [change] parameter contains the details of the state change.
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} $change');
  }

  /// Called whenever a [Bloc] or [Cubit] encounters an error.
  ///
  /// The [bloc] parameter is the instance of the [Bloc] or [Cubit] that encountered the error.
  /// The [error] parameter contains the error that was thrown.
  /// The [stackTrace] parameter contains the stack trace of the error.
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
