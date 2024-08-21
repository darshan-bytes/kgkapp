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
  const StoneChangeListingTypeEvent();

  @override
  List<Object> get props => [];
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
