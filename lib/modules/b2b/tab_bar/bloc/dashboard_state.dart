part of 'dashboard_bloc.dart';

///[DashboardState] is a class that is used to define the states that are emitted by the bloc to the UI
sealed class DashboardState extends Equatable {
  const DashboardState();
}

///[DashboardInitial] is a class that is emitted by the bloc when the screen is loaded for the first time
final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

///[DashboardChangeTabState] is a class that is emitted by the bloc when the user changes the
///tab in the bottom navigation bar and it contains the new index of the tab.
final class DashboardChangeTabState extends DashboardState {
  final int index;

  const DashboardChangeTabState(this.index);

  @override
  List<Object> get props => [index];
}
