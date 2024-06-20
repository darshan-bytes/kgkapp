part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardReloadState extends DashboardState {
  const DashboardReloadState();

  @override
  List<Object?> get props => [];
}

final class DashboardLoadedState extends DashboardState {
  const DashboardLoadedState();

  @override
  List<Object> get props => [];
}

final class DashboardDateRangeChangeState extends DashboardState {
  const DashboardDateRangeChangeState();

  @override
  List<Object?> get props => [];
}
