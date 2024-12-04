part of 'collection_bloc.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();
}

final class CollectionInitial extends CollectionState {
  @override
  List<Object> get props => [];
}

final class CollectionReloadState extends CollectionState {
  @override
  List<Object> get props => [];
}

final class CollectionMasterListLoadedState extends CollectionState {
  @override
  List<Object> get props => [];
}

final class CollectionListLoadingMoreState extends CollectionState {
  @override
  List<Object> get props => [];
}

final class CollectionListLoadedMoreState extends CollectionState {
  final int currentPage;

  const CollectionListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class CollectionLoadingState extends CollectionState {
  @override
  List<Object> get props => [];
}
