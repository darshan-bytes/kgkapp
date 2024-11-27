part of 'diamond_filter_bloc.dart';

sealed class DiamondFilterState extends Equatable {
  const DiamondFilterState();
}

final class DiamondFilterInitial extends DiamondFilterState {
  @override
  List<Object> get props => [];
}

final class DiamondFilterDataLoadedState extends DiamondFilterState {
  final List<FilterData> filterData;

  const DiamondFilterDataLoadedState(this.filterData);

  @override
  List<Object> get props => [filterData];
}

final class DiamondFilterReloadState extends DiamondFilterState {
  @override
  List<Object> get props => [];
}

final class DiamondFilterDataSelectedState extends DiamondFilterState {
  final FilterData filterData;

  const DiamondFilterDataSelectedState(this.filterData);

  @override
  List<Object> get props => [filterData];
}

final class SelectSecondaryDiamondFilterDataState extends DiamondFilterState {
  final SecondaryFilterData secondaryFilterData;

  const SelectSecondaryDiamondFilterDataState(this.secondaryFilterData);

  @override
  List<Object> get props => [secondaryFilterData];
}

final class SearchDiamondFilterDataState extends DiamondFilterState {
  final List<SecondaryFilterData> secondaryFilterDataDisplay;

  const SearchDiamondFilterDataState(this.secondaryFilterDataDisplay);

  @override
  List<Object> get props => [secondaryFilterDataDisplay];
}

final class SecondaryFilterDataFetchedState extends DiamondFilterState {
  final List<SecondaryFilterModel> secondaryFilterData;

  const SecondaryFilterDataFetchedState(this.secondaryFilterData);

  @override
  List<Object> get props => [secondaryFilterData];
}

final class FilterPriceRangeChangedState extends DiamondFilterState {
  const FilterPriceRangeChangedState();

  @override
  List<Object> get props => [];
}
