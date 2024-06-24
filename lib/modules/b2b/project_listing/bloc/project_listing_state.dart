part of 'project_listing_bloc.dart';

sealed class ProjectListingState extends Equatable {
  const ProjectListingState();
}

final class ProjectListingInitial extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class ProjectListingReloadState extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class ProjectListingLoadedState extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class ProjectListingChangeListingTypeState extends ProjectListingState {
  @override
  List<Object> get props => [];
}

final class FilterProjectState extends ProjectListingState {
  @override
  List<Object> get props => [];
}
