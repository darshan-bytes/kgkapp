part of 'sort_filter_bloc.dart';

sealed class SortFilterEvent extends Equatable {
  const SortFilterEvent();
}

final class SelectSortDataEvent extends SortFilterEvent {
  final SortData sortData;

  const SelectSortDataEvent({required this.sortData});

  @override
  List<Object> get props => [sortData];
}

final class SelectFilterDataEvent extends SortFilterEvent {
  final FilterData filterData;

  const SelectFilterDataEvent({required this.filterData});

  @override
  List<Object> get props => [filterData];
}

final class SelectSecondaryFilterDataEvent extends SortFilterEvent {
  final SecondaryFilterData secondaryFilterData;

  const SelectSecondaryFilterDataEvent({required this.secondaryFilterData});

  @override
  List<Object> get props => [secondaryFilterData];
}

final class SearchFilterDataEvent extends SortFilterEvent {
  final String searchQuery;

  const SearchFilterDataEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

final class ClearAllFilterDataEvent extends SortFilterEvent {
  const ClearAllFilterDataEvent();

  @override
  List<Object> get props => [];
}

final class ApplyFilterDataEvent extends SortFilterEvent {
  const ApplyFilterDataEvent();

  @override
  List<Object> get props => [];
}
