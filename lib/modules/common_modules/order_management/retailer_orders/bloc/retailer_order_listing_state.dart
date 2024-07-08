part of 'retailer_order_listing_bloc.dart';

sealed class RetailerOrderListingState extends Equatable {
  const RetailerOrderListingState();
}

final class RetailerOrderListingInitialState extends RetailerOrderListingState {
  @override
  List<Object> get props => [];
}

final class RetailerOrderListReloadState extends RetailerOrderListingState {
  const RetailerOrderListReloadState();

  @override
  List<Object> get props => [];
}

final class RetailerOrderListingLoadedState extends RetailerOrderListingState {
  const RetailerOrderListingLoadedState();

  @override
  List<Object> get props => [];
}

final class RetailerOrderListLoadingMoreState extends RetailerOrderListingState {
  const RetailerOrderListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class RetailerOrderListLoadedMoreState extends RetailerOrderListingState {
  final int currentPage;

  const RetailerOrderListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class RetailerChangeOrdersTypeState extends RetailerOrderListingState {
  final RetailerOrderModel selectedOrderType;

  const RetailerChangeOrdersTypeState(this.selectedOrderType);

  @override
  List<Object> get props => [selectedOrderType];
}

final class RetailerChangeOrderTabsState extends RetailerOrderListingState {
  const RetailerChangeOrderTabsState();

  @override
  List<Object> get props => [];
}
