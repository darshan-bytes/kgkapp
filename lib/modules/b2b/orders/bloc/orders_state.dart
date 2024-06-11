part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersReloadState extends OrdersState {}

final class ChangeOrdersPageNumberState extends OrdersState {}

final class ChangeOrdersStoneTypeState extends OrdersState {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeOrdersStoneTypeState(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class FilterDiamondOrdersState extends OrdersState {}

final class FilterGemstoneOrdersState extends OrdersState {}

final class FilterJewelleryOrdersState extends OrdersState {}

final class ChangeOrderTabsState extends OrdersState {}
