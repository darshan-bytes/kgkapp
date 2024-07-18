part of 'pdd_listing_bloc.dart';

sealed class PddListingEvent extends Equatable {
  const PddListingEvent();
}

final class InitialPddListingEvent extends PddListingEvent {
  final BuildContext context;

  const InitialPddListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class PresentationChangeListingTypeEvent extends PddListingEvent {
  final bool isGrid;

  const PresentationChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class FilterPresentationEvent extends PddListingEvent {
  const FilterPresentationEvent();

  @override
  List<Object> get props => [];
}

final class NavigateToPddPreviewEvent extends PddListingEvent {
  final int index;
  final BuildContext context;

  const NavigateToPddPreviewEvent({required this.index, required this.context});

  @override
  List<Object> get props => [index, context];
}

final class PddListLoadMoreEvent extends PddListingEvent {
  final int currentPage;

  const PddListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class PddListPullToRefreshEvent extends PddListingEvent {
  const PddListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
