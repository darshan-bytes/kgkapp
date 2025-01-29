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
  final bool isFirst;

  const WatchlistDetailsLoaded({this.isFirst = true});

  @override
  List<Object> get props => [isFirst];
}

final class WatchlistDetailsTimerState extends WatchlistDetailsState {
  const WatchlistDetailsTimerState();

  @override
  List<Object> get props => [];
}
