part of 'find_store_bloc.dart';

sealed class FindStoreState extends Equatable {
  const FindStoreState();
}

final class FindStoreInitial extends FindStoreState {
  @override
  List<Object> get props => [];
}

final class FindReloadState extends FindStoreState {
  @override
  List<Object> get props => [];
}

final class FindStorePaginationInitializedState extends FindStoreState {
  const FindStorePaginationInitializedState();

  @override
  List<Object> get props => [];
}

final class FindStoreAddressLoadedState extends FindStoreState {
  const FindStoreAddressLoadedState();

  @override
  List<Object> get props => [];
}

final class FindStoreShowFullAddressState extends FindStoreState {
  final int index;
  final int oldIndex;
  final bool isExpanded;

  const FindStoreShowFullAddressState(this.index, this.oldIndex, this.isExpanded);

  @override
  List<Object> get props => [index, oldIndex, isExpanded];
}

final class FindStoreChangeTypeState extends FindStoreState {
  @override
  List<Object> get props => [];
}

final class FindStoreLoadingMoreState extends FindStoreState {
  @override
  List<Object> get props => [];
}

final class FindStoreLoadedMoreState extends FindStoreState {
  final int currentPage;

  const FindStoreLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
