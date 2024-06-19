part of 'landing_bloc.dart';

///[LandingState] is a class that is used to define the states that are emitted by the bloc to the UI
sealed class LandingState extends Equatable {
  const LandingState();
}

///[LandingInitialState] is a class that is emitted by the bloc when the screen is loaded for the first time
final class LandingInitialState extends LandingState {
  @override
  List<Object> get props => [];
}

final class LandingLoadedState extends LandingState {
  final UserType userType;
  final List<Widget> pages;
  final List<Bloc> blocList;

  const LandingLoadedState({
    required this.userType,
    required this.pages,
    required this.blocList,
  });

  @override
  List<Object> get props => [userType, pages, blocList];
}

///[LandingChangeTabState] is a class that is emitted by the bloc when the user changes the
///tab in the bottom navigation bar and it contains the new index of the tab.
final class LandingChangeTabState extends LandingState {
  final int index;

  const LandingChangeTabState(this.index);

  @override
  List<Object> get props => [index];
}
