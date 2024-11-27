import 'package:kgk/kgk.dart';

part 'diamond_filter_event.dart';
part 'diamond_filter_state.dart';

class DiamondFilterBloc extends Bloc<DiamondFilterEvent, DiamondFilterState> {
  bool isLoading = false;

  DiamondFilterBloc() : super(DiamondFilterInitial()) {
    on<LoadDiamondFilterDataEvent>(_onLoadDiamondFilterDataEvent);
    on<SelectDiamondFilterDataEvent>(_onSelectDiamondFilterDataEvent);
    on<SelectSecondaryDiamondFilterDataEvent>(_onSelectSecondaryDiamondFilterDataEvent);
    on<SearchDiamondFilterDataEvent>(_onSearchDiamondFilterDataEvent);
    on<ClearAllDiamondFilterDataEvent>(_onClearAllDiamondFilterDataEvent);
    on<ApplyDiamondFilterDataEvent>(_onApplyDiamondFilterDataEvent);
    on<AddFilterDataEvent>(_addFilterDataEvent);
    on<FilterPriceRangeChangedEvent>(_onFilterPriceRangeChangedEvent);
    on<FilterPriceRangeEditEvent>(_onFilterPriceRangeEditEvent);
  }

  /// NOTE :: FilterData model is Local model which is Getting data from API Data Model
  List<FilterData> filterData = [];

  FilterData? selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  String minValue = '500';
  String maxValue = '10000';
  SfRangeValues? minMaxValues;
  SfRangeValues? values;

  void searchChange() {
    add(SearchDiamondFilterDataEvent(searchQuery: searchController.text));
  }

  void _onLoadDiamondFilterDataEvent(LoadDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    minPriceController.text = minValue;
    maxPriceController.text = maxValue;
    minMaxValues = SfRangeValues(minValue, maxValue);
    values = SfRangeValues(minValue, maxValue);

    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    if (filterData.isNotEmpty) {
      searchController.addListener(searchChange);
      emit(DiamondFilterDataLoadedState(filterData));
      if (selectedFilterData != null) {
        emit(DiamondFilterDataSelectedState(selectedFilterData!));
      }
    }
  }

  Future<void> _onSelectDiamondFilterDataEvent(SelectDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) async {
    if (selectedFilterData != event.filterData) {
      isLoading = true;
      emit(DiamondFilterReloadState());
      selectedFilterData = event.filterData;
      searchController.text = '';

      ///TODO : SEARCH WILL BE USED IN FUTURE
      // add(const SearchDiamondFilterDataEvent(searchQuery: ''));

      secondaryFilterDataDisplay = [
        SecondaryFilterData(name: "one", code: "one"),
        SecondaryFilterData(name: "two", code: "two"),
        SecondaryFilterData(name: "three", code: "three"),
      ];

      emit(SecondaryFilterDataFetchedState([
        SecondaryFilterModel(value: "one", label: 'ONE'),
        SecondaryFilterModel(value: "two", label: 'TWO'),
        SecondaryFilterModel(value: "three", label: 'THREE'),
      ]));
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;

      /// TODO :: THIS API IS COMMENTED TEMPORARY TO GET STATIC DATA OF FILTER OPTIONS
      // await fetchSecondaryFilterData(
      //     context: event.context,
      //     emit: emit,
      //     slug: selectedFilterData?.code ?? '',
      //     needToFetchData: selectedFilterData!.secondaryFilterData.isNullOrEmpty);
      if (selectedFilterData != null) {
        emit(DiamondFilterDataSelectedState(selectedFilterData!));
      }
    }
  }

  void _onSelectSecondaryDiamondFilterDataEvent(SelectSecondaryDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    final int index = (selectedFilterData?.secondaryFilterData ?? []).indexWhere((element) => element == event.secondaryFilterData);
    if (index != -1 && selectedFilterData != null) {
      selectedFilterData?.secondaryFilterData?[index].isSelected = !selectedFilterData!.secondaryFilterData![index].isSelected;
      emit(SelectSecondaryDiamondFilterDataState(selectedFilterData!.secondaryFilterData![index]));
    }
  }

  void _onSearchDiamondFilterDataEvent(SearchDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    if (selectedFilterData != null) {
      if (searchController.text.isNotEmpty) {
        secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData!
            .where((element) => (element.name ?? '').toLowerCase().contains(searchController.text.trim().toLowerCase()))
            .toList();
      } else {
        secondaryFilterDataDisplay = selectedFilterData!.secondaryFilterData ?? [];
      }
      emit(SearchDiamondFilterDataState(secondaryFilterDataDisplay));
    }
  }

  void _onClearAllDiamondFilterDataEvent(ClearAllDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    searchController.text = '';
    for (var element in filterData) {
      element.secondaryFilterData?.forEach((element) {
        element.isSelected = false;
      });
    }
    selectedFilterData = filterData.first;
    if (selectedFilterData != null) {
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      emit(DiamondFilterDataSelectedState(selectedFilterData!));
    }
  }

  void _onApplyDiamondFilterDataEvent(ApplyDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    //TODO: Implement ApplyDiamondFilterDataEvent
  }

  Future<void> _addFilterDataEvent(AddFilterDataEvent event, Emitter<DiamondFilterState> emit) async {
    filterData.clear();
    for (var gemstone in event.gemstoneFilterList) {
      filterData.add(FilterData(
        name: gemstone.name,
        code: gemstone.slug,
        inputType: gemstone.inputType,
        secondaryFilterData: [],
      ));
    }
    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;
      isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;

      /// TODO :: THIS API IS COMMENTED TEMPORARY TO GET STATIC DATA OF FILTER OPTIONS
      // await fetchSecondaryFilterData(
      //     context: event.context,
      //     emit: emit,
      //     slug: selectedFilterData?.code ?? '',
      //     needToFetchData: selectedFilterData!.secondaryFilterData.isNullOrEmpty);
      // secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
      secondaryFilterDataDisplay = [
        SecondaryFilterData(name: "one", code: "one"),
        SecondaryFilterData(name: "two", code: "two"),
        SecondaryFilterData(name: "three", code: "three"),
      ];

      emit(SecondaryFilterDataFetchedState([
        SecondaryFilterModel(value: "one", label: 'ONE'),
        SecondaryFilterModel(value: "two", label: 'TWO'),
        SecondaryFilterModel(value: "three", label: 'THREE'),
      ]));
    }
  }

  // created getter for input type
  bool get isCheckbox => selectedFilterData?.inputType?.trim().toLowerCase() == Attributes.checkbox;

  Future<void> fetchSecondaryFilterData(
      {required BuildContext context,
      required Emitter<DiamondFilterState> emit,
      required String slug,
      required bool needToFetchData}) async {
    if (!needToFetchData) {
      return;
    }
    isLoading = true;

    ///
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
        emit(SecondaryFilterDataFetchedState(r));
      },
    );
  }

  void _onFilterPriceRangeChangedEvent(FilterPriceRangeChangedEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    if (values == null) return;
    values = event.values;
    minPriceController.text = '${values!.start.toStringAsFixed(0)}';
    maxPriceController.text = '${values!.end.toStringAsFixed(0)}';
    emit(const FilterPriceRangeChangedState());
  }

  void _onFilterPriceRangeEditEvent(FilterPriceRangeEditEvent event, Emitter<DiamondFilterState> emit) {
    if (minMaxValues == null || values == null) return;
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
    if (min >= minMaxValues!.start && min <= minMaxValues!.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(min, this.values!.end); // Create a new range with the updated minimum value.
      if (min >= this.values!.end) {
        // Adjust the maximum value if the new minimum is greater than the current maximum.
        values = SfRangeValues(min, min);
      }
      add(FilterPriceRangeChangedEvent(values, isFromTextField: true, isMin: true)); // Trigger an event to update the price range.
    } else {
      Utils.showMessage(APPStrings.pleaseEnterValidPriceRangeX.tr.interpolate([minValue, maxValue]));
      minPriceController.text = '${values!.start.toStringAsFixed(0)}'; // Reset the text field if the value is out of range.
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
      maxPriceController.text = '${values!.end.toStringAsFixed(0)}'; // Reset the text field if the value is out of range.
      Utils.showMessage(APPStrings.maxRangeShouldBeLessThanX.tr.interpolate([minPriceController.text]));
      return;
    }
    if (max >= minMaxValues!.start && max <= minMaxValues!.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(this.values!.start, max); // Create a new range with the updated maximum value.
      if (max <= this.values!.start) {
        // Adjust the minimum value if the new maximum is less than or equal to the current minimum.
        values = SfRangeValues(max, max);
      }
      add(FilterPriceRangeChangedEvent(values, isFromTextField: true, isMin: false)); // Trigger an event to update the price range.
    } else {
      // add String with Amount
      Utils.showMessage(APPStrings.pleaseEnterValidPriceRangeX.tr.interpolate([minValue, maxValue]));
      maxPriceController.text = '${values!.end.toStringAsFixed(0)}'; // Reset the text field if the value is out of range.
    }
  }
}
