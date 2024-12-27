part of 'order_details_bloc.dart';

sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

final class InitialOrderDetailEvent extends OrderDetailEvent {
  final BuildContext context;

  const InitialOrderDetailEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OrderDetailRemoveProductEvent extends OrderDetailEvent {
  final int index;

  const OrderDetailRemoveProductEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class OrderCancellationReasonsEvent extends OrderDetailEvent {
  final CancellationReasonModel cancellationReasonModel;

  const OrderCancellationReasonsEvent(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}
