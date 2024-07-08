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

final class OrderDetailChangeProductQuality extends OrderDetailEvent {
  final int index;
  final CartProductQuality productQuality;

  const OrderDetailChangeProductQuality({required this.index, required this.productQuality});

  @override
  List<Object> get props => [index, productQuality];
}

final class OrderDetailChangeProductQuantity extends OrderDetailEvent {
  final int index;
  final CartProductQuantity productQuantity;

  const OrderDetailChangeProductQuantity({required this.index, required this.productQuantity});

  @override
  List<Object> get props => [index, productQuantity];
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

final class OrderDetailsLoadMoreProductsEvent extends OrderDetailEvent {
  final int currentPage;

  const OrderDetailsLoadMoreProductsEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
