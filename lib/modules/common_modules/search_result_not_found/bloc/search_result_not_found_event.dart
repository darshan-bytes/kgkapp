part of 'search_result_not_found_bloc.dart';

sealed class SearchResultNotFoundEvent extends Equatable {
  const SearchResultNotFoundEvent();

  @override
  List<Object> get props => [];
}

final class InitialSearchResultNotFoundEvent extends SearchResultNotFoundEvent {
  final BuildContext context;

  const InitialSearchResultNotFoundEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class GetSearchResultNotFoundProductListEvent extends SearchResultNotFoundEvent {
  const GetSearchResultNotFoundProductListEvent();

  @override
  List<Object> get props => [];
}
