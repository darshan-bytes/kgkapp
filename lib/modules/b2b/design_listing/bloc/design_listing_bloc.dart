import 'package:kgk/kgk.dart';

part 'design_listing_event.dart';

part 'design_listing_state.dart';

class DesignListingBloc extends Bloc<DesignListingEvent, DesignListingState> {
  //Controller for grid
  bool isGrid = true;

  //Controller for search
  final TextEditingController designSearchController = TextEditingController();

  //List of designs
  List<B2BCustomListingDataModel> designList = _generateDesignList();

  //Pagination controller
  SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController listPaginationScrollController = SmartPaginationScrollController();

  DesignListingBloc() : super(const DesignListingInitial()) {
    on<InitialDesignListingEvent>(_onInitialDesignListEvent);
    on<DesignListLoadMoreEvent>(_onDesignListLoadMoreEvent);
    on<DesignChangeListingTypeEvent>(_onDesignChangeListingTypeEvent);
  }

  void _onInitialDesignListEvent(InitialDesignListingEvent event, Emitter<DesignListingState> emit) {
    emit(const DesignListingLoadingState());
    gridPaginationScrollController.init(
      loadAction: (int currentPage) async {
        add(DesignListLoadMoreEvent(currentPage));
      },
    );
    listPaginationScrollController.init(
      loadAction: (int currentPage) async {
        add(DesignListLoadMoreEvent(currentPage));
      },
    );

    clearData();
    emit(const DesignListingLoadedState());
  }

  void clearData() {
    isGrid = true;
    designSearchController.clear();
    designList.clear();
    designList.addAll(_generateDesignList());
  }

  Future<void> _onDesignListLoadMoreEvent(DesignListLoadMoreEvent event, Emitter<DesignListingState> emit) async {
    emit(const DesignListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    designList.addAll(_generateDesignList());
    if (isGrid) {
      gridPaginationScrollController.isPageLoaded.complete(event.currentPage == 4);
      emit(DesignListLoadedMoreState(event.currentPage + 1));
    } else {
      listPaginationScrollController.isPageLoaded.complete(event.currentPage == 4);
      emit(DesignListLoadedMoreState(event.currentPage + 1));
    }
  }

  void _onDesignChangeListingTypeEvent(DesignChangeListingTypeEvent event, Emitter<DesignListingState> emit) {
    emit(DesignListingReloadState());
    isGrid = event.isGrid;
    emit(const DesignChangeListingTypeState());
  }

  @override
  Future<void> close() {
    designSearchController.dispose();
    gridPaginationScrollController.dispose();
    listPaginationScrollController.dispose();
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
}
