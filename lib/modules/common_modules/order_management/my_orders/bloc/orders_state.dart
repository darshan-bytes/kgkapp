part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();
}

final class OrdersInitialState extends OrdersState {
  const OrdersInitialState();

  @override
  List<Object> get props => [];
}

final class OrdersReloadState extends OrdersState {
  const OrdersReloadState();

  @override
  List<Object> get props => [];
}

final class ChangeOrdersStoneTypeState extends OrdersState {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeOrdersStoneTypeState(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class ChangeOrderTabsState extends OrdersState {
  const ChangeOrderTabsState();

  @override
  List<Object> get props => [];
}

class OrdersLoadingMoreState extends OrdersState {
  final MyOrdersTab listType;

  const OrdersLoadingMoreState(this.listType);

  @override
  List<Object> get props => [listType];
}

class OrdersListLoadedState extends OrdersState {
  const OrdersListLoadedState();

  @override
  List<Object> get props => [];
}

class OrdersListLoadedMoreState extends OrdersState {
  final int currentPage;
  final MyOrdersTab listType;

  const OrdersListLoadedMoreState(this.currentPage, this.listType);

  @override
  List<Object> get props => [currentPage, listType];
}
