part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();
}

final class OrdersInitial extends OrdersState {
  const OrdersInitial();

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

final class FilterDiamondOrdersState extends OrdersState {
  const FilterDiamondOrdersState();

  @override
  List<Object> get props => [];
}

final class FilterGemstoneOrdersState extends OrdersState {
  const FilterGemstoneOrdersState();

  @override
  List<Object> get props => [];
}

final class FilterJewelleryOrdersState extends OrdersState {
  const FilterJewelleryOrdersState();

  @override
  List<Object> get props => [];
}

final class ChangeOrderTabsState extends OrdersState {
  const ChangeOrderTabsState();

  @override
  List<Object> get props => [];
}
