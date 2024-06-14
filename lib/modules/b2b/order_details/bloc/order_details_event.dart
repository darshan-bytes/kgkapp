part of 'order_details_bloc.dart';

sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();
}

final class InitialOrderDetailEvent extends OrderDetailEvent {
  @override
  List<Object> get props => [];
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

class ChangeOrderDetailPageNumberEvent extends OrderDetailEvent {
  final String pageNumber;

  const ChangeOrderDetailPageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

final class FilterOrdersEvent extends OrderDetailEvent {
  const FilterOrdersEvent();

  @override
  List<Object> get props => [];
}

class OrderCancellationReasonsEvent extends OrderDetailEvent {
  final CancellationReasonModel cancellationReasonModel;

  const OrderCancellationReasonsEvent(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}
