part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

final class WatchlistInitialEvent extends WatchlistEvent {
  @override
  List<Object> get props => [];
}

final class WatchlistLoadMoreEvent extends WatchlistEvent {
  final int currentPage;

  const WatchlistLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class WatchlistPullToRefreshEvent extends WatchlistEvent {
  const WatchlistPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
