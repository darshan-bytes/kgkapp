import 'package:kgk/kgk.dart';

part 'sort_filter_event.dart';

part 'sort_filter_state.dart';

class SortFilterBloc extends Bloc<SortFilterEvent, SortFilterState> {
  List<SortOptions> sortData = [
    SortOptions(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc),
    SortOptions(name: APPStrings.descending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueDesc),
    SortOptions(name: APPStrings.priceHighToLow, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueDesc),
    SortOptions(name: APPStrings.priceLowToHigh, sortKey: AppConst.sortKeyMspRateLocalCurrency, sortValue: AppConst.sortValueAsc),
    SortOptions(name: APPStrings.mostViewed, sortKey: AppConst.sortKeyViewCount, sortValue: AppConst.sortValueDesc),
  ];

  SortOptions selectedSortData = SortOptions(name: APPStrings.ascending, sortKey: AppConst.sortKeySuid, sortValue: AppConst.sortValueAsc);

  List<FilterData> filterData = [];
  bool isLoading = false;

  FilterData? selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  TextEditingController minPriceController = TextEditingController(text: '0');
  TextEditingController maxPriceController = TextEditingController();

  SortFilterBloc() : super(SortFilterInitial()) {
    searchController.addListener(searchChange);
    on<AddSortFilterDataEvent>(_onAddSortFilterDataEvent);
    on<SelectSortDataEvent>(_onSelectSortDataEvent);
    on<SelectFilterDataEvent>(_onSelectFilterDataEvent);
    on<SelectSecondaryFilterDataEvent>(_onSelectSecondaryFilterDataEvent);
    on<SearchFilterDataEvent>(_onSearchFilterDataEvent);
    on<ClearAllFilterDataEvent>(_onClearAllFilterDataEvent);
    on<ApplyFilterDataEvent>(_onApplyFilterDataEvent);

    /// Need to discuss with team for the below event
    // on<SortFilterScreenTypeEvent>(_onSortFilterScreenTypeEvent);
    on<SortAndFilterPriceRangeChangedEvent>(_onSortAndFilterPriceRangeChangedEvent);
    on<SortAndFilterPriceRangeEditEvent>(_onSortAndFilterPriceRangeEditEvent);
  }

  void searchChange() {
    add(SearchFilterDataEvent(searchQuery: searchController.text));
  }

  void _onSelectSortDataEvent(SelectSortDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    selectedSortData = event.sortData;
    emit(SortDataSelectedState(selectedSortData));
  }

  Future<void> _onSelectFilterDataEvent(SelectFilterDataEvent event, Emitter<SortFilterState> emit) async {
    if (selectedFilterData != event.filterData) {
      emit(SortReloadState());
      selectedFilterData = event.filterData;
      searchController.text = '';
      add(const SearchFilterDataEvent(searchQuery: ''));
      if (selectedFilterData != null) {
        emit(FilterDataSelectedState(selectedFilterData!));
        bool needToFetchData = selectedFilterData?.secondaryFilterData.isNullOrEmpty == true;
        if (needToFetchData) {
          int index = filterData.indexWhere((element) => element == selectedFilterData);

          List<SecondaryFilterData>? secondaryFilterData = await fetchSecondaryFilterData(
            context: event.context,
            emit: emit,
            slug: selectedFilterData?.code ?? '',
            needToFetchData: selectedFilterData?.secondaryFilterData.isNullOrEmpty == true,
            codes: selectedFilterData?.subFilterCodes ?? '',
          );
          filterData[index].secondaryFilterData = secondaryFilterData;
          selectedFilterData?.secondaryFilterData = secondaryFilterData;
        }
        secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
        emit(SelectSecondaryDiamondSortFilterDataState(secondaryFilterDataDisplay));
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
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    }
    emit(SearchFilterDataState(secondaryFilterDataDisplay));
  }

  void _onClearAllFilterDataEvent(ClearAllFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    searchController.text = '';
    for (var element in filterData) {
      if (element.filterType == FilterType.range) {
        element.rangeValues = null;
      } else {
        element.secondaryFilterData?.forEach((element) {
          element.isSelected = false;
        });
      }
    }
    selectedFilterData = filterData.first;
    if (selectedFilterData != null) {
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(FilterDataSelectedState(selectedFilterData ?? FilterData()));
    }
    event.onApply(filterData);
    event.context.pop();
  }

  void _onApplyFilterDataEvent(ApplyFilterDataEvent event, Emitter<SortFilterState> emit) {
    //TODO: Implement apply filter logic
  }

  Future<void> _onAddSortFilterDataEvent(AddSortFilterDataEvent event, Emitter<SortFilterState> emit) async {
    filterData = event.filterOptionList;

    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;

      if (selectedFilterData?.filterType == FilterType.range) {
        minPriceController.text = '${selectedFilterData?.rangeValues?.start.toString()}';
        maxPriceController.text = '${selectedFilterData?.rangeValues?.end.toString()}';
        isLoading = false;
      } else {
        selectedFilterData?.secondaryFilterData = await fetchSecondaryFilterData(
          context: event.context,
          emit: emit,
          slug: selectedFilterData?.code ?? '',
          needToFetchData: true,
          codes: selectedFilterData?.subFilterCodes ?? '',
        );
      }
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(FilterDataSelectedState(selectedFilterData!));
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(SelectSecondaryDiamondSortFilterDataState(secondaryFilterDataDisplay));
    }
  }

  Future<List<SecondaryFilterData>> fetchSecondaryFilterData({
    required BuildContext context,
    required Emitter<SortFilterState> emit,
    required String slug,
    required String codes,
    bool needToFetchData = false,
  }) async {
    List<SecondaryFilterData> secondaryFilterData = [];
    if (!needToFetchData) return secondaryFilterData;

    isLoading = true;

    final response = await AppRepository(context).getSecondaryFilterData(slug: slug, codes: codes);

    response?.fold(
      (l) {
        isLoading = false;
        return Utils.showMessage(l.message);
      },
      (r) {
        if (r.isNotEmpty) {
          secondaryFilterData = r.map((e) => SecondaryFilterData(name: e.label, code: e.value)).toList();
        }

        isLoading = false;
      },
    );
    emit(SelectSecondaryDiamondSortFilterDataState(secondaryFilterData));
    return secondaryFilterData;
  }

  /// This method is used to show/hide sort data based on screen type
  // void _onSortFilterScreenTypeEvent(SortFilterScreenTypeEvent event, Emitter<SortFilterState> emit) {
  //   selectedSortData = sortData.first;
  //   List<SortOptions> iterable = [
  //     SortOptions(name: APPStrings.bestSeller, sortKey: AppConst.sortKeyBestSeller, sortValue: AppConst.sortValueDesc),
  //     SortOptions(name: APPStrings.newArrival, sortKey: AppConst.sortKeyNewArrival, sortValue: AppConst.sortValueDesc),
  //   ];
  //   if (event.screenIdentifier == ScreenIdentifier.productForRing) {
  //     sortData.addAll(iterable);
  //   } else {
  //     sortData.removeWhere((item) => iterable.contains(item));
  //   }
  // }

  void _onSortAndFilterPriceRangeChangedEvent(SortAndFilterPriceRangeChangedEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    selectedFilterData?.rangeValues = event.values;
    minPriceController.text = '${selectedFilterData?.rangeValues?.start.toString()}';
    maxPriceController.text = '${selectedFilterData?.rangeValues?.end.toString()}';
    emit(const SortAndFilterPriceRangeChangedState());
  }

  void _onSortAndFilterPriceRangeEditEvent(SortAndFilterPriceRangeEditEvent event, Emitter<SortFilterState> emit) {
    if (event.isMin) {
      handleMinPriceChange();
    } else {
      handleMaxPriceChange();
    }
  }

  /// Handles the change in the minimum price value from the text field.
  ///
  /// This method is triggered when there is a change in the text field for the minimum price.
  /// It parses the text field value to a double and validates it against the predefined minimum and maximum values.
  /// If the new minimum value is within the valid range and not greater than the current maximum value,
  /// it updates the price range and triggers a [OrionPriceRangeChangedEvent].
  /// If the new minimum value is greater than the current maximum value, it adjusts the maximum value to match the minimum,
  /// ensuring the range is valid. If the parsed value is not within the valid range, it resets the text field
  /// to the current minimum value of the price range.
  ///
  /// The method uses [minPriceController] to read and update the text field value,
  /// [minMaxValues] to check against the valid range, and [values] to update the current price range.
  void handleMinPriceChange() {
    double min = double.tryParse(minPriceController.text) ?? 0; // Attempt to parse the minimum price from the text field.
    if (min >= selectedFilterData?.minMaxValues?.start && min <= selectedFilterData?.minMaxValues?.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(min, selectedFilterData?.rangeValues?.end); // Create a new range with the updated minimum value.
      if (min >= selectedFilterData?.rangeValues?.end) {
        // Adjust the maximum value if the new minimum is greater than the current maximum.
        values = SfRangeValues(min, min);
      }
      add(SortAndFilterPriceRangeChangedEvent(values, isFromTextField: true, isMin: true)); // Trigger an event to update the price range.
    } else {
      Utils.showMessage(APPStrings.pleaseEnterValidPriceRangeX.tr
          .interpolate([selectedFilterData?.minMaxValues?.start, selectedFilterData?.minMaxValues?.end]));
      minPriceController.text =
          '${selectedFilterData?.rangeValues?.start.toString()}'; // Reset the text field if the value is out of range.
    }
  }

  /// Handles the change in the maximum price value from the text field.
  ///
  /// This method is invoked when there is a change in the text field for the maximum price.
  /// It attempts to parse the text field value to a double and validates it against the predefined
  /// minimum and maximum values defined in [minMaxValues]. If the parsed value is within the valid range,
  /// it updates the price range slider's maximum value accordingly. If the new maximum value is less than
  /// or equal to the current minimum value, it adjusts the minimum value to match the new maximum,
  /// ensuring the range is valid. If the parsed value is not within the valid range, it resets the text field
  /// to the current maximum value of the price range.
  ///
  /// The method uses [maxPriceController] to read and update the text field value,
  /// [minMaxValues] to check against the valid range, and [values] to update the current price range.
  void handleMaxPriceChange() {
    double max = double.tryParse(maxPriceController.text) ?? 0; // Attempt to parse the maximum price from the text field.
    if (max < (double.tryParse(minPriceController.text) ?? 0)) {
      maxPriceController.text = '${selectedFilterData?.rangeValues?.end.toString()}'; // Reset the text field if the value is out of range.
      Utils.showMessage(APPStrings.maxRangeShouldBeLessThanX.tr.interpolate([minPriceController.text]));
      return;
    }
    if (max >= selectedFilterData?.minMaxValues?.start && max <= selectedFilterData?.minMaxValues?.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values =
          SfRangeValues(selectedFilterData?.rangeValues?.start, max); // Create a new range with the updated maximum value.
      if (max <= selectedFilterData?.rangeValues?.start) {
        // Adjust the minimum value if the new maximum is less than or equal to the current minimum.
        values = SfRangeValues(max, max);
      }
      add(SortAndFilterPriceRangeChangedEvent(values, isFromTextField: true, isMin: false)); // Trigger an event to update the price range.
    } else {
      // add String with Amount
      Utils.showMessage(APPStrings.pleaseEnterValidPriceRangeX.tr
          .interpolate([selectedFilterData?.minMaxValues?.start, selectedFilterData?.minMaxValues?.end]));
      maxPriceController.text = '${selectedFilterData?.rangeValues?.end.toString()}'; // Reset the text field if the value is out of range.
    }
  }
}
