import 'package:kgk/kgk.dart';

part 'design_listing_event.dart';

part 'design_listing_state.dart';

class DesignListingBloc extends Bloc<DesignListingEvent, DesignListingState> {
  //Controller for grid
  bool isGrid = true;

  //Controller for search
  final TextEditingController designSearchController = TextEditingController();

  //List of designs
  List<B2BCustomListingDataModel> designListForGrid = _generateDesignListForGrid();
  List<StyleDesignModel> designList = _generateDesignNewList();

  //Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  DesignListingBloc() : super(const DesignListingInitial()) {
    on<InitialDesignListingEvent>(_onInitialDesignListEvent);
    on<DesignListLoadMoreEvent>(_onDesignListLoadMoreEvent);
    on<DesignChangeListingTypeEvent>(_onDesignChangeListingTypeEvent);
    on<DesignListPullToRefreshEvent>(_onDesignListPullToRefresh);
  }

  void _onInitialDesignListEvent(InitialDesignListingEvent event, Emitter<DesignListingState> emit) {
    emit(const DesignListingLoadingState());

    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }

    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(DesignListLoadMoreEvent(currentPage));
      },
    );

    refreshCompleter.complete(true);

    clearData();
    emit(const DesignListingLoadedState());
  }

  void clearData() {
    isGrid = true;
    designSearchController.clear();
    designList.clear();
    designListForGrid.clear();
    designList.addAll(_generateDesignNewList());
    designListForGrid.addAll(_generateDesignList());
  }

  Future<void> _onDesignListLoadMoreEvent(DesignListLoadMoreEvent event, Emitter<DesignListingState> emit) async {
    emit(const DesignListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    designList.addAll(_generateDesignNewList());
    designListForGrid.addAll(_generateDesignListForGrid());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 4);
    emit(DesignListLoadedMoreState(event.currentPage + 1));
  }

  void _onDesignChangeListingTypeEvent(DesignChangeListingTypeEvent event, Emitter<DesignListingState> emit) {
    emit(DesignListingReloadState());
    isGrid = event.isGrid;
    emit(const DesignChangeListingTypeState());
  }

  @override
  Future<void> close() {
    designSearchController.dispose();
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generateDesignList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strDesignListingImageUrl: "https://i.ibb.co/zVdCtQr/Image.png",
        strVersion: "3",
        strDesignNumber: 'DERS28MOVR',
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strCreatedOn: '23/03/2023, 10:46',
        designApprovalStatus: ProjectStatus.approval,
        stylesStatus: ProjectStatus.styleCreated,
        strDbfNumber: 'DBF-000013',
      );
    });
  }

  static List<StyleDesignModel> _generateDesignNewList() {
    return List.generate(10, (index) {
      return StyleDesignModel(
        id: index.toString(),
        designId: "903405",
        numberOfProduct: "3",
        styleId: "01AA6545",
        productName: "Ring",
        productImageUrl: 'https://i.ibb.co/HgjT1rt/Image.png',
        userImageUrl: "https://i.ibb.co/1Lq3YpF/Frame-3977.png",
        userName: "John",
        diamondType: "Diamond classic",
        diamondShape: "Moncao",
        status: ProjectStatus.onHold,
        firstType: "M",
        secondType: "D",
        thirdType: "C",
        firstGram: "18K/0.75 g",
        secondGram: "0.167cts/3",
        thirdGram: "0.54/2",
      );
    });
  }

  static List<B2BCustomListingDataModel> _generateDesignListForGrid() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strDesignListingImageUrl: index % 2 == 0 ? "https://i.ibb.co/p1wthJ3/Image9.png" : "https://i.ibb.co/267TzXF/Image98.png",
        strVersion: "3",
        strDesignNumber: 'DERS28MOVR',
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
        strCreatedOn: '23/03/2023, 10:46',
        designApprovalStatus: index % 2 == 0 ? null : ProjectStatus.styleCreated,
        strDbfNumber: 'DBF-000013',
      );
    });
  }

  Future<void> _onDesignListPullToRefresh(DesignListPullToRefreshEvent event, Emitter<DesignListingState> emit) async {
    emit(DesignListingReloadState());
    await Future.delayed(const Duration(seconds: 1));
    paginationScrollController.pullToRefresh();
    designList = _generateDesignNewList();
    designListForGrid = _generateDesignListForGrid();
    refreshCompleter.complete(true);
    emit(const DesignListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const DesignListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
