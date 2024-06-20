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

  const StoneChangeTypeEvent(this.isInitialToggle);

  @override
  List<Object> get props => [isInitialToggle];
}

class StoneChangeListingTypeEvent extends StoneListingEvent {
  const StoneChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

class StoneProductChangePageNumberEvent extends StoneListingEvent {
  final String pageNumber;

  const StoneProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
