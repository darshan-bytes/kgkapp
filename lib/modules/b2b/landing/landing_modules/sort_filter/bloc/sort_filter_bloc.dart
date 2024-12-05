import 'package:kgk/kgk.dart';

part 'sort_filter_event.dart';

part 'sort_filter_state.dart';

class SortFilterBloc extends Bloc<SortFilterEvent, SortFilterState> {
  final List<SortOptions> sortData = [
    SortOptions(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc),
    SortOptions(name: APPStrings.descending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueDesc),
    SortOptions(name: APPStrings.priceHighToLow, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueDesc),
    SortOptions(name: APPStrings.priceLowToHigh, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueAsc),
    SortOptions(name: APPStrings.mostViewed, sortKey: AppConst.sortKeyViewCount, sortValue: AppConst.sortValueDesc),
  ];

  SortOptions selectedSortData = SortOptions(
    name: APPStrings.ascending,
    sortKey: AppConst.sortKeySuid,
    sortValue: AppConst.sortValueAsc,
  );

  List<FilterData> filterData = [];
  FilterData? selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];
  bool isLoading = false;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController(text: '0');
  final TextEditingController maxPriceController = TextEditingController();

  SortFilterBloc() : super(SortFilterInitial()) {
    searchController.addListener(() => add(SearchFilterDataEvent(searchQuery: searchController.text)));

    on<AddSortFilterDataEvent>(_onAddSortFilterDataEvent);
    on<SelectSortDataEvent>(_onSelectSortDataEvent);
    on<SelectFilterDataEvent>(_onSelectFilterDataEvent);
    on<SelectSecondaryFilterDataEvent>(_onSelectSecondaryFilterDataEvent);
    on<SearchFilterDataEvent>(_onSearchFilterDataEvent);
    on<ClearAllFilterDataEvent>(_onClearAllFilterDataEvent);
    // on<ApplyFilterDataEvent>(_onApplyFilterDataEvent);
    // on<SortFilterScreenTypeEvent>(_onSortFilterScreenTypeEvent);
    on<SortAndFilterPriceRangeChangedEvent>(_onSortAndFilterPriceRangeChangedEvent);
    // on<SortAndFilterPriceRangeEditEvent>(_onSortAndFilterPriceRangeEditEvent);
  }

  // Helper to update range controllers
  void _updatePriceRangeControllers(SfRangeValues values) {
    minPriceController.text = values.start.toString();
    maxPriceController.text = values.end.toString();
  }

  void _onSelectSortDataEvent(SelectSortDataEvent event, Emitter<SortFilterState> emit) {
    selectedSortData = event.sortData;
    emit(SortDataSelectedState(selectedSortData));
  }

  Future<void> _onSelectFilterDataEvent(SelectFilterDataEvent event, Emitter<SortFilterState> emit) async {
    if (selectedFilterData == event.filterData) return;

    selectedFilterData = event.filterData;
    searchController.clear();
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];

    emit(FilterDataSelectedState(selectedFilterData!));

    if (selectedFilterData?.secondaryFilterData.isNullOrEmpty == true) {
      final fetchedData = await fetchSecondaryFilterData(
        context: event.context,
        slug: selectedFilterData?.code ?? '',
        codes: selectedFilterData?.subFilterCodes ?? '',
      );
      selectedFilterData?.secondaryFilterData = fetchedData;
      secondaryFilterDataDisplay = fetchedData;
      emit(SelectSecondaryDiamondSortFilterDataState(secondaryFilterDataDisplay));
    }
  }

  void _onSelectSecondaryFilterDataEvent(SelectSecondaryFilterDataEvent event, Emitter<SortFilterState> emit) {
    final selected = event.secondaryFilterData;
    selected.isSelected = !selected.isSelected;
    emit(SelectSecondaryFilterDataState(selected));
  }

  void _onSearchFilterDataEvent(SearchFilterDataEvent event, Emitter<SortFilterState> emit) {
    final query = event.searchQuery.trim().toLowerCase();
    secondaryFilterDataDisplay = query.isNotEmpty
        ? (selectedFilterData?.secondaryFilterData ?? []).where((data) => (data.name ?? '').toLowerCase().contains(query)).toList()
        : selectedFilterData?.secondaryFilterData ?? [];
    emit(SearchFilterDataState(secondaryFilterDataDisplay));
  }

  void _onClearAllFilterDataEvent(ClearAllFilterDataEvent event, Emitter<SortFilterState> emit) {
    for (var filter in filterData) {
      filter.secondaryFilterData?.forEach((data) => data.isSelected = false);
    }
    selectedFilterData = filterData.first;
    searchController.clear();
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    emit(FilterDataSelectedState(selectedFilterData!));
    event.onApply(filterData);
  }

  Future<void> _onAddSortFilterDataEvent(AddSortFilterDataEvent event, Emitter<SortFilterState> emit) async {
    filterData = event.filterOptionList;
    if (filterData.isEmpty) return;

    selectedFilterData = filterData.first;
    if (selectedFilterData?.filterType == FilterType.range) {
      _updatePriceRangeControllers(selectedFilterData!.rangeValues!);
    } else {
      selectedFilterData?.secondaryFilterData = await fetchSecondaryFilterData(
        context: event.context,
        slug: selectedFilterData!.code ?? '',
        codes: selectedFilterData!.subFilterCodes ?? '',
      );
    }
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    emit(FilterDataSelectedState(selectedFilterData!));
  }

  Future<List<SecondaryFilterData>> fetchSecondaryFilterData({
    required BuildContext context,
    required String slug,
    required String codes,
  }) async {
    isLoading = true;
    final response = await AppRepository(context).getSecondaryFilterData(slug: slug, codes: codes);
    isLoading = false;

    return response?.fold(
          (failure) {
            Utils.showMessage(failure.message);
            return [];
          },
          (data) => data.map((e) => SecondaryFilterData(name: e.label, code: e.value)).toList(),
        ) ??
        [];
  }

  void _onSortAndFilterPriceRangeChangedEvent(SortAndFilterPriceRangeChangedEvent event, Emitter<SortFilterState> emit) {
    selectedFilterData?.rangeValues = event.values;
    _updatePriceRangeControllers(event.values);
    emit(const SortAndFilterPriceRangeChangedState());
  }
}
