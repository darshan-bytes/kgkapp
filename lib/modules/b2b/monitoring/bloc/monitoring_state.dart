part of 'monitoring_bloc.dart';

sealed class MonitoringState extends Equatable {
  const MonitoringState();
}

final class MonitoringInitialState extends MonitoringState {
  @override
  List<Object> get props => [];
}

class MonitoringOnTabChangedState extends MonitoringState {
  @override
  List<Object> get props => [];
}

class MonitoringReloadState extends MonitoringState {
  @override
  List<Object> get props => [];
}

class MonitoringLoadingMoreState extends MonitoringState {
  final MonitoringTab listType;

  const MonitoringLoadingMoreState(this.listType);

  @override
  List<Object> get props => [listType];
}

class MonitoringListLoadedState extends MonitoringState {
  const MonitoringListLoadedState();

  @override
  List<Object> get props => [];
}

class MonitoringListLoadedMoreState extends MonitoringState {
  final int currentPage;
  final MonitoringTab listType;

  const MonitoringListLoadedMoreState(this.currentPage, this.listType);

  @override
  List<Object> get props => [currentPage, listType];
}



class MonitoringSelectedDesignerState extends MonitoringState {
  final DesignerListModel designer;

  const MonitoringSelectedDesignerState(this.designer);

  @override
  List<Object> get props => [designer];
}
