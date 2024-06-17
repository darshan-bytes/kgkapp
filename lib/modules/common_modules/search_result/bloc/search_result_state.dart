part of 'search_result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

final class SearchResultInitialState extends SearchResultState {}

final class SearchResultReloadState extends SearchResultState {}

final class SearchResultChangeListingTypeState extends SearchResultState {
  final bool isGrid;

  const SearchResultChangeListingTypeState(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

final class SearchResultProductChangePageNumberState extends SearchResultState {}
