part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

final class DashboardInitialEvent extends DashboardEvent {
  const DashboardInitialEvent();

  @override
  List<Object> get props => [];
}

final class DashboardDateRangeChangeEvent extends DashboardEvent {
  final DashboardDateRangeDataModel dateRange;

  const DashboardDateRangeChangeEvent(this.dateRange);

  @override
  List<Object> get props => [dateRange];
}
