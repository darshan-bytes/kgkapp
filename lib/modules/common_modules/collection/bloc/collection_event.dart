part of 'collection_bloc.dart';

sealed class CollectionEvent extends Equatable {
  const CollectionEvent();
}

final class CollectionInitialEvent extends CollectionEvent {
  final BuildContext context;

  const CollectionInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ChangeCollectionTabsEvent extends CollectionEvent {
  final int index;
  final BuildContext context;

  const ChangeCollectionTabsEvent({required this.context, required this.index});

  @override
  List<Object> get props => [context, index];
}

final class CollectionListLoadMoreEvent extends CollectionEvent {
  final int currentPage;
  final BuildContext context;

  const CollectionListLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage, context];
}

final class CollectionListPullToRefreshEvent extends CollectionEvent {
  final BuildContext context;

  const CollectionListPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}
