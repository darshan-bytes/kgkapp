part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class InitialSearchEvent extends SearchEvent {
  @override
  List<Object> get props => [];
}
