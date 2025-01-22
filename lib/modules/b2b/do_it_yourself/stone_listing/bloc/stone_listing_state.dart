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

final class StoneProductLoadedState extends StoneListingState {
  const StoneProductLoadedState();

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
  @override
  List<Object> get props => [];
}

final class StoneProductReloadState extends StoneListingState {
  const StoneProductReloadState();

  @override
  List<Object> get props => [];
}

final class StoneListLoadingMoreState extends StoneListingState {
  @override
  List<Object> get props => [];
}

final class StoneListLoadedMoreState extends StoneListingState {
  final int currentPage;

  const StoneListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class StoneDiamondListLoadedState extends StoneListingState {
  const StoneDiamondListLoadedState();

  @override
  List<Object> get props => [];
}

final class StoneListLoadingState extends StoneListingState {
  final bool isFirst;

  const StoneListLoadingState({
    this.isFirst = false,
  });

  @override
  List<Object> get props => [];
}
