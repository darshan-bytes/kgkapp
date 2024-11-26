import 'package:kgk/kgk.dart';

part 'cad_library_listing_state.dart';

part 'cad_library_listing_event.dart';

class CadLibraryListingBloc extends Bloc<CadLibraryListingEvent, CadLibraryListingState> {
  UserType userType = UserType.b2cUser;
  bool isGrid = true;
  List<B2BCustomListingDataModel> cadList = [];
  int? totalNumberOfPages;
  final TextEditingController cadLibrarySearchController = TextEditingController();
  final SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  CadLibraryListingBloc() : super(CadListingInitial()) {
    on<InitialCadListingEvent>(_onInitialCadLibraryListEvent);
    on<CadListLoadMoreEvent>(_onCadListLoadMoreEvent);
    on<CadChangeListingTypeEvent>(_onCadChangeListingTypeEvent);
    on<CadListPullToRefreshEvent>(_onCadListPullToRefresh);
  }

  Future<void> _onInitialCadLibraryListEvent(InitialCadListingEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(CadListingReloadState());
    clearData();
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    gridPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(CadListLoadMoreEvent(event.context, currentPage));
      },
    );
    await _callCadLibraryListingApi(context: event.context, isLoadMore: true);
    emit(CadListingLoadedState());
  }

  Future<void> _callCadLibraryListingApi({required BuildContext context, bool isLoadMore = false}) async {
    final Map<String, dynamic> params = {
      ApiKey.limit: AppConst.pageLimit50,
      ApiKey.page: gridPaginationScrollController.currentPage,
    };
    Either<ErrorResponse, PaginationData<CadLibraryListItemDataModel>>? response =
        await AppRepository(context).getCadLibraryList(query: params, isLoadMore: isLoadMore);

    response?.fold((error) {
      if (error.message.isNotNullNorEmpty) {
        Utils.showMessage(error.message);
      }
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit);
      final localList = success.dataList ?? [];
      cadList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e)).toList());
    });
    gridPaginationScrollController.isPageLoaded.complete(gridPaginationScrollController.currentPage == totalNumberOfPages);
  }

  B2BCustomListingDataModel convertToB2BCustomListingDataModel({required CadLibraryListItemDataModel sourceModel}) {
    return B2BCustomListingDataModel(
      id: sourceModel.sId,
      strCADLibraryImageUrl: (sourceModel.images).isNotNullNorEmpty ? sourceModel.images?.first : '',
      strCADLibraryNumber: sourceModel.designCreatedDt,
      strCADLibraryProductName: sourceModel.kgkCollectionName,
    );
  }

  Future<void> _onCadListLoadMoreEvent(CadListLoadMoreEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    await _callCadLibraryListingApi(context: event.context);
    emit(CadListLoadedMoreState());
  }

  void _onCadChangeListingTypeEvent(CadChangeListingTypeEvent event, Emitter<CadLibraryListingState> emit) {
    emit(CadListingReloadState());
    isGrid = event.isGrid;
    emit(const CadChangeListingTypeState());
  }

  Future<void> _onCadListPullToRefresh(CadListPullToRefreshEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(CadListingReloadState());
    gridPaginationScrollController.pullToRefresh();
    cadList.clear();
    await _callCadLibraryListingApi(context: event.context, isLoadMore: true);
    refreshCompleter.complete(true);
    emit(CadListingLoadedState());
  }

  Future<bool> pullToRefresh({required BuildContext context}) async {
    refreshCompleter = Completer<bool>();
    add(CadListPullToRefreshEvent(context: context));
    return refreshCompleter.future;
  }

  void clearData() {
    isGrid = true;
    cadList.clear();
  }

  @override
  Future<void> close() {
    cadLibrarySearchController.dispose();
    gridPaginationScrollController.dispose();
    return super.close();
  }
}
