part of 'add_to_watchlist_bloc.dart';

enum WatchlistActionType { add, edit, remove }

sealed class AddToWatchlistEvent extends Equatable {
  const AddToWatchlistEvent();
}

final class AddToWatchlistInitialEvent extends AddToWatchlistEvent {
  final ProductDetailsModel productDetails;
  final WatchlistActionType actionType;
  final BuildContext context;
  final WatchlistData? watchlistData;

  const AddToWatchlistInitialEvent.add(this.productDetails, this.context) : actionType = WatchlistActionType.add, watchlistData = null;

  const AddToWatchlistInitialEvent.edit(this.productDetails, this.context, this.watchlistData) : actionType = WatchlistActionType.edit;

  const AddToWatchlistInitialEvent.remove(this.productDetails, this.context, this.watchlistData) : actionType = WatchlistActionType.remove;

  @override
  List<Object> get props => [productDetails, actionType];
}

final class WatchlistChangeNameEvent extends AddToWatchlistEvent {
  final WatchlistData selectedWatchlist;

  const WatchlistChangeNameEvent(this.selectedWatchlist);

  @override
  List<Object> get props => [selectedWatchlist];
}

class WatchlistCheckEvent extends AddToWatchlistEvent {
  final int index;

  const WatchlistCheckEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class AddToWatchListSaveEvent extends AddToWatchlistEvent {
  final BuildContext context;

  const AddToWatchListSaveEvent(this.context);

  @override
  List<Object> get props => [context];
}
