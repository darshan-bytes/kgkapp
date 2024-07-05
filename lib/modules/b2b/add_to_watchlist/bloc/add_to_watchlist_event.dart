part of 'add_to_watchlist_bloc.dart';

enum WatchlistActionType { add, edit, remove }

sealed class AddToWatchlistEvent extends Equatable {
  const AddToWatchlistEvent();
}

final class AddToWatchlistInitialEvent extends AddToWatchlistEvent {
  final ProductDetails productDetails;
  final WatchlistActionType actionType;

  const AddToWatchlistInitialEvent.add(this.productDetails) : actionType = WatchlistActionType.add;

  const AddToWatchlistInitialEvent.edit(this.productDetails) : actionType = WatchlistActionType.edit;

  const AddToWatchlistInitialEvent.remove(this.productDetails) : actionType = WatchlistActionType.remove;

  @override
  List<Object> get props => [productDetails, actionType];
}

final class WatchlistChangeNameEvent extends AddToWatchlistEvent {
  final WatchlistDetailsModel selectedWatchlist;

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
