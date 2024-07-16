part of 'auction_listing_bloc.dart';

sealed class AuctionListingEvent extends Equatable {
  const AuctionListingEvent();
}

final class InitialAuctionListingEvent extends AuctionListingEvent {
  const InitialAuctionListingEvent();

  @override
  List<Object> get props => [];
}

final class AuctionListLoadMoreEvent extends AuctionListingEvent {
  final int currentPage;

  const AuctionListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class AuctionListPullToRefreshEvent extends AuctionListingEvent {
  const AuctionListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
