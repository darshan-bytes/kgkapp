part of 'wishlist_sort_filter_bloc.dart';

sealed class WishlistSortFilterEvent extends Equatable {
  const WishlistSortFilterEvent();

  @override
  List<Object> get props => [];
}

class AddWishlistSortFilterDataEvent extends WishlistSortFilterEvent {
  final List<FilterData> filterOptionList;
  final BuildContext context;

  const AddWishlistSortFilterDataEvent({required this.filterOptionList, required this.context});
}

class SelectWishlistSortDataEvent extends WishlistSortFilterEvent {
  final SortOptions sortData;

  const SelectWishlistSortDataEvent({required this.sortData});
}

class SelectWishlistFilterDataEvent extends WishlistSortFilterEvent {
  final BuildContext context;
  final FilterData filterData;

  const SelectWishlistFilterDataEvent({required this.context, required this.filterData});
}

class SelectWishlistSecondaryFilterDataEvent extends WishlistSortFilterEvent {
  final SecondaryFilterData secondaryFilterData;

  const SelectWishlistSecondaryFilterDataEvent({required this.secondaryFilterData});
}

class SearchWishlistFilterDataEvent extends WishlistSortFilterEvent {
  final String searchQuery;

  const SearchWishlistFilterDataEvent({required this.searchQuery});
}

class ClearAllWishlistFilterDataEvent extends WishlistSortFilterEvent {
  final Function(List<FilterData>) onApply;
  final BuildContext context;

  const ClearAllWishlistFilterDataEvent({required this.onApply, required this.context});
}

class ApplyWishlistFilterDataEvent extends WishlistSortFilterEvent {}

class WishlistSortAndFilterPriceRangeChangedEvent extends WishlistSortFilterEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;

  const WishlistSortAndFilterPriceRangeChangedEvent(this.values, {this.isFromTextField = false, this.isMin = false});
}

class WishlistSortAndFilterPriceRangeEditEvent extends WishlistSortFilterEvent {
  final bool isMin;

  const WishlistSortAndFilterPriceRangeEditEvent({required this.isMin});
}
