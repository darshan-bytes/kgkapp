part of 'auction_listing_bloc.dart';

sealed class AuctionListingState extends Equatable {
  const AuctionListingState();
}

final class AuctionListingInitialState extends AuctionListingState {
  @override
  List<Object> get props => [];
}

final class AuctionListingReloadState extends AuctionListingState {
  @override
  List<Object> get props => [];
}

final class ChangeAuctionListingPageNumberState extends AuctionListingState {
  @override
  List<Object> get props => [];
}

final class FilterAuctionsState extends AuctionListingState {
  @override
  List<Object> get props => [];
}
