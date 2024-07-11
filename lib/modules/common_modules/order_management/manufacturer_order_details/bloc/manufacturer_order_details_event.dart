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

class ManufacturerOrderDetailsLoadMoreEvent extends ManufacturerOrderDetailsEvent {
  final int currentPage;

  const ManufacturerOrderDetailsLoadMoreEvent({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class ManufacturerOrderCancellationReasonsEvent extends ManufacturerOrderDetailsEvent {
  final CancellationReasonModel cancellationReasonModel;

  const ManufacturerOrderCancellationReasonsEvent(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}
