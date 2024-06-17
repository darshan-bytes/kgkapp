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
  final bool isGrid;

  const SearchResultChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

final class SearchResultProductChangePageNumberEvent extends SearchResultEvent {
  final String pageNumber;

  const SearchResultProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
