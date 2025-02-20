part of 'dashboard_cubit.dart';

enum DashboardTab { solar, house, battery }

class DashboardState extends Equatable {
  const DashboardState({
    this.tab = DashboardTab.solar,
  });

  const DashboardState.initial() : tab = DashboardTab.solar;

  final DashboardTab tab;

  DashboardState copyWith({
    DashboardTab? tab,
  }) {
    return DashboardState(
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [tab];
}
