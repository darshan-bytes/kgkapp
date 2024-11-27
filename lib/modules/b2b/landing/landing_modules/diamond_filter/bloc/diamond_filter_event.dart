part of 'diamond_filter_bloc.dart';

sealed class DiamondFilterEvent extends Equatable {
  const DiamondFilterEvent();
}

final class LoadDiamondFilterDataEvent extends DiamondFilterEvent {
  const LoadDiamondFilterDataEvent();

  @override
  List<Object> get props => [];
}

final class SelectDiamondFilterDataEvent extends DiamondFilterEvent {
  final BuildContext context;
  final FilterData filterData;

  const SelectDiamondFilterDataEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}

final class SelectSecondaryDiamondFilterDataEvent extends DiamondFilterEvent {
  final SecondaryFilterData secondaryFilterData;

  const SelectSecondaryDiamondFilterDataEvent({required this.secondaryFilterData});

  @override
  List<Object> get props => [secondaryFilterData];
}

final class SearchDiamondFilterDataEvent extends DiamondFilterEvent {
  final String searchQuery;

  const SearchDiamondFilterDataEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

final class ClearAllDiamondFilterDataEvent extends DiamondFilterEvent {
  const ClearAllDiamondFilterDataEvent();

  @override
  List<Object> get props => [];
}

final class ApplyDiamondFilterDataEvent extends DiamondFilterEvent {
  const ApplyDiamondFilterDataEvent();

  @override
  List<Object> get props => [];
}

final class AddFilterDataEvent extends DiamondFilterEvent {
  final BuildContext context;
  final List<FilterOptionModel> gemstoneFilterList;

  const AddFilterDataEvent({required this.context, required this.gemstoneFilterList});

  @override
  List<Object> get props => [context, gemstoneFilterList];
}

final class FilterPriceRangeChangedEvent extends DiamondFilterEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;
  const FilterPriceRangeChangedEvent(this.values, {this.isFromTextField = false, this.isMin = true});

  @override
  List<Object> get props => [values, isFromTextField, isMin];
}

final class FilterPriceRangeEditEvent extends DiamondFilterEvent {
  final bool isMin;

  const FilterPriceRangeEditEvent({this.isMin = true});

  @override
  List<Object> get props => [isMin];
}
