import 'package:kgk/kgk.dart';

part 'diamond_filter_event.dart';

part 'diamond_filter_state.dart';

class DiamondFilterBloc extends Bloc<DiamondFilterEvent, DiamondFilterState> {
  DiamondFilterBloc() : super(DiamondFilterInitial()) {
    on<LoadDiamondFilterDataEvent>(_onLoadDiamondFilterDataEvent);
    on<SelectDiamondFilterDataEvent>(_onSelectDiamondFilterDataEvent);
    on<SelectSecondaryDiamondFilterDataEvent>(_onSelectSecondaryDiamondFilterDataEvent);
    on<SearchDiamondFilterDataEvent>(_onSearchDiamondFilterDataEvent);
    on<ClearAllDiamondFilterDataEvent>(_onClearAllDiamondFilterDataEvent);
    on<ApplyDiamondFilterDataEvent>(_onApplyDiamondFilterDataEvent);
  }

  List<FilterData> filterData = [
    FilterData(
      name: 'Shape',
      code: 'shape',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Round', code: 'round', image: 'https://i.ibb.co/0t0HyMp/Frame-1410088948.png'),
        SecondaryFilterData(name: 'Princess', code: 'princess', image: 'https://i.ibb.co/Czxfjrr/Frame-1410088948-2.png'),
        SecondaryFilterData(name: 'Emerald', code: 'emerald', image: 'https://i.ibb.co/HGKZm5K/Frame-1410088948-6.png'),
        SecondaryFilterData(name: 'Asscher', code: 'asscher', image: 'https://i.ibb.co/52XHw1d/Frame-1410088948-4.png'),
        SecondaryFilterData(name: 'Oval', code: 'oval', image: 'https://i.ibb.co/80xk2MK/Frame-1410088948-5.png'),
      ],
    ),
    FilterData(
      name: 'Carat Range',
      code: 'carat_range',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Carat Range 1', code: 'carat_range_1'),
        SecondaryFilterData(name: 'Carat Range 2', code: 'carat_range_2'),
        SecondaryFilterData(name: 'Carat Range 3', code: 'carat_range_3'),
      ],
    ),
    FilterData(
      name: 'Color (White/ Fancy)',
      code: 'color',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Color 1', code: 'color_1'),
        SecondaryFilterData(name: 'Color 2', code: 'color_2'),
        SecondaryFilterData(name: 'Color 3', code: 'color_3'),
      ],
    ),
    FilterData(
      name: 'Clarity',
      code: 'clarity',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Clarity 1', code: 'clarity_1'),
        SecondaryFilterData(name: 'Clarity 2', code: 'clarity_2'),
        SecondaryFilterData(name: 'Clarity 3', code: 'clarity_3'),
      ],
    ),
    FilterData(
      name: 'Cut',
      code: 'cut',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Cut 1', code: 'cut_1'),
        SecondaryFilterData(name: 'Cut 2', code: 'cut_2'),
        SecondaryFilterData(name: 'Cut 3', code: 'cut_3'),
      ],
    ),
    FilterData(
      name: 'Polish',
      code: 'polish',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Polish 1', code: 'polish_1'),
        SecondaryFilterData(name: 'Polish 2', code: 'polish_2'),
        SecondaryFilterData(name: 'Polish 3', code: 'polish_3'),
      ],
    ),
    FilterData(
      name: 'Symmetry',
      code: 'symmetry',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Symmetry 1', code: 'symmetry_1'),
        SecondaryFilterData(name: 'Symmetry 2', code: 'symmetry_2'),
        SecondaryFilterData(name: 'Symmetry 3', code: 'symmetry_3'),
      ],
    ),
    FilterData(
      name: 'FLR',
      code: 'flr',
      secondaryFilterData: [
        SecondaryFilterData(name: 'FLR 1', code: 'flr_1'),
        SecondaryFilterData(name: 'FLR 2', code: 'flr_2'),
        SecondaryFilterData(name: 'FLR 3', code: 'flr_3'),
      ],
    ),
    FilterData(
      name: 'LAB',
      code: 'lab',
      secondaryFilterData: [
        SecondaryFilterData(name: 'LAB 1', code: 'lab_1'),
        SecondaryFilterData(name: 'LAB 2', code: 'lab_2'),
        SecondaryFilterData(name: 'LAB 3', code: 'lab_3'),
      ],
    ),
    FilterData(
      name: 'Table',
      code: 'table',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Table 1', code: 'table_1'),
        SecondaryFilterData(name: 'Table 2', code: 'table_2'),
        SecondaryFilterData(name: 'Table 3', code: 'table_3'),
      ],
    ),
    FilterData(
      name: 'Depth',
      code: 'depth',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Depth 1', code: 'depth_1'),
        SecondaryFilterData(name: 'Depth 2', code: 'depth_2'),
        SecondaryFilterData(name: 'Depth 3', code: 'depth_3'),
      ],
    ),
    FilterData(
      name: 'Measurement (LWD)',
      code: 'measurement',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Measurement 1', code: 'measurement_1'),
        SecondaryFilterData(name: 'Measurement 2', code: 'measurement_2'),
        SecondaryFilterData(name: 'Measurement 3', code: 'measurement_3'),
      ],
    ),
    FilterData(
      name: 'Grading',
      code: 'grading',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Grading 1', code: 'grading_1'),
        SecondaryFilterData(name: 'Grading 2', code: 'grading_2'),
        SecondaryFilterData(name: 'Grading 3', code: 'grading_3'),
      ],
    ),
    FilterData(
      name: 'Key to Symbol',
      code: 'key_to_symbol',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Key to Symbol 1', code: 'key_to_symbol_1'),
        SecondaryFilterData(name: 'Key to Symbol 2', code: 'key_to_symbol_2'),
        SecondaryFilterData(name: 'Key to Symbol 3', code: 'key_to_symbol_3'),
      ],
    ),
    FilterData(
      name: 'Inclusions',
      code: 'inclusions',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Inclusions 1', code: 'inclusions_1'),
        SecondaryFilterData(name: 'Inclusions 2', code: 'inclusions_2'),
        SecondaryFilterData(name: 'Inclusions 3', code: 'inclusions_3'),
      ],
    ),
    FilterData(
      name: 'Other',
      code: 'other',
      secondaryFilterData: [
        SecondaryFilterData(name: 'Other 1', code: 'other_1'),
        SecondaryFilterData(name: 'Other 2', code: 'other_2'),
        SecondaryFilterData(name: 'Other 3', code: 'other_3'),
      ],
    ),
  ];

  late FilterData selectedFilterData = filterData.first;
  List<SecondaryFilterData> secondaryFilterDataDisplay = [];

  final TextEditingController searchController = TextEditingController();

  void searchChange() {
    add(SearchDiamondFilterDataEvent(searchQuery: searchController.text));
  }

  void _onLoadDiamondFilterDataEvent(LoadDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    searchController.addListener(searchChange);
    emit(DiamondFilterDataLoadedState(filterData));
  }

  void _onSelectDiamondFilterDataEvent(SelectDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    if (selectedFilterData != event.filterData) {
      emit(DiamondFilterReloadState());
      selectedFilterData = event.filterData;
      searchController.text = '';
      add(const SearchDiamondFilterDataEvent(searchQuery: ''));
      emit(DiamondFilterDataSelectedState(selectedFilterData));
    }
  }

  void _onSelectSecondaryDiamondFilterDataEvent(SelectSecondaryDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    final int index = (selectedFilterData.secondaryFilterData ?? []).indexWhere((element) => element == event.secondaryFilterData);
    if (index != -1) {
      selectedFilterData.secondaryFilterData?[index].isSelected = !selectedFilterData.secondaryFilterData![index].isSelected;
      emit(SelectSecondaryDiamondFilterDataState(selectedFilterData.secondaryFilterData![index]));
    }
  }

  void _onSearchDiamondFilterDataEvent(SearchDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    emit(DiamondFilterReloadState());
    secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    if (searchController.text.isNotEmpty) {
      secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData!
          .where((element) => (element.name ?? '').toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    }
    emit(SearchDiamondFilterDataState(secondaryFilterDataDisplay));
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
    secondaryFilterDataDisplay = selectedFilterData.secondaryFilterData ?? [];
    emit(DiamondFilterDataSelectedState(selectedFilterData));
  }

  void _onApplyDiamondFilterDataEvent(ApplyDiamondFilterDataEvent event, Emitter<DiamondFilterState> emit) {
    //TODO: Implement ApplyDiamondFilterDataEvent
  }
}
