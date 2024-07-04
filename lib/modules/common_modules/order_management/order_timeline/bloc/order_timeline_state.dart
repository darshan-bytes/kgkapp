part of 'order_timeline_bloc.dart';

sealed class OrderTimelineState extends Equatable {
  const OrderTimelineState();
}

final class OrderTimelineInitialState extends OrderTimelineState {
  @override
  List<Object> get props => [];
}

final class OrderTimelineLoadedState extends OrderTimelineState {
  final List<OrderTimelineDataModel> timelineList;

  const OrderTimelineLoadedState(this.timelineList);

  @override
  List<Object> get props => [timelineList];
}
