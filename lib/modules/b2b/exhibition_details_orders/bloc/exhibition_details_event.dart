part of 'exhibition_details_bloc.dart';

sealed class ExhibitionDetailsEvent extends Equatable {
  const ExhibitionDetailsEvent();
}

final class ExhibitionDetailsInitialEvent extends ExhibitionDetailsEvent {
  const ExhibitionDetailsInitialEvent();

  @override
  List<Object> get props => [];
}

final class ChangeExhibitionTabsEvent extends ExhibitionDetailsEvent {
  const ChangeExhibitionTabsEvent();

  @override
  List<Object> get props => [];
}

final class ExhibitionChangeListingTypeEvent extends ExhibitionDetailsEvent {
  final bool isGrid;

  const ExhibitionChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class ExhibitionListingLoadMoreEvent extends ExhibitionDetailsEvent {
  final int currentPage;

  const ExhibitionListingLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
