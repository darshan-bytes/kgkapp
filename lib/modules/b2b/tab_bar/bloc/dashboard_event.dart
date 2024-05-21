part of 'dashboard_bloc.dart';

///[DashboardEvent] is a class that is used to define the events that are dispatched to the bloc
sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

///[DashboardChangeTabEvent] is a class that is dispatched to the bloc when the user changes the tab in the bottom navigation bar
final class DashboardChangeTabEvent extends DashboardEvent {
  final int index;

  const DashboardChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
