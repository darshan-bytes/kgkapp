part of 'exhibition_details_bloc.dart';

sealed class ExhibitionDetailsEvent extends Equatable {
  const ExhibitionDetailsEvent();
}

final class ExhibitionDetailsInitialEvent extends ExhibitionDetailsEvent {
  final BuildContext context;

  const ExhibitionDetailsInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ExhibitionChangeTabsEvent extends ExhibitionDetailsEvent {
  final int index;
  final BuildContext context;

  const ExhibitionChangeTabsEvent({required this.context, required this.index});

  @override
  List<Object> get props => [index, context];
}

final class ExhibitionChangeListingTypeEvent extends ExhibitionDetailsEvent {
  final bool isGrid;

  const ExhibitionChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class ExhibitionListingLoadMoreEvent extends ExhibitionDetailsEvent {
  final int currentPage;
  final BuildContext context;

  const ExhibitionListingLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [currentPage, context];
}
