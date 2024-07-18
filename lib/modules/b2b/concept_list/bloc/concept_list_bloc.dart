import 'package:kgk/kgk.dart';

part 'concept_list_event.dart';

part 'concept_list_state.dart';

class ConceptListBloc extends Bloc<ConceptListEvent, ConceptListState> {
  List<B2BCustomListingDataModel> conceptList = [];
  TextEditingController searchController = TextEditingController();
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  ConceptListBloc() : super(ConceptListInitial()) {
    on<ConceptListInitialEvent>(_onConceptListInitialEvent);
    on<ConceptListSearchEvent>(_onConceptListSearchEvent);
    on<ConceptListLoadMoreEvent>(_onConceptListLoadMoreEvent);
    on<ConceptListPullToRefreshEvent>(_onConceptListingPullToRefresh);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onConceptListInitialEvent(ConceptListInitialEvent event, Emitter<ConceptListState> emit) async {
    emit(ConceptListReloadState());
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    searchController.clear();
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ConceptListLoadMoreEvent(currentPage));
      },
    );
    conceptList = List.generate(
      20,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strConceptNumber: (index + 1).toString(),
        strPresentation: '1',
        strConceptName: 'Concept Name',
        status: ProjectStatus.blueInProgress,
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strMarket: 'New York, USA',
        strMarketFlagImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023, 10:46',
      ),
    );

    refreshCompleter.complete(true);
    emit(const ConceptListLoadedState());
  }

  void _onConceptListSearchEvent(ConceptListSearchEvent event, Emitter<ConceptListState> emit) {
    //TODO: Implement search logic
  }

  Future<void> _onConceptListLoadMoreEvent(ConceptListLoadMoreEvent event, Emitter<ConceptListState> emit) async {
    emit(const ConceptListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    conceptList.addAll(
      List.generate(
        10,
        (index) => B2BCustomListingDataModel(
          id: index.toString(),
          strConceptNumber: ((paginationScrollController.currentPage * 10) + index + 1).toString(),
          strPresentation: '1',
          strConceptName: 'Concept Name',
          status: ProjectStatus.blueInProgress,
          strAssignTo: 'Jenny Wilson',
          strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
          strMarket: 'New York, USA',
          strMarketFlagImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
          strCreatedBy: 'Jenny Wilson',
          strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
          strCreatedOn: '23/03/2023, 10:46',
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(ConceptListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onConceptListingPullToRefresh(ConceptListPullToRefreshEvent event, Emitter<ConceptListState> emit) async {
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    conceptList = List.generate(
      10,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strConceptNumber: (index + 1).toString(),
        strPresentation: '1',
        strConceptName: 'Concept Name',
        status: ProjectStatus.blueInProgress,
        strAssignTo: 'Jenny Wilson',
        strAssignToImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strMarket: 'New York, USA',
        strMarketFlagImageUrl: 'https://i.ibb.co/wYmW2ht/United-States-of-America-US.png',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: '23/03/2023, 10:46',
      ),
    );
    refreshCompleter.complete(true);
    emit(const ConceptListLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const ConceptListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
