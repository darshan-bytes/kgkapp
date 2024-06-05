part of 'auction_bloc.dart';

sealed class AuctionState extends Equatable {
  const AuctionState();
}

final class AuctionInitial extends AuctionState {
  @override
  List<Object> get props => [];
}

final class AuctionDiamondImagePageChangeState extends AuctionState {
  @override
  List<Object> get props => [];
}

final class AuctionProductCompareToggleState extends AuctionState {
  const AuctionProductCompareToggleState();

  @override
  List<Object> get props => [];
}

final class AuctionReloadState extends AuctionState {
  const AuctionReloadState();

  @override
  List<Object> get props => [];
}
