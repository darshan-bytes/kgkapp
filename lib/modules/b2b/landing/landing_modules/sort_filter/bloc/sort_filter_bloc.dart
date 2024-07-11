import 'package:kgk/kgk.dart';

part 'sort_filter_event.dart';

part 'sort_filter_state.dart';

class SortFilterBloc extends Bloc<SortFilterEvent, SortFilterState> {
  List<SortData> sortData = [
    SortData(name: APPStrings.whatsNew.tr, code: 'new'),
    SortData(name: APPStrings.discount.tr, code: 'discount'),
    SortData(name: APPStrings.popularity.tr, code: 'popularity'),
    SortData(name: APPStrings.priceHighToLow.tr, code: 'price_asc'),
    SortData(name: APPStrings.priceLowToHigh.tr, code: 'price_desc'),
  ];

  SortData selectedSortData = SortData(name: 'What’s new', code: 'new');

  List<FilterData> filterData = [
    FilterData(
      name: 'Jewellery',
      code: 'jewellery',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Metal',
      code: 'metal',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Diamond',
      code: 'diamond',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Carat',
      code: 'carat',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Size',
      code: 'size',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Colour',
      code: 'colour',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Clarity',
      code: 'clarity',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Gemstone',
      code: 'gemstone',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Price',
      code: 'price',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: 'Collection',
      code: 'collection',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Rings', code: 'rings'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
        SecondaryFilterData(name: 'Earrings', code: 'earrings'),
        SecondaryFilterData(name: 'Bracelets', code: 'bracelets'),
        SecondaryFilterData(name: 'Necklaces', code: 'necklaces'),
      ],
    ),
    FilterData(
      name: APPStrings.status.tr,
      code: APPStrings.status.tr,
      secondaryFilterData: [
        SecondaryFilterData(name: APPStrings.blueInProgress.tr, code: APPStrings.blueInProgress.tr),
        SecondaryFilterData(name: APPStrings.approved.tr, code: APPStrings.approved.tr),
        SecondaryFilterData(name: APPStrings.pending.tr, code: APPStrings.pending.tr),
      ],
    ),
    FilterData(
      name: APPStrings.createdBy.tr,
      code: APPStrings.status.tr.toLowerCase(),
      secondaryFilterData: [
        SecondaryFilterData(name: 'Jenny Wilson', code: 'jenny wilson'),
        SecondaryFilterData(name: 'John Samanta', code: 'john samanta'),
        SecondaryFilterData(name: 'Alex Williams', code: 'alex williams'),
      ],
    ),
    FilterData(
      name: APPStrings.createdOn.tr,
      code: APPStrings.createdOn.tr.toLowerCase(),
      secondaryFilterData: [
        SecondaryFilterData(name: "24/03/2023", code: "24/03/2023"),
        SecondaryFilterData(name: "25/03/2023", code: "25/03/2023"),
        SecondaryFilterData(name: "26/03/2023", code: "26/03/2023"),
      ],
    ),
  ];

  late FilterData selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  SortFilterBloc() : super(SortFilterInitial()) {
    selectedFilterData = filterData.first;
    secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    searchController.addListener(searchChange);
    on<SelectSortDataEvent>(_onSelectSortDataEvent);
    on<SelectFilterDataEvent>(_onSelectFilterDataEvent);
    on<SelectSecondaryFilterDataEvent>(_onSelectSecondaryFilterDataEvent);
    on<SearchFilterDataEvent>(_onSearchFilterDataEvent);
    on<ClearAllFilterDataEvent>(_onClearAllFilterDataEvent);
    on<ApplyFilterDataEvent>(_onApplyFilterDataEvent);
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
      emit(FilterDataSelectedState(selectedFilterData));
    }
  }

  void _onSelectSecondaryFilterDataEvent(SelectSecondaryFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    final int index = (selectedFilterData.secondaryFilterData ?? []).indexWhere((element) => element == event.secondaryFilterData);
    if (index != -1) {
      selectedFilterData.secondaryFilterData?[index].isSelected = !selectedFilterData.secondaryFilterData![index].isSelected;
      emit(SelectSecondaryFilterDataState(selectedFilterData.secondaryFilterData![index]));
    }
  }

  void _onSearchFilterDataEvent(SearchFilterDataEvent event, Emitter<SortFilterState> emit) {
    emit(SortReloadState());
    if (searchController.text.isNotEmpty) {
      secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData!
          .where((element) => (element.name ?? '').toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
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
    secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    emit(FilterDataSelectedState(selectedFilterData));
  }

  void _onApplyFilterDataEvent(ApplyFilterDataEvent event, Emitter<SortFilterState> emit) {
    //TODO: Implement apply filter logic
  }
}
