import 'package:kgk/kgk.dart';

part 'cad_library_listing_state.dart';

part 'cad_library_listing_event.dart';

class CadLibraryListingBloc extends Bloc<CadLibraryListingEvent, CadLibraryListingState> {
  //Controller for grid
  bool isGrid = true;

  //List of cad library
  List<B2BCustomListingDataModel> cadList = _generateCadList();

  //Pagination controller
  SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();

  CadLibraryListingBloc() : super(CadListingInitial()) {
    on<InitialCadListingEvent>(_onInitialCadLibraryListEvent);
    on<CadListLoadMoreEvent>(_onCadListLoadMoreEvent);
    on<CadChangeListingTypeEvent>(_onCadChangeListingTypeEvent);
  }

  void _onInitialCadLibraryListEvent(InitialCadListingEvent event, Emitter<CadLibraryListingState> emit) {
    gridPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(CadListLoadMoreEvent(currentPage));
      },
    );

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
        strCADLibraryImageUrl: "https://i.ibb.co/LghRtxf/Image.png",
        strCADLibraryNumber: 'CG-0288-23/04',
        strCADLibraryProductName: 'Diamond Vine Ring in 18k Rose Gold',
      );
    });
  }
}
