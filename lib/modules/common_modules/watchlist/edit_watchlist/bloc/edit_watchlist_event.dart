part of 'edit_watchlist_bloc.dart';

sealed class EditWatchlistEvent extends Equatable {
  const EditWatchlistEvent();
}

final class EditWatchlistInitialEvent extends EditWatchlistEvent {
  final bool isEdit;

  const EditWatchlistInitialEvent({this.isEdit = true});

  @override
  List<Object> get props => [isEdit];
}

final class EditWatchlistDurationChangedEvent extends EditWatchlistEvent {
  final Duration duration;

  const EditWatchlistDurationChangedEvent({required this.duration});

  @override
  List<Object> get props => [duration];
}
