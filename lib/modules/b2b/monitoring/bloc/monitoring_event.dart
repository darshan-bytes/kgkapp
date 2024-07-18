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
  final MonitoringTab listType;

  const MonitoringListingLoadMoreEvent({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}

class MonitoringSelectedDesignerEvent extends MonitoringEvent {
  final DesignerListModel designer;

  const MonitoringSelectedDesignerEvent({required this.designer});

  @override
  List<Object> get props => [designer];
}

class MonitoringDesignerLoadMoreEvent extends MonitoringEvent {
  final int currentPage;

  const MonitoringDesignerLoadMoreEvent({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class MonitoringListPullToRefreshEvent extends MonitoringEvent {
  final MonitoringTab listType;

  const MonitoringListPullToRefreshEvent({required this.listType});

  @override
  List<Object> get props => [listType];
}
