import 'package:kgk/kgk.dart';

part 'pdd_listing_event.dart';

part 'pdd_listing_state.dart';

class PddListingBloc extends Bloc<PddListingEvent, PddListingState> {
  bool isGrid = true;
  final TextEditingController presentationSearchController = TextEditingController();
  List<B2BCustomListingDataModel> filteredPresentationList = _generatePresentationList();
  List<B2BCustomListingDataModel> originalPresentationList = _generatePresentationList();

  //Pagination controller
  SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  PddListingBloc() : super(PddListingInitial()) {
    on<InitialPddListingEvent>(_onInitialPresentationListEvent);
    on<PresentationChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<FilterPresentationEvent>(_onFilterPresentationEvent);
    on<NavigateToPddPreviewEvent>(_navigateToPreview);
    on<PddListLoadMoreEvent>(_onPddListLoadMoreEvent);
    on<PddListPullToRefreshEvent>(_onPddListPullToRefresh);
  }

  void _onInitialPresentationListEvent(InitialPddListingEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    if (gridPaginationScrollController.isInitialised) {
      gridPaginationScrollController.dispose();
      gridPaginationScrollController = SmartPaginationScrollController();
    }
    gridPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(PddListLoadMoreEvent(currentPage));
      },
    );

    filteredPresentationList = _generatePresentationList();

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }
    clearData();
    emit(PddListingLoadedState());
  }

  void _onChangeListingTypeEvent(PresentationChangeListingTypeEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    isGrid = event.isGrid;
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
  }

  void _navigateToPreview(NavigateToPddPreviewEvent event, Emitter<PddListingState> emit) {
    final presentationNumber = filteredPresentationList[event.index].strPresentationNumber;
    event.context.pushNamed(AppRoutes.presentationPreviewPage, arguments: {
      RoutesData.presentationId: presentationNumber,
    });
  }

  Future<void> _onPddListLoadMoreEvent(PddListLoadMoreEvent event, Emitter<PddListingState> emit) async {
    emit(const PddListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    filteredPresentationList.addAll(_generatePresentationList());
    gridPaginationScrollController.isPageLoaded.complete(event.currentPage == 4);
    emit(PddListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onPddListPullToRefresh(PddListPullToRefreshEvent event, Emitter<PddListingState> emit) async {
    emit(PddListingReloadState());
    gridPaginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    originalPresentationList = _generatePresentationList();
    refreshCompleter.complete(true);
    emit(PddListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const PddListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }

  static List<B2BCustomListingDataModel> _generatePresentationList() {
    return List.generate(20, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '125487${index + 1}',
        strProject: '1',
        strConceptName: 'Full blue moon',
        status: index % 2 == 0 ? ProjectStatus.blueInProgress : ProjectStatus.approved,
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023, 10:46',
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
