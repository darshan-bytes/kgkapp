part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

final class WatchlistInitialEvent extends WatchlistEvent {
  final BuildContext context;

  const WatchlistInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class WatchlistLoadMoreEvent extends WatchlistEvent {
  final int currentPage;
  final BuildContext context;

  const WatchlistLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage, context];
}

final class WatchlistPullToRefreshEvent extends WatchlistEvent {
  final BuildContext context;

  const WatchlistPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class WatchListCloseEvent extends WatchlistEvent {
  const WatchListCloseEvent();

  @override
  List<Object> get props => [];
}

final class WatchListSearchEvent extends WatchlistEvent {
  final String searchQuery;
  final BuildContext context;

  const WatchListSearchEvent(this.searchQuery, this.context);

  @override
  List<Object> get props => [searchQuery, context];
}

final class WatchListDeleteEvent extends WatchlistEvent {
  final String? watchlistId;
  final BuildContext context;
  final BuildContext screenContext;

  const WatchListDeleteEvent(this.watchlistId, this.context, this.screenContext);

  @override
  List<Object?> get props => [watchlistId, context, screenContext];
}

final class WatchListLoadFullListEvent extends WatchlistEvent {
  final BuildContext context;

  const WatchListLoadFullListEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class WatchListFilterEvent extends WatchlistEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const WatchListFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class WatchListUpdateItemEvent extends WatchlistEvent {
  final WatchlistData? watchlistData;
  final bool? isWatchlistDeleted;
  final int index;

  const WatchListUpdateItemEvent({
    this.watchlistData,
    this.isWatchlistDeleted,
    required this.index,
  });

  @override
  List<Object?> get props => [watchlistData, index, isWatchlistDeleted];
}
