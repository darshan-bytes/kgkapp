part of 'concept_list_bloc.dart';

sealed class ConceptListEvent extends Equatable {
  const ConceptListEvent();
}

final class ConceptListInitialEvent extends ConceptListEvent {
  const ConceptListInitialEvent();

  @override
  List<Object> get props => [];
}

final class ConceptListSearchEvent extends ConceptListEvent {
  const ConceptListSearchEvent();

  @override
  List<Object> get props => [];
}

final class ConceptListLoadMoreEvent extends ConceptListEvent {
  final int currentPage;

  const ConceptListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ConceptListPullToRefreshEvent extends ConceptListEvent {
  const ConceptListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
