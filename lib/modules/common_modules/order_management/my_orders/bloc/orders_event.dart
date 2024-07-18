part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

final class OrdersInitialEvent extends OrdersEvent {
  final BuildContext context;

  const OrdersInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ChangeOrdersStoneTypeEvent extends OrdersEvent {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeOrdersStoneTypeEvent(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class ChangeOrderTabsEvent extends OrdersEvent {
  const ChangeOrderTabsEvent();

  @override
  List<Object> get props => [];
}

class MyOrderListingLoadMoreEvent extends OrdersEvent {
  final int currentPage;
  final MyOrdersTab listType;

  const MyOrderListingLoadMoreEvent({required this.currentPage, required this.listType});

  @override
  List<Object> get props => [currentPage, listType];
}

class OrdersListPullToRefreshEvent extends OrdersEvent {
  final MyOrdersTab listType;

  const OrdersListPullToRefreshEvent({required this.listType});

  @override
  List<Object> get props => [listType];
}
