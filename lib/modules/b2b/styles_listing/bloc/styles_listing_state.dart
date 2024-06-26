part of 'styles_listing_bloc.dart';

sealed class StylesListingState extends Equatable {
  const StylesListingState();
}

final class StylesListingInitial extends StylesListingState {
  @override
  List<Object> get props => [];
}

final class StylesListingReloadState extends StylesListingState {
  @override
  List<Object> get props => [];
}

final class StylesListingLoadedState extends StylesListingState {
  const StylesListingLoadedState();

  @override
  List<Object> get props => [];
}

final class StylesListingLoadingMoreState extends StylesListingState {
  const StylesListingLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class StylesListingLoadedMoreState extends StylesListingState {
  final int currentPage;

  const StylesListingLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
