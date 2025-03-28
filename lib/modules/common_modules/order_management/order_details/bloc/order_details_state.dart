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

final class OrderDetailsLoadingState extends OrderDetailState {
  const OrderDetailsLoadingState();

  @override
  List<Object> get props => [];
}

final class CancellationFieldErrorState extends OrderDetailState {
  final FieldTypeValidationEnum fieldType;

  const CancellationFieldErrorState({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}
