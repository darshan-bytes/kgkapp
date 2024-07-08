part of 'activity_log_bloc.dart';

sealed class ActivityLogState extends Equatable {
  const ActivityLogState();
}

final class ActivityLogInitial extends ActivityLogState {
  @override
  List<Object> get props => [];
}

final class ActivityLogReloadState extends ActivityLogState {
  @override
  List<Object> get props => [];
}

final class ActivityLogLoadedState extends ActivityLogState {
  const ActivityLogLoadedState();

  @override
  List<Object> get props => [];
}
