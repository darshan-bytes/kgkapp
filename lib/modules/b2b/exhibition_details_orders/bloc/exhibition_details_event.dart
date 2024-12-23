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
  const ExhibitionChangeTabsEvent();

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

final class ExhibitionProductDetailsEvent extends ExhibitionDetailsEvent {
  // final int currentPage;
  final BuildContext context;

  const ExhibitionProductDetailsEvent(this.context /*this.currentPage*/);

  @override
  List<Object> get props => [context /*currentPage*/];
}
