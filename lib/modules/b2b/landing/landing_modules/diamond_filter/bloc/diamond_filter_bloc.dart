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
  }

  List<FilterData> filterData = [];

  FilterData? selectedFilterData;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  void searchChange() {
    add(SearchDiamondFilterDataEvent(searchQuery: searchController.text));
  }

  void _onLoadDiamondFilterDataEvent(LoadDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
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
      emit(DiamondFilterReloadState());
      selectedFilterData = event.filterData;
      searchController.text = '';
      add(const SearchDiamondFilterDataEvent(searchQuery: ''));
      await fetchSecondaryFilterData(
          context: event.context,
          emit: emit,
          slug: selectedFilterData?.code ?? '',
          needToFetchData: selectedFilterData!.secondaryFilterData.isNullOrEmpty);
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
        secondaryFilterData: [],
      ));
    }
    if (filterData.isNotEmpty) {
      selectedFilterData = filterData.first;
      await fetchSecondaryFilterData(
          context: event.context,
          emit: emit,
          slug: selectedFilterData?.code ?? '',
          needToFetchData: selectedFilterData!.secondaryFilterData.isNullOrEmpty);
      secondaryFilterDataDisplay = selectedFilterData?.secondaryFilterData ?? [];
    }
  }

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
          (l) => Utils.showMessage(l.message ?? ""),
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
}
