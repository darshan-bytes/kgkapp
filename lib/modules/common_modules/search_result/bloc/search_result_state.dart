part of 'search_result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();
}

final class SearchResultInitialState extends SearchResultState {
  @override
  List<Object> get props => [];
}

final class SearchResultLoadedState extends SearchResultState {
  const SearchResultLoadedState();

  @override
  List<Object> get props => [];
}

final class SearchResultReloadState extends SearchResultState {
  const SearchResultReloadState();

  @override
  List<Object> get props => [];
}

final class SearchResultChangeListingTypeState extends SearchResultState {
  const SearchResultChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class SearchResultLoadingMoreState extends SearchResultState {
  const SearchResultLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class SearchResultLoadedMoreState extends SearchResultState {
  final int currentPage;

  const SearchResultLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
