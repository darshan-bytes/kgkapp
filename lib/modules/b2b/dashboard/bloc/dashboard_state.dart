part of 'dashboard_bloc.dart';

///[DashboardState] is a class that is used to define the states that are emitted by the bloc to the UI
sealed class DashboardState extends Equatable {
  const DashboardState();
}

///[DashboardInitialState] is a class that is emitted by the bloc when the screen is loaded for the first time
final class DashboardInitialState extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardLoadedState extends DashboardState {
  final UserType userType;
  final List<Widget> pages;
  final List<Bloc> blocList;

  const DashboardLoadedState({
    required this.userType,
    required this.pages,
    required this.blocList,
  });

  @override
  List<Object> get props => [userType, pages, blocList];
}

///[DashboardChangeTabState] is a class that is emitted by the bloc when the user changes the
///tab in the bottom navigation bar and it contains the new index of the tab.
final class DashboardChangeTabState extends DashboardState {
  final int index;

  const DashboardChangeTabState(this.index);

  @override
  List<Object> get props => [index];
}
