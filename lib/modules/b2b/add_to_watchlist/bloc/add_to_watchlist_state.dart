part of 'add_to_watchlist_bloc.dart';

sealed class AddToWatchlistState extends Equatable {
  const AddToWatchlistState();
}

final class AddToWatchlistInitial extends AddToWatchlistState {
  const AddToWatchlistInitial();

  @override
  List<Object> get props => [];
}

final class AddToWatchlistReloadState extends AddToWatchlistState {
  const AddToWatchlistReloadState();

  @override
  List<Object> get props => [];
}

final class AddToWatchlistLoadedState extends AddToWatchlistState {
  const AddToWatchlistLoadedState();

  @override
  List<Object> get props => [];
}

final class WatchlistChangeNameState extends AddToWatchlistState {
  const WatchlistChangeNameState();

  @override
  List<Object> get props => [];
}

final class WatchlistSelectedState extends AddToWatchlistState {
  final int index;

  const WatchlistSelectedState(this.index);

  @override
  List<Object> get props => [index];
}
