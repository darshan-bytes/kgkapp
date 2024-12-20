part of 'auction_listing_bloc.dart';

sealed class AuctionListingState extends Equatable {
  const AuctionListingState();
}

final class AuctionListingInitialState extends AuctionListingState {
  @override
  List<Object> get props => [];
}

final class AuctionListingReloadState extends AuctionListingState {
  const AuctionListingReloadState();

  @override
  List<Object> get props => [];
}

final class AuctionListingLoadedState extends AuctionListingState {
  const AuctionListingLoadedState();

  @override
  List<Object> get props => [];
}

final class AuctionListLoadingMoreState extends AuctionListingState {
  const AuctionListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class AuctionListLoadedMoreState extends AuctionListingState {
  final int currentPage;

  const AuctionListLoadedMoreState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class AuctionListingReloadingState extends AuctionListingState {
  const AuctionListingReloadingState();

  @override
  List<Object> get props => [];
}

final class AuctionListingLoadingState extends AuctionListingState {
  const AuctionListingLoadingState();

  @override
  List<Object> get props => [];
}
