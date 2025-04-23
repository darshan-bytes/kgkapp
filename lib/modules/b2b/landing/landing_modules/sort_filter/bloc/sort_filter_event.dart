part of 'sort_filter_bloc.dart';

sealed class SortFilterEvent extends Equatable {
  const SortFilterEvent();
}

final class SelectSortDataEvent extends SortFilterEvent {
  final SortOptions sortData;

  const SelectSortDataEvent({required this.sortData});

  @override
  List<Object> get props => [sortData];
}

final class SelectFilterDataEvent extends SortFilterEvent {
  final FilterData filterData;
  final BuildContext context;

  const SelectFilterDataEvent({required this.filterData, required this.context});

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
  final Function onApply;
  final BuildContext context;

  const ClearAllFilterDataEvent({required this.context, required this.onApply});

  @override
  List<Object> get props => [context, onApply];
}

final class ApplyFilterDataEvent extends SortFilterEvent {
  const ApplyFilterDataEvent();

  @override
  List<Object> get props => [];
}

final class AddSortFilterDataEvent extends SortFilterEvent {
  final BuildContext context;
  final List<FilterData> filterOptionList;

  const AddSortFilterDataEvent({required this.context, required this.filterOptionList});

  @override
  List<Object> get props => [filterOptionList];
}

final class SortFilterScreenTypeEvent extends SortFilterEvent {
  final ScreenIdentifier screenIdentifier;

  const SortFilterScreenTypeEvent({required this.screenIdentifier});

  @override
  List<Object> get props => [screenIdentifier];
}

final class SortAndFilterPriceRangeChangedEvent extends SortFilterEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;

  const SortAndFilterPriceRangeChangedEvent(this.values, {this.isFromTextField = false, this.isMin = true});

  @override
  List<Object> get props => [values, isFromTextField, isMin];
}

final class SortAndFilterPriceRangeEditEvent extends SortFilterEvent {
  final bool isMin;

  const SortAndFilterPriceRangeEditEvent({this.isMin = true});

  @override
  List<Object> get props => [isMin];
}

final class InitialSortFilterEvent extends SortFilterEvent {
  final List<SortOptions> sortOptions;

  const InitialSortFilterEvent({required this.sortOptions});

  @override
  List<Object> get props => [sortOptions];
}
