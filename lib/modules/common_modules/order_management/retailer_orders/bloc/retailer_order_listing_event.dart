part of 'retailer_order_listing_bloc.dart';

sealed class RetailerOrderListingEvent extends Equatable {
  const RetailerOrderListingEvent();
}

final class InitialRetailerOrderListingEvent extends RetailerOrderListingEvent {
  final BuildContext context;

  const InitialRetailerOrderListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class RetailerOrderListLoadMoreEvent extends RetailerOrderListingEvent {
  final int currentPage;

  const RetailerOrderListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class RetailerChangeOrdersTypeEvent extends RetailerOrderListingEvent {
  final RetailerOrderModel selectedOrderType;

  const RetailerChangeOrdersTypeEvent(this.selectedOrderType);

  @override
  List<Object> get props => [selectedOrderType];
}

final class RetailerChangeOrderTabsEvent extends RetailerOrderListingEvent {
  const RetailerChangeOrderTabsEvent();

  @override
  List<Object> get props => [];
}
