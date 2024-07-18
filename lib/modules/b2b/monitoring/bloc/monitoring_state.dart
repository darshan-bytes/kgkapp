part of 'monitoring_bloc.dart';

sealed class MonitoringState extends Equatable {
  const MonitoringState();
}

final class MonitoringInitialState extends MonitoringState {
  const MonitoringInitialState();

  @override
  List<Object> get props => [];
}

class MonitoringOnTabChangedState extends MonitoringState {
  const MonitoringOnTabChangedState();

  @override
  List<Object> get props => [];
}

class MonitoringReloadState extends MonitoringState {
  const MonitoringReloadState();

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

class MonitoringDesignerLoadMoreState extends MonitoringState {
  const MonitoringDesignerLoadMoreState();

  @override
  List<Object> get props => [];
}

class MonitoringDesignerListLoadedState extends MonitoringState {
  final int currentPage;

  const MonitoringDesignerListLoadedState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
