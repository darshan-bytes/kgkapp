part of 'watchlist_details_bloc.dart';

sealed class WatchlistDetailsState extends Equatable {
  const WatchlistDetailsState();
}

final class WatchlistDetailsInitial extends WatchlistDetailsState {
  const WatchlistDetailsInitial();

  @override
  List<Object> get props => [];
}

final class WatchlistDetailsReload extends WatchlistDetailsState {
  const WatchlistDetailsReload();

  @override
  List<Object> get props => [];
}

final class WatchlistDetailsLoading extends WatchlistDetailsState {
  const WatchlistDetailsLoading();

  @override
  List<Object> get props => [];
}

final class WatchlistDetailsLoaded extends WatchlistDetailsState {
  const WatchlistDetailsLoaded();

  @override
  List<Object> get props => [];
}
