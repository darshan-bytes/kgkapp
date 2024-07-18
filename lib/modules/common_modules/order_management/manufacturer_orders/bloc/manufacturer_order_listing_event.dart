part of 'manufacturer_order_listing_bloc.dart';

sealed class ManufacturerOrderListingEvent extends Equatable {
  const ManufacturerOrderListingEvent();
}

final class InitialManufacturerOrderListingEvent extends ManufacturerOrderListingEvent {
  const InitialManufacturerOrderListingEvent();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadMoreEvent extends ManufacturerOrderListingEvent {
  final int currentPage;

  const ManufacturerOrderListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ManufacturerChangeOrdersTypeEvent extends ManufacturerOrderListingEvent {
  final ManufacturerOrderModel selectedOrderType;

  const ManufacturerChangeOrdersTypeEvent(this.selectedOrderType);

  @override
  List<Object> get props => [selectedOrderType];
}

final class ManufacturerOrderListPullToRefreshEvent extends ManufacturerOrderListingEvent {
  const ManufacturerOrderListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
