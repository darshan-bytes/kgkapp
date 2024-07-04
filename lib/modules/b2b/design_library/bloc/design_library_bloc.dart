import 'package:kgk/kgk.dart';

part 'design_library_event.dart';

part 'design_library_state.dart';

class DesignLibraryBloc extends Bloc<DesignLibraryEvent, DesignLibraryState> {
  bool isGrid = true;
  List<B2BCustomListingDataModel> designLibraryList = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  DesignLibraryBloc() : super(const DesignLibraryInitial()) {
    on<DesignLibraryInitialEvent>(_onDesignLibraryInitialEvent);
    on<DesignLibraryChangeListingTypeEvent>(_onDesignLibraryChangeListingTypeEvent);
    on<DesignLibraryLoadMoreEvent>(_onDesignLibraryLoadMoreEvent);
  }

  void _onDesignLibraryInitialEvent(DesignLibraryInitialEvent event, Emitter<DesignLibraryState> emit) {
    emit(const DesignLibraryReloadState());
    isGrid = true;
    designLibraryList.clear();
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(DesignLibraryLoadMoreEvent(currentPage));
      },
    );

    designLibraryList.addAll(_generateLibraryList());
    emit(const DesignLibraryLoadedState());
  }

  void _onDesignLibraryChangeListingTypeEvent(DesignLibraryChangeListingTypeEvent event, Emitter<DesignLibraryState> emit) {
    emit(const DesignLibraryReloadState());
    isGrid = event.isGrid;
    paginationScrollController.onViewChange(!isGrid);
    emit(const DesignLibraryChangeListingTypeState());
  }

  Future<void> _onDesignLibraryLoadMoreEvent(DesignLibraryLoadMoreEvent event, Emitter<DesignLibraryState> emit) async {
    emit(const DesignLibraryLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    designLibraryList.addAll(_generateLibraryList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(DesignLibraryLoadedMoreState(event.currentPage + 1));
  }

  static List<B2BCustomListingDataModel> _generateLibraryList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strDesignListingImageUrl: index % 2 == 0 ? "https://i.ibb.co/xFPzy0g/Image.png" : "https://i.ibb.co/5WKSs6T/Image.png",
        strDesignNumber: 'DERS28MOVR',
        strDbfNumber: 'DBF-000013',
        strSalesmanImageUrl: index % 2 == 0 ? "https://i.ibb.co/BLyLVHS/Frame-3978.png" : "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strSalesman: 'John Samanta',
        designApprovalStatus: index % 3 == 0 ? ProjectStatus.styleCreated : null,
      );
    });
  }
}
