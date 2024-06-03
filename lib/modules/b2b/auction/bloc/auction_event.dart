part of 'auction_bloc.dart';

sealed class AuctionEvent extends Equatable {
  const AuctionEvent();
}

class AuctionDiamondImagePageChangeEvent extends AuctionEvent {
  final int index;

  const AuctionDiamondImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
