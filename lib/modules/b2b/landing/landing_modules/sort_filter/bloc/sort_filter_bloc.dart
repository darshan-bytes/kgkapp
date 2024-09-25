import 'package:kgk/kgk.dart';

part 'sort_filter_event.dart';

part 'sort_filter_state.dart';

class SortFilterBloc extends Bloc<SortFilterEvent, SortFilterState> {
  List<SortData> sortData = [
    SortData(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc),
    SortData(name: APPStrings.descending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueDesc),
    SortData(name: APPStrings.priceHighToLow, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueDesc),
    SortData(name: APPStrings.priceLowToHigh, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueAsc),
    SortData(name: APPStrings.mostViewed, sortKey: AppConst.sortKeyViewCount, sortValue: AppConst.sortValueDesc),
  ];

  SortData selectedSortData = SortData(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc);

  List<FilterData> filterData = [];
  bool isLoading = false;

  FilterData? selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  SortFilterBloc() : super(SortFilterInitial()) {
    searchController.addListener(searchChange);
    on<SelectSortDataEvent>(_onSelectSortDataEvent);
    on<SelectFilterDataEvent>(_onSelectFilterDataEvent);
    on<SelectSecondaryFilterDataEvent>(_onSelectSecondaryFilterDataEvent);
    on<SearchFilterDataEvent>(_onSearchFilterDataEvent);
    on<ClearAllFilterDataEvent>(_onClearAllFilterDataEvent);
    on<ApplyFilterDataEvent>(_onApplyFilterDataEvent);
    on<AddSortFilterDataEvent>(_onAddSortFilterDataEvent);
    on<SortFilterScreenTypeEvent>(_onSortFilterScreenTypeEvent);
  }

  void searchChange() {
    add(SearchFilterDataEvent(searchQuery: searchController.text));
  }

  void _onSelectSortDataEvent(SelectSortDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    selectedSortData = event.sortData;
    emit(SortDataSelectedState(selectedSortData));
  }

  void _onSelectFilterDataEvent(SelectFilterDataEvent event, Emitter<SortFilterState> emit) {
    if (selectedFilterData != event.filterData) {
      emit(SortReloadState());
      selectedFilterData = event.filterData;
      searchController.text = '';
      add(const SearchFilterDataEvent(searchQuery: ''));
      if (selectedFilterData != null) {
        emit(FilterDataSelectedState(selectedFilterData!));
      }
    }
  }

  void _onSelectSecondaryFilterDataEvent(SelectSecondaryFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    final int index = (selectedFilterData?.secondaryFilterData ?? []).indexWhere((element) => element == event.secondaryFilterData);
    if (index != -1 && selectedFilterData != null) {
      selectedFilterData?.secondaryFilterData?[index].isSelected = !selectedFilterData!.secondaryFilterData![index].isSelected;
      emit(SelectSecondaryFilterDataState(selectedFilterData!.secondaryFilterData![index]));
    }
  }

  void _onSearchFilterDataEvent(SearchFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    if (selectedFilterData == null) {
      return;
    }
    if (searchController.text.isNotEmpty) {
      secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData!
          .where((element) => (element.name ?? '').toLowerCase().contains(searchController.text.trim().toLowerCase()))
          .toList();
    } else {
      secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData ?? [];
    }
    emit(SearchFilterDataState(secondaryFilterDataDisplay));
  }

  void _onClearAllFilterDataEvent(ClearAllFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    searchController.text = '';
    for (var element in filterData) {
      element.secondaryFilterData?.forEach((element) {
        element.isSelected = false;
      });
    }
    selectedFilterData = filterData.first;
    if (selectedFilterData != null) {
      secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData ?? [];
      emit(FilterDataSelectedState(selectedFilterData!));
    }
  }

  void _onApplyFilterDataEvent(ApplyFilterDataEvent event, Emitter<SortFilterState> emit) {
    //TODO: Implement apply filter logic
  }

  Future<void> _onAddSortFilterDataEvent(AddSortFilterDataEvent event, Emitter<SortFilterState> emit) async {
    filterData.clear();
    for (var gemstone in event.gemstoneFilterList) {
      filterData.add(FilterData(
        name: gemstone.name,
        code: gemstone.slug,
        secondaryFilterData: [],
      ));
    }
    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;
      await fetchSecondaryFilterData(context: event.context, emit: emit, slug: selectedFilterData!.code!, needToFetchData: true);
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    }
  }

  Future<void> fetchSecondaryFilterData(
      {required BuildContext context, required Emitter<SortFilterState> emit, required String slug, required bool needToFetchData}) async {
    if (!needToFetchData) {
      return;
    }
    isLoading = true;

    /// Add filter codes
    const String codes =
        'PEAR,EMERALD,CUSHION BRILLIANT,PRINCESS,ROUND D/C,ROUND,SQUARE CUSHION,SQUARE P/C,HEART,ASSCHER,Square E/C,MARQUISE,BAGUETTE,E/C,OVAL,RADIANT,MIX,CUSHION,OCTAGON,TRILLION,CAB MIX,TRIANGLE,CAB ROUND';

    final response = await AppRepository(context).getSecondaryFilterData(slug: slug, codes: codes);

    response?.fold(
      (l) => Utils.showMessage(l.message),
      (r) async {
        final filteredData = filterData.where((item) => item.code == slug).toList();

        if (filteredData.isNotEmpty) {
          for (final item in r) {
            filteredData.first.secondaryFilterData?.add(
              SecondaryFilterData(
                name: item.value,
                code: item.label,
                image: 'https://i.ibb.co/80xk2MK/Frame-1410088948-5.png',
              ),
            );
          }
        }

        isLoading = false;
        emit(SelectSecondaryDiamondSortFilterDataState(r));
      },
    );
  }

  /// This method is used to show/hide sort data based on screen type
  void _onSortFilterScreenTypeEvent(SortFilterScreenTypeEvent event, Emitter<SortFilterState> emit) {
    selectedSortData = sortData.first;
    List<SortData> iterable = [
      SortData(name: APPStrings.bestSeller, sortKey: AppConst.sortKeyBestSeller, sortValue: AppConst.sortValueDesc),
      SortData(name: APPStrings.newArrival, sortKey: AppConst.sortKeyNewArrival, sortValue: AppConst.sortValueDesc),
    ];
    if (event.screenIdentifier == ScreenIdentifier.productForRing) {
      sortData.addAll(iterable);
    } else {
      sortData.removeWhere((item) => iterable.contains(item));
    }
  }
}
