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
  final BuildContext context;
  final List<FilterData> filterData;

  const FilterPresentationEvent(this.context, this.filterData);

  @override
  List<Object> get props => [context, filterData];
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
  final BuildContext context;

  const PddListLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage];
}

final class PddListPullToRefreshEvent extends PddListingEvent {
  final BuildContext context;
  const PddListPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class PddListSearchEvent extends PddListingEvent {
  final BuildContext context;
  const PddListSearchEvent(this.context);

  @override
  List<Object> get props => [context];
}
