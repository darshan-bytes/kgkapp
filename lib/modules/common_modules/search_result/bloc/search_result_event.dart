part of 'search_result_bloc.dart';

sealed class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

final class InitialSearchResultEvent extends SearchResultEvent {
  final BuildContext context;

  const InitialSearchResultEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class GetSearchResultProductListEvent extends SearchResultEvent {
  const GetSearchResultProductListEvent();

  @override
  List<Object> get props => [];
}

final class SearchResultChangeListingTypeEvent extends SearchResultEvent {
  const SearchResultChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class LoadMoreSearchResultEvent extends SearchResultEvent {
  final int currentPage;

  const LoadMoreSearchResultEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class SearchResultPullToRefreshEvent extends SearchResultEvent {
  const SearchResultPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
