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
