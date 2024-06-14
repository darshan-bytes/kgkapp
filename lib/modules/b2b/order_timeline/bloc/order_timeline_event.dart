part of 'order_timeline_bloc.dart';

sealed class OrderTimelineEvent extends Equatable {
  const OrderTimelineEvent();
}

final class InitialOrderTimelineEvent extends OrderTimelineEvent {
  final BuildContext context;

  const InitialOrderTimelineEvent(this.context);

  @override
  List<Object> get props => [context];
}
