part of 'concept_list_bloc.dart';

sealed class ConceptListState extends Equatable {
  const ConceptListState();
}

final class ConceptListInitial extends ConceptListState {
  @override
  List<Object> get props => [];
}

final class ConceptListReloadState extends ConceptListState {
  @override
  List<Object> get props => [];
}

final class ConceptListLoadedState extends ConceptListState {
  const ConceptListLoadedState();

  @override
  List<Object> get props => [];
}

final class ConceptListLoadingMoreState extends ConceptListState {
  const ConceptListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ConceptListLoadedMoreState extends ConceptListState {
  final int currentPage;

  const ConceptListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
