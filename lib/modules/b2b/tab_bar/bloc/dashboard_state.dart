part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardChangeTabState extends DashboardState {
  final int index;

  const DashboardChangeTabState(this.index);

  @override
  List<Object> get props => [index];
}
