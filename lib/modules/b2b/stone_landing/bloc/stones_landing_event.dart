part of 'stones_landing_bloc.dart';

sealed class StonesLandingEvent extends Equatable {
  const StonesLandingEvent();
}

class InitialStonesLandingEvent extends StonesLandingEvent {
  final BuildContext context;

  const InitialStonesLandingEvent({required this.context});

  @override
  List<Object> get props => [];
}

class PullToRefreshStonesLandingEvent extends StonesLandingEvent {
  final BuildContext context;

  const PullToRefreshStonesLandingEvent({required this.context});

  @override
  List<Object> get props => [];
}
