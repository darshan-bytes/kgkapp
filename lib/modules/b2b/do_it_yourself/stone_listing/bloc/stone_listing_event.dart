part of 'stone_listing_bloc.dart';

sealed class StoneListingEvent extends Equatable {
  const StoneListingEvent();

  @override
  List<Object> get props => [];
}

class GetStoneProductListEvent extends StoneListingEvent {
  final BuildContext context;

  const GetStoneProductListEvent(this.context);

  @override
  List<Object> get props => [context];
}

class StoneChangeTypeEvent extends StoneListingEvent {
  final bool isInitialToggle;
  final BuildContext context;

  const StoneChangeTypeEvent(this.isInitialToggle, this.context);

  @override
  List<Object> get props => [isInitialToggle, context];
}

class StoneChangeListingTypeEvent extends StoneListingEvent {
  final bool isGrid;

  const StoneChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

class StoneListLoadMoreEvent extends StoneListingEvent {
  final BuildContext context;
  final int currentPage;

  const StoneListLoadMoreEvent(this.context, this.currentPage);

  @override
  List<Object> get props => [context, currentPage];
}

class StoneListPullToRefreshEvent extends StoneListingEvent {
  final BuildContext context;

  const StoneListPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class StoneListAddToWatchListEvent extends StoneListingEvent {
  final String stoneId;
  final BuildContext context;

  const StoneListAddToWatchListEvent(this.stoneId, this.context);

  @override
  List<Object> get props => [stoneId, context];
}

final class StoneSortEvent extends StoneListingEvent {
  final BuildContext context;
  final SortOptions sortData;

  const StoneSortEvent({required this.context, required this.sortData});

  @override
  List<Object> get props => [context, sortData];
}

final class StoneListingFilterEvent extends StoneListingEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const StoneListingFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
