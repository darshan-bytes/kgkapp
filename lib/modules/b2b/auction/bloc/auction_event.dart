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

final class AuctionProductCompareToggleEvent extends AuctionEvent {
  const AuctionProductCompareToggleEvent();

  @override
  List<Object> get props => [];
}

final class AuctionInitialEvent extends AuctionEvent {
  final BuildContext context;

  const AuctionInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class AuctionStartTimerEvent extends AuctionEvent {
  const AuctionStartTimerEvent();

  @override
  List<Object> get props => [];
}

final class AuctionTimerCompletedEvent extends AuctionEvent {
  final Duration duration;

  const AuctionTimerCompletedEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

final class AuctionUpdateTimerEvent extends AuctionEvent {
  final Duration duration;

  const AuctionUpdateTimerEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

final class AuctionPlaceBidEvent extends AuctionEvent {
  const AuctionPlaceBidEvent();

  @override
  List<Object> get props => [];
}
