part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

final class DashboardChangeTabEvent extends DashboardEvent {
  final int index;

  const DashboardChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
