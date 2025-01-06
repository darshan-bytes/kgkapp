part of 'edit_watchlist_bloc.dart';

sealed class EditWatchlistState extends Equatable {
  const EditWatchlistState();
}

final class EditWatchlistInitial extends EditWatchlistState {
  const EditWatchlistInitial();

  @override
  List<Object> get props => [];
}

final class EditWatchlistReloadState extends EditWatchlistState {
  const EditWatchlistReloadState();

  @override
  List<Object> get props => [];
}

final class EditWatchlistLoadedState extends EditWatchlistState {
  const EditWatchlistLoadedState();

  @override
  List<Object> get props => [];
}

final class EditWatchlistDurationChangedState extends EditWatchlistState {
  const EditWatchlistDurationChangedState();

  @override
  List<Object> get props => [];
}

final class EditWatchlistFieldErrorState extends EditWatchlistState {
  const EditWatchlistFieldErrorState();

  @override
  List<Object> get props => [];
}
