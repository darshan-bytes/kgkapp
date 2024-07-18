part of 'project_listing_bloc.dart';

sealed class ProjectListingEvent extends Equatable {
  const ProjectListingEvent();
}

final class InitialProjectListingEvent extends ProjectListingEvent {
  final BuildContext context;

  const InitialProjectListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ProjectListLoadMoreEvent extends ProjectListingEvent {
  final int currentPage;

  const ProjectListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ProjectListPullToRefreshEvent extends ProjectListingEvent {
  const ProjectListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
