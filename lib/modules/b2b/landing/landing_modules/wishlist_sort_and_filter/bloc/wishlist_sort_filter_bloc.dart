import 'package:kgk/kgk.dart';

part 'wishlist_sort_filter_event.dart';

part 'wishlist_sort_filter_state.dart';

class WishlistSortFilterBloc extends Bloc<WishlistSortFilterEvent, WishlistSortFilterState> {
  /// initial sort data
  SortOptions selectedSortData = SortOptions(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc);

  /// selected filter data
  FilterData? selectedFilterData;

  /// sort data list
  List<SortOptions> sortData = [
    SortOptions(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc),
  ];

  /// filter data list
  List<FilterData> filterData = [];

  /// secondary filter data
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  /// search controller
  final TextEditingController searchController = TextEditingController();

  WishlistSortFilterBloc() : super(WishlistSortFilterInitial()) {
    /// search listener
    searchController.addListener(searchChange);
    on<AddWishlistSortFilterDataEvent>(_onAddWishlistSortFilterDataEvent);
    on<SelectWishlistSortDataEvent>(_onSelectWishlistSortDataEvent);
    on<SelectWishlistFilterDataEvent>(_onSelectWishlistFilterDataEvent);
    on<SelectWishlistSecondaryFilterDataEvent>(_onSelectWishlistSecondaryFilterDataEvent);
    on<SearchWishlistFilterDataEvent>(_onSearchWishlistFilterDataEvent);
    on<ClearAllWishlistFilterDataEvent>(_onClearAllWishlistFilterDataEvent);
    on<ApplyWishlistFilterDataEvent>(_onApplyWishlistFilterDataEvent);
  }

  void searchChange() {
    add(SearchWishlistFilterDataEvent(searchQuery: searchController.text));
  }

  Future<void> _onAddWishlistSortFilterDataEvent(AddWishlistSortFilterDataEvent event, Emitter<WishlistSortFilterState> emit) async {
    filterData = event.filterOptionList;

    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(WishlistFilterDataSelectedState(selectedFilterData ?? FilterData()));
    } else {
      selectedFilterData = null;
      secondaryFilterDataDisplay.clear();
      emit(WishlistSortReloadState());
    }
  }

  void _onSelectWishlistSortDataEvent(SelectWishlistSortDataEvent event, Emitter<WishlistSortFilterState> emit) {
    selectedSortData = event.sortData;
    emit(WishlistSortDataSelectedState(selectedSortData));
  }

  Future<void> _onSelectWishlistFilterDataEvent(SelectWishlistFilterDataEvent event, Emitter<WishlistSortFilterState> emit) async {
    if (selectedFilterData != event.filterData) {
      selectedFilterData = event.filterData;
      searchController.text = '';
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(WishlistFilterDataSelectedState(selectedFilterData!));
    }
  }

  void _onSelectWishlistSecondaryFilterDataEvent(SelectWishlistSecondaryFilterDataEvent event, Emitter<WishlistSortFilterState> emit) {
    emit(WishlistSortReloadState());
    final index = selectedFilterData?.secondaryFilterData?.indexWhere((e) => e == event.secondaryFilterData) ?? -1;

    if (index != -1 && selectedFilterData != null) {
      selectedFilterData?.secondaryFilterData?[index].isSelected = !selectedFilterData!.secondaryFilterData![index].isSelected;
      emit(WishlistSelectSecondaryFilterDataState(selectedFilterData!.secondaryFilterData![index]));
    }
  }

  void _onSearchWishlistFilterDataEvent(SearchWishlistFilterDataEvent event, Emitter<WishlistSortFilterState> emit) {
    if (selectedFilterData == null) return;

    if (event.searchQuery.isNotEmpty) {
      secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData!
          .where((element) => (element.name ?? '').toLowerCase().contains(event.searchQuery.trim().toLowerCase()))
          .toList();
    } else {
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    }
    emit(SearchWishlistFilterDataState(secondaryFilterDataDisplay));
  }

  void _onClearAllWishlistFilterDataEvent(ClearAllWishlistFilterDataEvent event, Emitter<WishlistSortFilterState> emit) {
    /// Check if filters are already cleared
    bool areFiltersCleared =
        filterData.every((element) => element.secondaryFilterData?.every((secondaryElement) => !secondaryElement.isSelected) ?? true);

    /// If filters are already cleared, do nothing
    if (areFiltersCleared) {
      Utils.showMessage(APPStrings.allFiltersCleared.tr);
      return;
    }

    for (var filter in filterData) {
      filter.secondaryFilterData?.forEach((secondaryFilter) => secondaryFilter.isSelected = false);
    }
    selectedFilterData = filterData.isNotEmpty ? filterData.first : null;
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    emit(WishlistFilterDataSelectedState(selectedFilterData ?? FilterData()));
    event.onApply(filterData);
  }

  void _onApplyWishlistFilterDataEvent(ApplyWishlistFilterDataEvent event, Emitter<WishlistSortFilterState> emit) {}
}
