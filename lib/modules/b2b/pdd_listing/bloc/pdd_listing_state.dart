part of 'pdd_listing_bloc.dart';

sealed class PddListingState extends Equatable {
  const PddListingState();
}

final class PddListingInitial extends PddListingState {
  @override
  List<Object> get props => [];
}

final class PddListingReloadState extends PddListingState {
  @override
  List<Object> get props => [];
}

final class PddListingLoadedState extends PddListingState {
  @override
  List<Object> get props => [];
}

final class PddListingChangeListingTypeState extends PddListingState {
  @override
  List<Object> get props => [];
}

final class FilterPresentationState extends PddListingState {
  @override
  List<Object> get props => [];
}

final class PddListLoadedMoreState extends PddListingState {
  final int currentPage;

  const PddListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class PddListLoadingMoreState extends PddListingState {
  const PddListLoadingMoreState();

  @override
  List<Object> get props => [];
}
