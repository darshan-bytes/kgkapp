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

final class ProjectChangeListingTypeEvent extends ProjectListingEvent {
  const ProjectChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class FilterProjectEvent extends ProjectListingEvent {
  const FilterProjectEvent();

  @override
  List<Object> get props => [];
}
