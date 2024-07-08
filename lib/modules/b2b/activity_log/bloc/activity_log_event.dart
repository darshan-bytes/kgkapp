part of 'activity_log_bloc.dart';

sealed class ActivityLogEvent extends Equatable {
  const ActivityLogEvent();
}

class ActivityLogInitialEvent extends ActivityLogEvent {
  @override
  List<Object> get props => [];
}
