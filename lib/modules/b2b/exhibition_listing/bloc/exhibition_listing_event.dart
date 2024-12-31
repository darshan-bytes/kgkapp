part of 'exhibition_listing_bloc.dart';

sealed class ExhibitionListingEvent extends Equatable {
  const ExhibitionListingEvent();
}

final class InitialExhibitionListingEvent extends ExhibitionListingEvent {
  final BuildContext context;

  const InitialExhibitionListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ExhibitionListLoadMoreEvent extends ExhibitionListingEvent {
  final int currentPage;
  final BuildContext context;

  const ExhibitionListLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage, context];
}

final class ExhibitionListFilterEvent extends ExhibitionListingEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const ExhibitionListFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class LoadMoreExhibitionListingEvent extends ExhibitionListingEvent {
  final BuildContext context;
  final int currentPage;

  const LoadMoreExhibitionListingEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class ExhibitionListingPullToRefreshEvent extends ExhibitionListingEvent {
  final BuildContext context;

  const ExhibitionListingPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ExhibitionListingFilterEvent extends ExhibitionListingEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const ExhibitionListingFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class ExhibitionListingSearchEvent extends ExhibitionListingEvent {
  final BuildContext context;

  const ExhibitionListingSearchEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ChangeExhibitionTabsEvent extends ExhibitionListingEvent {
  final int index;
  final BuildContext context;

  const ChangeExhibitionTabsEvent({required this.context, required this.index});

  @override
  List<Object> get props => [context, index];
}
