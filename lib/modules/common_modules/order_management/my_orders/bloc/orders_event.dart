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

class MyOrderListingLoadMoreEvent extends OrdersEvent {
  final int currentPage;
  final BuildContext context;

  const MyOrderListingLoadMoreEvent({required this.currentPage, required this.context});

  @override
  List<Object> get props => [currentPage, context];
}

class OrdersListPullToRefreshEvent extends OrdersEvent {
  final BuildContext context;

  const OrdersListPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class OrdersListFilterEvent extends OrdersEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const OrdersListFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class OrdersListSearchEvent extends OrdersEvent {
  final BuildContext context;

  const OrdersListSearchEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class NavigateToOrderDetailsEvent extends OrdersEvent {
  final String uniqueId;
  final BuildContext context;

  const NavigateToOrderDetailsEvent({required this.context, required this.uniqueId});

  @override
  List<Object> get props => [uniqueId, context];
}
