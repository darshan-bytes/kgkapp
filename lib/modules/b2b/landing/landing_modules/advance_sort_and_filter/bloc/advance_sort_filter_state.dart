part of 'advance_sort_filter_bloc.dart';

sealed class AdvanceSortFilterState extends Equatable {
  const AdvanceSortFilterState();

  @override
  List<Object> get props => [];
}

class AdvanceSortFilterInitial extends AdvanceSortFilterState {}

class AdvanceSortReloadState extends AdvanceSortFilterState {}

class AdvanceSortDataSelectedState extends AdvanceSortFilterState {
  final SortOptions selectedSortData;

  const AdvanceSortDataSelectedState(this.selectedSortData);
}

class AdvanceFilterDataSelectedState extends AdvanceSortFilterState {
  final FilterData selectedFilterData;

  const AdvanceFilterDataSelectedState(this.selectedFilterData);
}

class AdvanceSelectSecondaryFilterDataState extends AdvanceSortFilterState {
  final SecondaryFilterData secondaryFilterData;

  const AdvanceSelectSecondaryFilterDataState(this.secondaryFilterData);
}

class SearchAdvanceFilterDataState extends AdvanceSortFilterState {
  final List<SecondaryFilterData> filteredSecondaryData;

  const SearchAdvanceFilterDataState(this.filteredSecondaryData);
}

class AdvanceSortAndFilterPriceRangeChangedState extends AdvanceSortFilterState {}
