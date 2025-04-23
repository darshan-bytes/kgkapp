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

final class OrderCancellationEvent extends OrderDetailEvent {
  final BuildContext context;
  final PlaceOrderResponse placeOrderResponse;
  final String productSuid;
  final bool isFromFullOrder;

  const OrderCancellationEvent({
    required this.context,
    required this.placeOrderResponse,
    this.productSuid = "",
    this.isFromFullOrder = false,
  });

  @override
  List<Object> get props => [context, placeOrderResponse, productSuid, isFromFullOrder];
}

final class CancelOrderCommentChangeEvent extends OrderDetailEvent {
  final FieldTypeValidationEnum fieldType;

  const CancelOrderCommentChangeEvent({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}

final class OrderDetailsCancelInitialEvent extends OrderDetailEvent {
  const OrderDetailsCancelInitialEvent();

  @override
  List<Object> get props => [];
}
