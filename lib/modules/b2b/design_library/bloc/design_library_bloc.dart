import 'package:kgk/kgk.dart';

part 'design_library_event.dart';

part 'design_library_state.dart';

class DesignLibraryBloc extends Bloc<DesignLibraryEvent, DesignLibraryState> {
  /// The type of user, defaults to B2C user.
  UserType userType = UserType.b2cUser;

  /// Determines if the view is in grid mode; defaults to true.
  bool isGrid = true;

  /// List to hold the design library data.
  List<B2BCustomListingDataModel> designLibraryList = [];

  /// The total number of pages for pagination.
  int? totalNumberOfPages;

  /// Controller for handling search input in the design library.
  final TextEditingController designSearchController = TextEditingController();

  /// Controller to manage pagination and loading of more items.
  final SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// Completer to handle pull-to-refresh actions.
  Completer<bool> refreshCompleter = Completer<bool>();

  String sortKey = AppConst.sortKeyNERPBS;
  String sortValue = AppConst.sortValueDesc;

  List<SortOptions> sortOptions = [];

  DesignLibraryBloc() : super(const DesignLibraryInitial()) {
    on<DesignLibraryInitialEvent>(_onDesignLibraryInitialEvent);
    on<DesignLibraryLoadMoreEvent>(_onDesignLibraryLoadMoreEvent);
    on<DesignLibraryChangeListingTypeEvent>(_onDesignLibraryChangeListingTypeEvent);
    on<DesignLibraryPullToRefreshEvent>(_onDesignLibraryPullToRefresh);
  }

  /// Handles the initialization of the design library.
  Future<void> _onDesignLibraryInitialEvent(DesignLibraryInitialEvent event, Emitter<DesignLibraryState> emit) async {
    emit(const DesignLibraryReloadState());
    clearData();
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    sortOptions = await StorageManager().getSortingList(Commodity.designLibrary.value);
    await _initializeSortOptions();

    /// Initializes the pagination controller with a load action.
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(DesignLibraryLoadMoreEvent(context: event.context, currentPage: currentPage));
      },
    );

    await _callDesignLibraryApi(context: event.context);
    emit(const DesignLibraryLoadedState());
  }

  Future<void> _initializeSortOptions() async {
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.cadLibrary.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  /// Fetches data from the design library API.
  Future<void> _callDesignLibraryApi({required BuildContext context}) async {
    final Map<String, dynamic> params = {
      ApiKey.limit: AppConst.pageLimit,
      ApiKey.page: paginationScrollController.currentPage,
      ApiKey.sortKey: AppConst.sortKeyNERPBS,
      ApiKey.sortValue: AppConst.sortValueDesc
    };

    /// Makes the API request and handles the response.
    Either<ErrorResponse, PaginationData<DesignLibraryListItemDataModel>>? response =
        await AppRepository(context).getDesignLibraryList(query: params);

    response?.fold((error) {
      if (error.message.isNotNullNorEmpty) {
        Utils.showMessage(error.message);
      }
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final localList = success.dataList ?? [];
      designLibraryList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e)).toList());
    });
    paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
  }

  /// Converts API response data to the custom listing data model.
  B2BCustomListingDataModel convertToB2BCustomListingDataModel({required DesignLibraryListItemDataModel sourceModel}) {
    return B2BCustomListingDataModel(
      id: sourceModel.sId,
      strDesignListingImageUrl: (sourceModel.images).isNotNullNorEmpty ? sourceModel.images?.first : '',
      strDesignNumber: sourceModel.contractNoSkuNo,
      strDbfNumber: sourceModel.designDescription,
    );
  }

  /// Handles loading more items in the design library.
  Future<void> _onDesignLibraryLoadMoreEvent(DesignLibraryLoadMoreEvent event, Emitter<DesignLibraryState> emit) async {
    emit(const DesignLibraryLoadingMoreState());
    await _callDesignLibraryApi(context: event.context);
    emit(DesignLibraryLoadedMoreState());
  }

  /// Handles changing the listing view type (grid or list).
  void _onDesignLibraryChangeListingTypeEvent(DesignLibraryChangeListingTypeEvent event, Emitter<DesignLibraryState> emit) {
    emit(const DesignLibraryReloadState());
    isGrid = event.isGrid;
    emit(const DesignLibraryChangeListingTypeState());
  }

  /// Handles pull-to-refresh functionality to reload data.
  Future<void> _onDesignLibraryPullToRefresh(DesignLibraryPullToRefreshEvent event, Emitter<DesignLibraryState> emit) async {
    emit(const DesignLibraryReloadState());
    paginationScrollController.pullToRefresh();
    designLibraryList.clear();
    await _callDesignLibraryApi(context: event.context);
    refreshCompleter.complete(true);
    emit(const DesignLibraryLoadedState());
  }

  /// Triggers the pull-to-refresh action and waits for completion.
  Future<bool> pullToRefresh({required BuildContext context}) async {
    refreshCompleter = Completer<bool>();
    add(DesignLibraryPullToRefreshEvent(context: context));
    return refreshCompleter.future;
  }

  /// Clears all data and resets the grid view.
  void clearData() {
    isGrid = true;
    designLibraryList.clear();
  }

  /// Disposes resources when the bloc is closed.
  @override
  Future<void> close() {
    designSearchController.dispose();
    paginationScrollController.dispose();
    return super.close();
  }
}
