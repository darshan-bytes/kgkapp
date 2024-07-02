part of 'stones_landing_bloc.dart';

sealed class StonesLandingState extends Equatable {
  const StonesLandingState();
}

final class InitialStoneLandingState extends StonesLandingState {
  @override
  List<Object> get props => [];
}

final class DiamondLandingReloadState extends StonesLandingState {
  @override
  List<Object> get props => [];
}
