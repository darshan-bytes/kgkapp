part of 'stone_listing_bloc.dart';

sealed class StoneListingState extends Equatable {
  const StoneListingState();

  @override
  List<Object> get props => [];
}

final class StoneListingInitial extends StoneListingState {
  const StoneListingInitial();

  @override
  List<Object> get props => [];
}

final class StoneLoadingState extends StoneListingState {
  const StoneLoadingState();

  @override
  List<Object> get props => [];
}

final class StoneChangeTypeState extends StoneListingState {
  final bool isInitialToggle;

  const StoneChangeTypeState(this.isInitialToggle);

  @override
  List<Object> get props => [isInitialToggle];
}

class StoneChangeListingTypeState extends StoneListingState {
  final bool isGrid;

  const StoneChangeListingTypeState(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

final class StoneProductChangePageNumberState extends StoneListingState {
  @override
  List<Object> get props => [];
}

final class StoneProductReloadState extends StoneListingState {
  @override
  List<Object> get props => [];
}

