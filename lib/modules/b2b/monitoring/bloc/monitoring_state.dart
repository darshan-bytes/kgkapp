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
  @override
  List<Object> get props => [];
}

class MonitoringListLoadedState extends MonitoringState {
  @override
  List<Object> get props => [];
}

class MonitoringListLoadedMoreState extends MonitoringState {
  final int currentPage;

  const MonitoringListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
