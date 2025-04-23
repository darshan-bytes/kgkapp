part of 'manufacturer_order_details_bloc.dart';

sealed class ManufacturerOrderDetailsState extends Equatable {
  const ManufacturerOrderDetailsState();
}

final class ManufacturerOrderDetailsInitial extends ManufacturerOrderDetailsState {
  @override
  List<Object> get props => [];
}

final class ManufacturerOrderReloadState extends ManufacturerOrderDetailsState {
  @override
  List<Object> get props => [];
}

final class ManufacturerOrderDataFetchedState extends ManufacturerOrderDetailsState {
  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadedState extends ManufacturerOrderDetailsState {
  final int currentPage;

  const ManufacturerOrderListLoadedState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ManufacturerCancellationReasonsChangeState extends ManufacturerOrderDetailsState {
  final CancellationReasonModel cancellationReasonModel;

  const ManufacturerCancellationReasonsChangeState(this.cancellationReasonModel);

  @override
  List<Object> get props => [cancellationReasonModel];
}

final class ManufacturerOrderDetailsShowMoreState extends ManufacturerOrderDetailsState {
  const ManufacturerOrderDetailsShowMoreState();

  @override
  List<Object> get props => [];
}
