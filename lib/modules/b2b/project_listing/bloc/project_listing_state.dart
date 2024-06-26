part of 'project_listing_bloc.dart';

sealed class ProjectListingState extends Equatable {
  const ProjectListingState();
}

final class ProjectListingInitial extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class ProjectListingLoadedState extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class ProjectListLoadingMoreState extends ProjectListingState {
  const ProjectListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ProjectListLoadedMoreState extends ProjectListingState {
  final int currentPage;

  const ProjectListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
