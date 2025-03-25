part of 'concept_list_bloc.dart';

sealed class ConceptListEvent extends Equatable {
  const ConceptListEvent();
}

final class ConceptListInitialEvent extends ConceptListEvent {
  final BuildContext context;

  const ConceptListInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ConceptListSearchEvent extends ConceptListEvent {
  const ConceptListSearchEvent();

  @override
  List<Object> get props => [];
}

final class ConceptListLoadMoreEvent extends ConceptListEvent {
  final BuildContext context;
  final int currentPage;

  const ConceptListLoadMoreEvent(this.context,this.currentPage);

  @override
  List<Object> get props => [context,currentPage];
}

final class ConceptListPullToRefreshEvent extends ConceptListEvent {
  final BuildContext context;

  const ConceptListPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ConceptListFilterEvent extends ConceptListEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const ConceptListFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
