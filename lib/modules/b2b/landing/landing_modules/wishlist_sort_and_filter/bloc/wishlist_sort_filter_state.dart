part of 'wishlist_sort_filter_bloc.dart';

sealed class WishlistSortFilterState extends Equatable {
  const WishlistSortFilterState();

  @override
  List<Object> get props => [];
}

class WishlistSortFilterInitial extends WishlistSortFilterState {}

class WishlistSortReloadState extends WishlistSortFilterState {}

class WishlistSortDataSelectedState extends WishlistSortFilterState {
  final SortOptions selectedSortData;

  const WishlistSortDataSelectedState(this.selectedSortData);
}

class WishlistFilterDataSelectedState extends WishlistSortFilterState {
  final FilterData selectedFilterData;

  const WishlistFilterDataSelectedState(this.selectedFilterData);
}

class WishlistSelectSecondaryFilterDataState extends WishlistSortFilterState {
  final SecondaryFilterData secondaryFilterData;

  const WishlistSelectSecondaryFilterDataState(this.secondaryFilterData);
}

class SearchWishlistFilterDataState extends WishlistSortFilterState {
  final List<SecondaryFilterData> filteredSecondaryData;

  const SearchWishlistFilterDataState(this.filteredSecondaryData);
}

class WishlistSortAndFilterPriceRangeChangedState extends WishlistSortFilterState {}
