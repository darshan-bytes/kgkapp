import 'package:kgk/kgk.dart';

part 'design_briefs_event.dart';

part 'design_briefs_state.dart';

class DesignBriefsBloc extends Bloc<DesignBriefsEvent, DesignBriefsState> {
  final TextEditingController designBriefsSearchController = TextEditingController();

  List<B2BCustomListingDataModel> filteredDesignBriefsList = _generateDesignBriefsList();

  DesignBriefsBloc() : super(DesignBriefsInitial()) {
    on<InitialDesignBriefsEvent>(_onInitialDesignBriefsEvent);
    on<FilterDesignBriefsEvent>(_onFilterDesignBriefsEvent);
  }

  void _onInitialDesignBriefsEvent(InitialDesignBriefsEvent event, Emitter<DesignBriefsState> emit) {
    emit(DesignBriefsReloadState());
    clearData();
    emit(DesignBriefsLoadedState());
  }

  void _onFilterDesignBriefsEvent(FilterDesignBriefsEvent event, Emitter<DesignBriefsState> emit) {
    emit(DesignBriefsReloadState());
    final searchText = designBriefsSearchController.text.toLowerCase();
    filteredDesignBriefsList =
        _generateDesignBriefsList().where((element) => (element.strProjectNumber ?? '').toLowerCase().contains(searchText)).toList();
    emit(FilterDesignBriefsState());
  }

  void clearData() {
    designBriefsSearchController.clear();
    filteredDesignBriefsList = _generateDesignBriefsList();
  }

  static List<B2BCustomListingDataModel> _generateDesignBriefsList() {
    return List.generate(20, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strDbfNumber: 'DBF-000012',
        status: OrderStatus.active,
        strJewelleryType: 'Earring',
        strSubJewelleryType: 'Diamond earring',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strCreatedOn: '23/03/2023',
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        holdStatus: OrderStatus.inProgress,
      );
    });
  }
}
