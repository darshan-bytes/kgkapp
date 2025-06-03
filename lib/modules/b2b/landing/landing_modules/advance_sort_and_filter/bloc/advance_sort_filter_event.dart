part of 'advance_sort_filter_bloc.dart';

sealed class AdvanceSortFilterEvent extends Equatable {
  const AdvanceSortFilterEvent();

  @override
  List<Object> get props => [];
}

class AddAdvanceSortFilterDataEvent extends AdvanceSortFilterEvent {
  final List<FilterData> filterOptionList;
  final BuildContext context;

  const AddAdvanceSortFilterDataEvent({required this.filterOptionList, required this.context});
}

class SelectAdvanceSortDataEvent extends AdvanceSortFilterEvent {
  final SortOptions sortData;

  const SelectAdvanceSortDataEvent({required this.sortData});
}

class SelectAdvanceFilterDataEvent extends AdvanceSortFilterEvent {
  final BuildContext context;
  final FilterData filterData;

  const SelectAdvanceFilterDataEvent({required this.context, required this.filterData});
}

class SelectAdvanceSecondaryFilterDataEvent extends AdvanceSortFilterEvent {
  final SecondaryFilterData secondaryFilterData;

  const SelectAdvanceSecondaryFilterDataEvent({required this.secondaryFilterData});
}

class SearchAdvanceFilterDataEvent extends AdvanceSortFilterEvent {
  final String searchQuery;

  const SearchAdvanceFilterDataEvent({required this.searchQuery});
}

class ClearAllAdvanceFilterDataEvent extends AdvanceSortFilterEvent {
  final Function(List<FilterData>) onApply;
  final BuildContext context;

  const ClearAllAdvanceFilterDataEvent({required this.onApply, required this.context});
}

class ApplyAdvanceFilterDataEvent extends AdvanceSortFilterEvent {}

class AdvanceSortAndFilterPriceRangeChangedEvent extends AdvanceSortFilterEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;

  const AdvanceSortAndFilterPriceRangeChangedEvent(this.values, {this.isFromTextField = false, this.isMin = false});
}

class AdvanceSortAndFilterPriceRangeEditEvent extends AdvanceSortFilterEvent {
  final bool isMin;

  const AdvanceSortAndFilterPriceRangeEditEvent({required this.isMin});
}

class ChangeAdvanceDateRangeEvent extends AdvanceSortFilterEvent {
  final DateTimeRange dateRange;

  const ChangeAdvanceDateRangeEvent({required this.dateRange});
}

class ChangeAdvanceDateEvent extends AdvanceSortFilterEvent {
  final DateTime date;

  const ChangeAdvanceDateEvent({required this.date});
}
