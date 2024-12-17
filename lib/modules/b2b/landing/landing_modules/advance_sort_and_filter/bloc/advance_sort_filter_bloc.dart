import 'package:kgk/kgk.dart';

part 'advance_sort_filter_event.dart';

part 'advance_sort_filter_state.dart';

class AdvanceSortFilterBloc extends Bloc<AdvanceSortFilterEvent, AdvanceSortFilterState> {
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

  AdvanceSortFilterBloc() : super(AdvanceSortFilterInitial()) {
    /// search listener
    searchController.addListener(searchChange);
    on<AddAdvanceSortFilterDataEvent>(_onAddWishlistSortFilterDataEvent);
    on<SelectAdvanceSortDataEvent>(_onSelectWishlistSortDataEvent);
    on<SelectAdvanceFilterDataEvent>(_onSelectWishlistFilterDataEvent);
    on<SelectAdvanceSecondaryFilterDataEvent>(_onSelectWishlistSecondaryFilterDataEvent);
    on<SearchAdvanceFilterDataEvent>(_onSearchWishlistFilterDataEvent);
    on<ClearAllAdvanceFilterDataEvent>(_onClearAllWishlistFilterDataEvent);
    on<ApplyAdvanceFilterDataEvent>(_onApplyWishlistFilterDataEvent);
    on<ChangeAdvanceDateRangeEvent>(_onChangeWishlistDateRangeEvent);
  }

  void searchChange() {
    add(SearchAdvanceFilterDataEvent(searchQuery: searchController.text));
  }

  Future<void> _onAddWishlistSortFilterDataEvent(AddAdvanceSortFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) async {
    emit(AdvanceSortReloadState());
    filterData = event.filterOptionList;

    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(AdvanceFilterDataSelectedState(selectedFilterData ?? FilterData()));
    } else {
      selectedFilterData = null;
      secondaryFilterDataDisplay.clear();
      emit(AdvanceSortReloadState());
    }
  }

  void _onSelectWishlistSortDataEvent(SelectAdvanceSortDataEvent event, Emitter<AdvanceSortFilterState> emit) {
    emit(AdvanceSortReloadState());
    selectedSortData = event.sortData;
    emit(AdvanceSortDataSelectedState(selectedSortData));
  }

  Future<void> _onSelectWishlistFilterDataEvent(SelectAdvanceFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) async {
    emit(AdvanceSortReloadState());
    if (selectedFilterData != event.filterData) {
      selectedFilterData = event.filterData;
      searchController.text = '';
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(AdvanceFilterDataSelectedState(selectedFilterData!));
    }
  }

  void _onSelectWishlistSecondaryFilterDataEvent(SelectAdvanceSecondaryFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) {
    emit(AdvanceSortReloadState());
    final index = selectedFilterData?.secondaryFilterData?.indexWhere((e) => e == event.secondaryFilterData) ?? -1;

    if (index != -1 && selectedFilterData != null) {
      selectedFilterData?.secondaryFilterData?[index].isSelected = !selectedFilterData!.secondaryFilterData![index].isSelected;
      emit(AdvanceSelectSecondaryFilterDataState(selectedFilterData!.secondaryFilterData![index]));
    }
  }

  void _onSearchWishlistFilterDataEvent(SearchAdvanceFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) {
    if (selectedFilterData == null) return;
    emit(AdvanceSortReloadState());

    if (event.searchQuery.isNotEmpty) {
      secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData!
          .where((element) => (element.name ?? '').toLowerCase().contains(event.searchQuery.trim().toLowerCase()))
          .toList();
    } else {
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    }
    emit(SearchAdvanceFilterDataState(secondaryFilterDataDisplay));
  }

  void _onClearAllWishlistFilterDataEvent(ClearAllAdvanceFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) {
    emit(AdvanceSortReloadState());

    /// Check if filters are already cleared
    bool areFiltersCleared = filterData.every((element) {
      if (element.filterType == FilterType.dateRange) {
        return element.dateRange == null;
      }
      return element.secondaryFilterData?.every((secondaryElement) => !secondaryElement.isSelected) ?? true;
    });

    /// If filters are already cleared, do nothing
    if (areFiltersCleared) {
      Utils.showMessage(APPStrings.allFiltersCleared.tr);
      return;
    }

    for (var filter in filterData) {
      filter.dateRange = null;
      filter.secondaryFilterData?.forEach((secondaryFilter) => secondaryFilter.isSelected = false);
    }
    selectedFilterData = filterData.isNotEmpty ? filterData.first : null;
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    emit(AdvanceFilterDataSelectedState(selectedFilterData ?? FilterData()));
    event.onApply(filterData);
  }

  void _onApplyWishlistFilterDataEvent(ApplyAdvanceFilterDataEvent event, Emitter<AdvanceSortFilterState> emit) {}

  void _onChangeWishlistDateRangeEvent(ChangeAdvanceDateRangeEvent event, Emitter<AdvanceSortFilterState> emit) {
    emit(AdvanceSortReloadState());
    if (selectedFilterData != null) {
      selectedFilterData?.dateRange = event.dateRange;
      emit(AdvanceFilterDataSelectedState(selectedFilterData!));
    }
  }
}
