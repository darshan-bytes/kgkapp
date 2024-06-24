part of 'monitoring_bloc.dart';

sealed class MonitoringEvent extends Equatable {
  const MonitoringEvent();
}

class MonitoringInitialEvent extends MonitoringEvent {
  @override
  List<Object> get props => [];
}

class MonitoringOnTabChangedEvent extends MonitoringEvent {
  final int index;

  const MonitoringOnTabChangedEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class MonitoringListingSearchEvent extends MonitoringEvent {
  @override
  List<Object> get props => [];
}

class MonitoringListingLoadMoreEvent extends MonitoringEvent {
  final int currentPage;

  const MonitoringListingLoadMoreEvent({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}
