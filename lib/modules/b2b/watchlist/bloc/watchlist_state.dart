part of 'watchlist_bloc.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();
}

final class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();

  @override
  List<Object> get props => [];
}

final class WatchlistLoadingState extends WatchlistState {
  const WatchlistLoadingState();

  @override
  List<Object> get props => [];
}

final class WatchlistLoadedState extends WatchlistState {
  const WatchlistLoadedState();

  @override
  List<Object> get props => [];
}

final class WatchlistLoadedMoreState extends WatchlistState {
  final int currentPage;

  const WatchlistLoadedMoreState({
    required this.currentPage,
  });

  @override
  List<Object> get props => [currentPage];
}

final class WatchlistReloadState extends WatchlistState {
  const WatchlistReloadState();

  @override
  List<Object> get props => [];
}

final class WatchlistLoadingMoreState extends WatchlistState {
  const WatchlistLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class WatchlistDeleteState extends WatchlistState {
  const WatchlistDeleteState();

  @override
  List<Object> get props => [];
}
