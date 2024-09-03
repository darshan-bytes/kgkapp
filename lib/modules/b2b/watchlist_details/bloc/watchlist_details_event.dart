part of 'watchlist_details_bloc.dart';

sealed class WatchlistDetailsEvent extends Equatable {
  const WatchlistDetailsEvent();
}

final class WatchlistDetailsInitialEvent extends WatchlistDetailsEvent {
  final BuildContext context;
  final bool isInBackground;

  const WatchlistDetailsInitialEvent(this.context, {this.isInBackground = false});

  @override
  List<Object> get props => [context, isInBackground];
}

final class WatchlistDetailsLoadMoreEvent extends WatchlistDetailsEvent {
  final int currentPage;

  const WatchlistDetailsLoadMoreEvent({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class WatchlistDetailsEditProductEvent extends WatchlistDetailsEvent {
  final int index;
  final BuildContext context;
  final WatchlistActionType actionType;

  const WatchlistDetailsEditProductEvent({required this.index, required this.context, this.actionType = WatchlistActionType.edit});

  @override
  List<Object> get props => [index, context, actionType];
}
