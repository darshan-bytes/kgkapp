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

final class DiamondStrapiDataFetchedState extends StonesLandingState {
  const DiamondStrapiDataFetchedState();

  @override
  List<Object> get props => [];
}

final class GemstoneStrapiDataFetchedState extends StonesLandingState {
  const GemstoneStrapiDataFetchedState();

  @override
  List<Object> get props => [];
}

final class DiamondStrapiDataErrorState extends StonesLandingState {
  final ErrorResponse errorResponse;

  const DiamondStrapiDataErrorState({required this.errorResponse});

  @override
  List<Object> get props => [errorResponse];
}

final class GemstoneStrapiDataErrorState extends StonesLandingState {
  final ErrorResponse errorResponse;

  const GemstoneStrapiDataErrorState({required this.errorResponse});

  @override
  List<Object> get props => [errorResponse];
}

final class JewelleryStrapiDataFetchedState extends StonesLandingState {
  const JewelleryStrapiDataFetchedState();

  @override
  List<Object> get props => [];
}

final class JewelleryStrapiDataErrorState extends StonesLandingState {
  final ErrorResponse errorResponse;

  const JewelleryStrapiDataErrorState({required this.errorResponse});

  @override
  List<Object> get props => [errorResponse];
}
