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

  const AuctionListLoadMoreEvent(this.context, this.currentPage);

  @override
  List<Object> get props => [context, currentPage];
}

final class AuctionListPullToRefreshEvent extends AuctionListingEvent {
  const AuctionListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
