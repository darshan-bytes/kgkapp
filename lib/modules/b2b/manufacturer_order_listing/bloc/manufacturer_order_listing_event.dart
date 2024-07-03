part of 'manufacturer_order_listing_bloc.dart';

sealed class ManufacturerOrderListingEvent extends Equatable {
  const ManufacturerOrderListingEvent();
}

final class InitialManufacturerOrderListingEvent extends ManufacturerOrderListingEvent {
  final BuildContext context;

  const InitialManufacturerOrderListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ManufacturerOrderListLoadMoreEvent extends ManufacturerOrderListingEvent {
  final int currentPage;

  const ManufacturerOrderListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
