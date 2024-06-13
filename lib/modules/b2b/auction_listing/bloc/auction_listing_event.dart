part of 'auction_listing_bloc.dart';

sealed class AuctionListingEvent extends Equatable {
  const AuctionListingEvent();
}

final class InitialAuctionListingEvent extends AuctionListingEvent {
  @override
  List<Object> get props => [];
}

final class FilterAuctionsEvent extends AuctionListingEvent {
  const FilterAuctionsEvent();

  @override
  List<Object> get props => [];
}

class ChangeAuctionListingPageNumberEvent extends AuctionListingEvent {
  final String pageNumber;

  const ChangeAuctionListingPageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
