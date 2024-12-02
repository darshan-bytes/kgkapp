part of 'sort_filter_bloc.dart';

sealed class SortFilterState extends Equatable {
  const SortFilterState();
}

final class SortFilterInitial extends SortFilterState {
  @override
  List<Object> get props => [];
}

final class SortReloadState extends SortFilterState {
  @override
  List<Object> get props => [];
}

final class SortDataSelectedState extends SortFilterState {
  final SortOptions sortData;

  const SortDataSelectedState(this.sortData);

  @override
  List<Object> get props => [sortData];
}

final class FilterDataSelectedState extends SortFilterState {
  final FilterData filterData;

  const FilterDataSelectedState(this.filterData);

  @override
  List<Object> get props => [filterData];
}

final class SelectSecondaryFilterDataState extends SortFilterState {
  final SecondaryFilterData secondaryFilterData;

  const SelectSecondaryFilterDataState(this.secondaryFilterData);

  @override
  List<Object> get props => [secondaryFilterData];
}

final class SearchFilterDataState extends SortFilterState {
  final List<SecondaryFilterData> secondaryFilterDataDisplay;

  const SearchFilterDataState(this.secondaryFilterDataDisplay);

  @override
  List<Object> get props => [secondaryFilterDataDisplay];
}

final class SelectSecondaryDiamondSortFilterDataState extends SortFilterState {
  final List<SecondaryFilterModel> secondaryFilterData;

  const SelectSecondaryDiamondSortFilterDataState(this.secondaryFilterData);

  @override
  List<Object> get props => [secondaryFilterData];
}

final class SortAndFilterPriceRangeChangedState extends SortFilterState {
  const SortAndFilterPriceRangeChangedState();

  @override
  List<Object> get props => [];
}
