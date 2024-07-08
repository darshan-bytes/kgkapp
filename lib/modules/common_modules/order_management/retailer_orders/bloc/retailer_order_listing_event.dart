part of 'retailer_order_listing_bloc.dart';

sealed class RetailerOrderListingEvent extends Equatable {
  const RetailerOrderListingEvent();
}

final class RetailerOrderListingInitialEvent extends RetailerOrderListingEvent {
  final BuildContext context;

  const RetailerOrderListingInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ChangeRetailerOrderStoneTypeEvent extends RetailerOrderListingEvent {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeRetailerOrderStoneTypeEvent(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class ChangeRetailerOrderTabsEvent extends RetailerOrderListingEvent {
  const ChangeRetailerOrderTabsEvent();

  @override
  List<Object> get props => [];
}

final class RetailerOrderListingLoadMoreEvent extends RetailerOrderListingEvent {
  final int currentPage;
  final RetailerOrdersTab listType;

  const RetailerOrderListingLoadMoreEvent({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}
