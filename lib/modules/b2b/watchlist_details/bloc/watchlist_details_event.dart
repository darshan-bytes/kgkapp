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

final class WatchlistDetailsEditProductEvent extends WatchlistDetailsEvent {
  final int index;
  final BuildContext context;
  final WatchlistActionType actionType;

  const WatchlistDetailsEditProductEvent({required this.index, required this.context, this.actionType = WatchlistActionType.edit});

  @override
  List<Object> get props => [index, context, actionType];
}

final class WatchlistDetailsSearchEvent extends WatchlistDetailsEvent {
  final String searchQuery;

  const WatchlistDetailsSearchEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}

final class WatchlistDetailsDeleteEvent extends WatchlistDetailsEvent {
  final BuildContext context;
  final BuildContext screenContext;

  const WatchlistDetailsDeleteEvent({required this.context, required this.screenContext});

  @override
  List<Object> get props => [context, screenContext];
}

final class WatchlistDetailsTimerEvent extends WatchlistDetailsEvent {
  const WatchlistDetailsTimerEvent();

  @override
  List<Object> get props => [];
}
