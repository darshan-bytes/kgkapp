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
    if (presentationSearchController.text.isNotEmpty) {
      filteredPresentationList = originalPresentationList
          .where((B2BCustomListingDataModel element) =>
              (element.strPresentationNumber ?? '').toLowerCase().contains(presentationSearchController.text.toLowerCase()))
          .toList();
    } else {
      filteredPresentationList = _generatePresentationList();
    }
    emit(FilterPresentationState());
  }

  void clearData() {
    presentationSearchController.clear();
    filteredPresentationList = _generatePresentationList();
    isGrid = true;
  }

  static List<B2BCustomListingDataModel> _generatePresentationList() {
    return List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '1254875',
        strProject: '1',
        strConceptName: 'Full blue moon',
        status: OrderStatus.active,
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023, 10:46',
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strApprovedBy: 'John Samanta',
        strApprovedByImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
      ),
    );
  }
}
