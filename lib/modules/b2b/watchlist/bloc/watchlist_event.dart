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
