part of 'manufacturer_order_listing_bloc.dart';

sealed class ManufacturerOrderListingState extends Equatable {
  const ManufacturerOrderListingState();
}

final class ManufacturerOrderListingInitial extends ManufacturerOrderListingState {
  const ManufacturerOrderListingInitial();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListReloadState extends ManufacturerOrderListingState {
  const ManufacturerOrderListReloadState();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListingLoadedState extends ManufacturerOrderListingState {
  const ManufacturerOrderListingLoadedState();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadingMoreState extends ManufacturerOrderListingState {
  const ManufacturerOrderListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadedMoreState extends ManufacturerOrderListingState {
  final int currentPage;

  const ManufacturerOrderListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ManufacturerChangeOrdersTypeState extends ManufacturerOrderListingState {
  final ManufacturerOrderModel selectedOrderType;

  const ManufacturerChangeOrdersTypeState(this.selectedOrderType);

  @override
  List<Object> get props => [selectedOrderType];
}
