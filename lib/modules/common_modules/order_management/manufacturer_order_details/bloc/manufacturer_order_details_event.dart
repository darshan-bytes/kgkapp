part of 'manufacturer_order_details_bloc.dart';

sealed class ManufacturerOrderDetailsEvent extends Equatable {
  const ManufacturerOrderDetailsEvent();
}

class ManufacturerOrderDetailsInitialEvent extends ManufacturerOrderDetailsEvent {
  final BuildContext context;

  const ManufacturerOrderDetailsInitialEvent({required this.context});

  @override
  List<Object> get props => [];
}

class ManufacturerOrderCancellationReasonsEvent extends ManufacturerOrderDetailsEvent {
  final CancellationReasonModel cancellationReasonModel;

  const ManufacturerOrderCancellationReasonsEvent(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}

class ManufacturerOrderDetailsShowMoreEvent extends ManufacturerOrderDetailsEvent {
  final int index;

  const ManufacturerOrderDetailsShowMoreEvent(this.index);

  @override
  List<Object> get props => [index];
}
