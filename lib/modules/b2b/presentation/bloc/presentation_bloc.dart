import 'package:kgk/kgk.dart';

part 'presentation_event.dart';

part 'presentation_state.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
  // Controller for search
  final TextEditingController presentationSearchController = TextEditingController();

  // List of Presentation
  List<B2BCustomListingDataModel> presentationList = [];

  // Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  PresentationBloc() : super(PresentationInitial()) {
    on<InitialPresentationEvent>(_onInitialPresentationEvent);
    on<PresentationLoadMoreEvent>(_onPresentationLoadMoreEvent);
    on<PresentationPullToRefreshEvent>(_onPresentationPullToRefreshEvent);
  }

  void _onInitialPresentationEvent(InitialPresentationEvent event, Emitter<PresentationState> emit) {
    emit(PresentationListReloadState());
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    presentationList = _generatePresentationList();

    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }

    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(PresentationLoadMoreEvent(currentPage));
      },
    );
    clearData();
    refreshCompleter.complete(true);
    emit(PresentationLoadedState());
  }

  Future<void> _onPresentationLoadMoreEvent(PresentationLoadMoreEvent event, Emitter<PresentationState> emit) async {
    emit(const PresentationListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    presentationList.addAll(_generatePresentationList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 5);
    emit(PresentationListLoadedMoreState(event.currentPage + 1));
  }

  void clearData() {
    presentationSearchController.clear();
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generatePresentationList() {
    return List.generate(8, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strPresentationNumber: '1254875',
        strProject: "1",
        strConceptNumber: "14567",
        strConceptName: "Full blue moon",
        strCreatedBy: "Stephen Parker",
        strCreatedByImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCreatedOn: "23/03/2023, 10:46",
        strAssignToImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strAssignTo: "Jenny Wilson",
        strApprovedBy: "Jenny Wilson",
        strApprovedByImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        status: ProjectStatus.blueInProgress,
      );
    });
  }

  Future<void> _onPresentationPullToRefreshEvent(PresentationPullToRefreshEvent event, Emitter<PresentationState> emit) async {
    emit(PresentationListReloadState());
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    presentationList = _generatePresentationList();
    refreshCompleter.complete(true);
    emit(PresentationLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const PresentationPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
