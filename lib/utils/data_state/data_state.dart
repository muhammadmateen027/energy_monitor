import 'package:equatable/equatable.dart';

class DataState extends Equatable {
  const DataState._({required this.loadingState, this.exception});

  /// Initial state
  const DataState.none()
      : this._(loadingState: LoadingState.none, exception: null);

  /// Error state
  const DataState.error(Object exception)
      : this._(loadingState: LoadingState.error, exception: exception);

  /// Background loading state - show parts of UI
  const DataState.partial()
      : this._(loadingState: LoadingState.partial, exception: null);

  /// Data state is fully loaded - show the UI
  const DataState.full()
      : this._(loadingState: LoadingState.full, exception: null);

  /// Foreground loading state
  const DataState.loading()
      : this._(loadingState: LoadingState.loading, exception: null);

  final LoadingState loadingState;
  final Object? exception;

  bool get hasException => loadingState == LoadingState.error;

  bool get isLoading => loadingState == LoadingState.loading;

  bool get isFull => loadingState == LoadingState.full;

  bool get isNone => loadingState == LoadingState.none;

  bool get isPartial => loadingState == LoadingState.partial;

  @override
  List<Object?> get props => [loadingState, exception];
}

enum LoadingState { none, partial, loading, full, error }
