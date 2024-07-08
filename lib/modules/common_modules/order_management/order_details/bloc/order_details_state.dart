part of 'order_details_bloc.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();
}

final class OrderDetailInitial extends OrderDetailState {
  const OrderDetailInitial();

  @override
  List<Object> get props => [];
}

final class OrderDetailReloadState extends OrderDetailState {
  const OrderDetailReloadState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsLoadedState extends OrderDetailState {
  const OrderDetailsLoadedState();

  @override
  List<Object> get props => [];
}

final class OrderDetailProductQualityChangedState extends OrderDetailState {
  final int index;
  final CartProductQuality productQuality;

  const OrderDetailProductQualityChangedState({required this.index, required this.productQuality});

  @override
  List<Object> get props => [index, productQuality];
}

final class OrderDetailProductQuantityChangedState extends OrderDetailState {
  final int index;
  final CartProductQuantity productQuantity;

  const OrderDetailProductQuantityChangedState({required this.index, required this.productQuantity});

  @override
  List<Object> get props => [index, productQuantity];
}

final class OrderDetailProductRemovedState extends OrderDetailState {
  final int index;

  const OrderDetailProductRemovedState({required this.index});

  @override
  List<Object> get props => [index];
}

final class OrderCancellationReasonsChangeState extends OrderDetailState {
  final CancellationReasonModel cancellationReasonModel;

  const OrderCancellationReasonsChangeState(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}

final class OrderDetailsLoadingMoreProductsState extends OrderDetailState {
  const OrderDetailsLoadingMoreProductsState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsLoadedMoreProductsState extends OrderDetailState {
  final int currentPage;

  const OrderDetailsLoadedMoreProductsState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
