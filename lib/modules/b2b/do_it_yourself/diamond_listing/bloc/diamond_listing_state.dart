part of 'diamond_listing_bloc.dart';

abstract class DiamondListingState extends Equatable {
  const DiamondListingState();
}

final class DiamondListingInitial extends DiamondListingState {
  const DiamondListingInitial();

  @override
  List<Object> get props => [];
}

final class LoadingState extends DiamondListingState{
  const LoadingState();

  @override
  List<Object> get props => [];
}

final class DiamondChangeTypeState extends DiamondListingState {
  final bool isIndividual;

  const DiamondChangeTypeState(this.isIndividual);

  @override
  List<Object> get props => [isIndividual];
}

class ChangeListingTypeState extends DiamondListingState {
  final bool isGrid;

  const ChangeListingTypeState(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

final class DiamondProductChangePageNumberState extends DiamondListingState {
  @override
  List<Object> get props => [];
}

final class DiamondProductReloadState extends DiamondListingState {
  @override
  List<Object> get props => [];
}

