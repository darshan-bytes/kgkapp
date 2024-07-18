part of 'styles_listing_bloc.dart';

sealed class StylesListingEvent extends Equatable {
  const StylesListingEvent();
}

final class StylesListingInitialEvent extends StylesListingEvent {
  const StylesListingInitialEvent();

  @override
  List<Object> get props => [];
}

final class StylesListingSearchEvent extends StylesListingEvent {
  const StylesListingSearchEvent();

  @override
  List<Object> get props => [];
}

final class StylesListingLoadMoreEvent extends StylesListingEvent {
  final int currentPage;

  const StylesListingLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class StylesListingPullToRefreshEvent extends StylesListingEvent {
  const StylesListingPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
