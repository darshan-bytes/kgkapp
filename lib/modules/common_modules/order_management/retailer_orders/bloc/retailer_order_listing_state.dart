part of 'retailer_order_listing_bloc.dart';

sealed class RetailerOrderListingState extends Equatable {
  const RetailerOrderListingState();
}

final class RetailerOrderListingInitialState extends RetailerOrderListingState {
  const RetailerOrderListingInitialState();

  @override
  List<Object> get props => [];
}

final class RetailerOrderListingReloadState extends RetailerOrderListingState {
  const RetailerOrderListingReloadState();

  @override
  List<Object> get props => [];
}

final class ChangeRetailerOrderStoneTypeState extends RetailerOrderListingState {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeRetailerOrderStoneTypeState(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class ChangeRetailerOrderTabsState extends RetailerOrderListingState {
  const ChangeRetailerOrderTabsState();

  @override
  List<Object> get props => [];
}

class RetailerOrderListingLoadingMoreState extends RetailerOrderListingState {
  final RetailerOrdersTab listType;

  const RetailerOrderListingLoadingMoreState(this.listType);

  @override
  List<Object> get props => [listType];
}

class RetailerOrderListingListLoadedState extends RetailerOrderListingState {
  const RetailerOrderListingListLoadedState();

  @override
  List<Object> get props => [];
}

class RetailerOrderListingListLoadedMoreState extends RetailerOrderListingState {
  final int currentPage;
  final RetailerOrdersTab listType;

  const RetailerOrderListingListLoadedMoreState(this.currentPage, this.listType);

  @override
  List<Object> get props => [currentPage, listType];
}
