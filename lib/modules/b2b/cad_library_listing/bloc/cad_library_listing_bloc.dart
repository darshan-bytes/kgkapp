import 'package:kgk/kgk.dart';

part 'cad_library_listing_state.dart';

part 'cad_library_listing_event.dart';

class CadLibraryListingBloc extends Bloc<CadLibraryListingEvent, CadLibraryListingState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  //Controller for grid
  bool isGrid = true;

  //List of cad library
  List<B2BCustomListingDataModel> cadList = _generateCadList();

  final TextEditingController cadLibrarySearchController = TextEditingController();

  //Pagination controller
  SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  CadLibraryListingBloc() : super(CadListingInitial()) {
    on<InitialCadListingEvent>(_onInitialCadLibraryListEvent);
    on<CadListLoadMoreEvent>(_onCadListLoadMoreEvent);
    on<CadChangeListingTypeEvent>(_onCadChangeListingTypeEvent);
    on<CadListPullToRefreshEvent>(_onCadListPullToRefresh);
  }

  void _onInitialCadLibraryListEvent(InitialCadListingEvent event, Emitter<CadLibraryListingState> emit) {
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    if (gridPaginationScrollController.isInitialised) {
      gridPaginationScrollController.dispose();
      gridPaginationScrollController = SmartPaginationScrollController();
    }
    gridPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(CadListLoadMoreEvent(currentPage));
      },
    );

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }
    clearData();
    emit(CadListingLoadedState());
  }

  void clearData() {
    isGrid = true;
    cadList = _generateCadList();
  }

  Future<void> _onCadListLoadMoreEvent(CadListLoadMoreEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    cadList.addAll(_generateCadList());
    gridPaginationScrollController.isPageLoaded.complete(event.currentPage == 4);

    emit(CadListLoadedMoreState(event.currentPage + 1));
  }

  void _onCadChangeListingTypeEvent(CadChangeListingTypeEvent event, Emitter<CadLibraryListingState> emit) {
    emit(CadListingReloadState());
    isGrid = event.isGrid;
    emit(const CadChangeListingTypeState());
  }

  @override
  Future<void> close() {
    gridPaginationScrollController.dispose();

    return super.close();
  }

  static List<B2BCustomListingDataModel> _generateCadList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strCADLibraryImageUrl: index % 2 == 0 ? "https://i.ibb.co/LghRtxf/Image.png" : "https://i.ibb.co/FVHfPPB/cad.png",
        strCADLibraryNumber: 'CG-0288-23/04',
        strCADLibraryProductName: 'Diamond Vine Ring in 18k Rose Gold',
      );
    });
  }

  Future<void> _onCadListPullToRefresh(CadListPullToRefreshEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(CadListingReloadState());
    gridPaginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    cadList = _generateCadList();
    refreshCompleter.complete(true);
    emit(CadListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const CadListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
