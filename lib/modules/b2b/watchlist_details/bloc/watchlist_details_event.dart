part of 'watchlist_details_bloc.dart';

sealed class WatchlistDetailsEvent extends Equatable {
  const WatchlistDetailsEvent();
}

final class WatchlistDetailsInitialEvent extends WatchlistDetailsEvent {
  final BuildContext context;

  const WatchlistDetailsInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class WatchlistDetailsLoadMoreEvent extends WatchlistDetailsEvent {
  final int currentPage;

  const WatchlistDetailsLoadMoreEvent({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}
