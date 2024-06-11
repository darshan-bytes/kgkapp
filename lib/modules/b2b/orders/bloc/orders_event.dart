part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

final class OrdersInitialEvent extends OrdersEvent {
  final BuildContext context;

  const OrdersInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

class ChangeOrdersPageNumberEvent extends OrdersEvent {
  final String pageNumber;

  const ChangeOrdersPageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

final class ChangeOrdersStoneTypeEvent extends OrdersEvent {
  final OrderStoneTypeModel selectedStoneType;

  const ChangeOrdersStoneTypeEvent(this.selectedStoneType);

  @override
  List<Object> get props => [selectedStoneType];
}

final class FilterDiamondOrdersEvent extends OrdersEvent {
  const FilterDiamondOrdersEvent();

  @override
  List<Object> get props => [];
}

final class FilterGemstoneOrdersEvent extends OrdersEvent {
  const FilterGemstoneOrdersEvent();

  @override
  List<Object> get props => [];
}

final class FilterJewelleryOrdersEvent extends OrdersEvent {
  const FilterJewelleryOrdersEvent();

  @override
  List<Object> get props => [];
}

final class ChangeOrderTabsEvent extends OrdersEvent {
  const ChangeOrderTabsEvent();

  @override
  List<Object> get props => [];
}
