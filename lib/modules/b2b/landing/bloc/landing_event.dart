part of 'landing_bloc.dart';

///[LandingEvent] is a class that is used to define the events that are dispatched to the bloc
sealed class LandingEvent extends Equatable {
  const LandingEvent();
}

final class LandingInitialEvent extends LandingEvent {
  final BuildContext context;

  const LandingInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

///[LandingChangeTabEvent] is a class that is dispatched to the bloc when the user changes the tab in the bottom navigation bar
final class LandingChangeTabEvent extends LandingEvent {
  final int index;
  final BuildContext context;

  const LandingChangeTabEvent(this.index, {required this.context});

  @override
  List<Object> get props => [index, context];
}

///[LandingLogoutEvent] is a class that is dispatched to the bloc when the user logs out
final class LandingLogoutEvent extends LandingEvent {
  const LandingLogoutEvent();

  @override
  List<Object> get props => [];
}

final class LandingChangeMyBagCountEvent extends LandingEvent {
  final int count;

  const LandingChangeMyBagCountEvent(this.count);

  @override
  List<Object> get props => [count];
}
