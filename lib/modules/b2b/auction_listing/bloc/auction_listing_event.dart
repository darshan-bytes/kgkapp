part of 'auction_listing_bloc.dart';

sealed class AuctionListingEvent extends Equatable {
  const AuctionListingEvent();
}

final class InitialAuctionListingEvent extends AuctionListingEvent {
  final BuildContext context;

  const InitialAuctionListingEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class AuctionListLoadMoreEvent extends AuctionListingEvent {
  final BuildContext context;
  final int currentPage;

  const AuctionListLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class AuctionListPullToRefreshEvent extends AuctionListingEvent {
  final BuildContext context;

  const AuctionListPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class AuctionListFilterEvent extends AuctionListingEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const AuctionListFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class AuctionListSearchEvent extends AuctionListingEvent {
  final BuildContext context;

  const AuctionListSearchEvent({required this.context});

  @override
  List<Object> get props => [context];
}
