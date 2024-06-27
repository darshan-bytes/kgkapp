import 'package:kgk/kgk.dart';

part 'pdd_listing_event.dart';

part 'pdd_listing_state.dart';

class PddListingBloc extends Bloc<PddListingEvent, PddListingState> {
  bool isGrid = true;

  final TextEditingController presentationSearchController = TextEditingController();

  List<B2BCustomListingDataModel> filteredPresentationList = _generatePresentationList();
  List<B2BCustomListingDataModel> originalPresentationList = _generatePresentationList();

  PddListingBloc() : super(PddListingInitial()) {
    on<InitialPddListingEvent>(_onInitialPresentationListEvent);
    on<PresentationChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<FilterPresentationEvent>(_onFilterPresentationEvent);
  }

  void _onInitialPresentationListEvent(InitialPddListingEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    clearData();
    emit(PddListingLoadedState());
  }

  void _onChangeListingTypeEvent(PresentationChangeListingTypeEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    isGrid = !isGrid;
    emit(PddListingChangeListingTypeState());
  }

  void _onFilterPresentationEvent(FilterPresentationEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    final searchText = presentationSearchController.text.toLowerCase();
    filteredPresentationList =
        originalPresentationList.where((element) => (element.strPresentationNumber ?? '').toLowerCase().contains(searchText)).toList();
    emit(FilterPresentationState());
  }

  void clearData() {
    isGrid = true;
    presentationSearchController.clear();
    filteredPresentationList = _generatePresentationList();
  }

  // If a presentation grid is required with date information, ensure the `strConceptNumber` fields are filled
  static List<B2BCustomListingDataModel> _generatePresentationList() {
    return List.generate(20, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '1254875',
        strProject: '1',
        strConceptName: 'Full blue moon',
        status: ProjectStatus.active,
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023',
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strApprovedBy: 'John Samanta',
        strApprovedByImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
        strConceptNumber: "14567",
        strPresentationImageUrl: "https://i.ibb.co/Mk80hVc/Image.png",
      );
    });
  }
}
