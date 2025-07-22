import 'package:kgk/kgk.dart';

part 'cad_library_listing_state.dart';

part 'cad_library_listing_event.dart';

class CadLibraryListingBloc extends Bloc<CadLibraryListingEvent, CadLibraryListingState> {
  late AppBloc _appBloc;
  UserType userType = UserType.b2cUser;
  bool isGrid = true;
  String appBarTitle = '';
  List<B2BCustomListingDataModel> cadList = [];
  int? totalNumberOfPages;
  int? totalFilteredRecords;
  final TextEditingController cadLibrarySearchController = TextEditingController();
  final SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();
  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForLibraryCAD;

  String sortKey = AppConst.sortKeyNERPBS;
  String sortValue = AppConst.sortValueDesc;

  List<SortOptions> sortOptions = [];

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  CadLibraryListingBloc() : super(CadListingInitial()) {
    on<InitialCadListingEvent>(_onInitialCadLibraryListEvent);
    on<CadListLoadMoreEvent>(_onCadListLoadMoreEvent);
    on<CadChangeListingTypeEvent>(_onCadChangeListingTypeEvent);
    on<CadListPullToRefreshEvent>(_onCadListPullToRefresh);
    on<CadSortEvent>(_onCadSortEvent);
    on<CadLibraryFilterEvent>(_onCadLibraryFilterEvent);
  }

  Future<void> _onInitialCadLibraryListEvent(InitialCadListingEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListingReloadState());
    clearData();
    _appBloc = BlocProvider.of<AppBloc>(event.context);
    userType = _appBloc.userType;
    getRouteData(event.context);
    emit(const CadAppBarTitleChangedState());
    await _initializeSortOptions(event.context);
    gridPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(CadListLoadMoreEvent(event.context, currentPage));
      },
    );
    if (filterData.isEmpty) {
      await _setupFilters(event.context);
    }
    if (screenIdentifier == ScreenIdentifier.productForLibraryStyle) {
      await _callStyleLibraryListingApi(context: event.context, isLoadMore: false);
    } else {
      await _callCadLibraryListingApi(context: event.context, isLoadMore: false);
    }
    emit(const CadListingLoadedState());
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productForLibraryCAD;
      if (screenIdentifier == ScreenIdentifier.productForLibraryStyle) {
        appBarTitle = APPStrings.styleLibrary.tr;
      } else {
        appBarTitle = APPStrings.cadLibrary.tr;
      }
    }
  }

  Future<void> _initializeSortOptions(BuildContext context) async {
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.cadLibrary.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
      BlocProvider.of<SortFilterBloc>(context).add(InitialSortFilterEvent(sortOptions: sortOptions));
    }
  }

  Future<void> _callCadLibraryListingApi({required BuildContext context, bool isLoadMore = false}) async {
    final Map<String, String> params = {
      ApiKey.limit: AppConst.pageLimit.toString(),
      ApiKey.page: gridPaginationScrollController.currentPage.toString(),
      ApiKey.sortValue: sortValue,
      ApiKey.sortKey: sortKey,
    };

    /// Build the query based on filters
    buildFilterQuery(params, filterData).forEach((key, value) {
      if (params.containsKey(key) == false) {
        params[key] = value;
      }
    });

    Either<ErrorResponse, PaginationData<CadLibraryListItemDataModel>>? response = await AppRepository(
      context,
    ).getCadLibraryList(query: params, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        totalFilteredRecords = success.filteredRecords;
        final localList = success.dataList ?? [];
        cadList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e)).toList());
      },
    );
    gridPaginationScrollController.isPageLoaded.complete(gridPaginationScrollController.currentPage == totalNumberOfPages);
  }

  Future<void> _callStyleLibraryListingApi({required BuildContext context, bool isLoadMore = false}) async {
    final Map<String, String> params = {
      ApiKey.limit: AppConst.pageLimit.toString(),
      ApiKey.page: gridPaginationScrollController.currentPage.toString(),
      ApiKey.sortValue: sortValue,
      ApiKey.sortKey: sortKey,
    };

    /// Build the query based on filters
    buildFilterQuery(params, filterData).forEach((key, value) {
      if (params.containsKey(key) == false) {
        params[key] = value;
      }
    });

    Either<ErrorResponse, PaginationData<CadLibraryListItemDataModel>>? response = await AppRepository(
      context,
    ).getStyleLibraryList(query: params, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        totalFilteredRecords = success.filteredRecords;
        final localList = success.dataList ?? [];
        cadList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e, isCadLibrary: false)).toList());
      },
    );
    gridPaginationScrollController.isPageLoaded.complete(gridPaginationScrollController.currentPage == totalNumberOfPages);
  }

  B2BCustomListingDataModel convertToB2BCustomListingDataModel({
    required CadLibraryListItemDataModel sourceModel,
    bool isCadLibrary = true,
  }) {
    return B2BCustomListingDataModel(
      id: sourceModel.suid,
      strCADLibraryImageUrl:
          (sourceModel.multipleFinishedViewImage).isNotNullNorEmpty
              ? sourceModel.multipleFinishedViewImage?.firstOrNull?.multiAngleUrl.firstOrNull?.url
              : '',
      strCADLibraryNumber: sourceModel.styleNumber,
      strCADLibraryProductName: sourceModel.autoDescription,
      strCarats: "${sourceModel.crt ?? 0} ${APPStrings.crt.tr}",
      strGrams: "${sourceModel.approximateModelWeight ?? 0} ${APPStrings.grms.tr}",
      tagImagePath: getTagImagePath(sourceModel),
      commodity: isCadLibrary ? Commodity.cadLibrary : Commodity.styleLibrary,
      isAddedToCart: sourceModel.isAddedToCart,
    );
  }

  Future<void> _onCadListLoadMoreEvent(CadListLoadMoreEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListLoadingMoreState());
    await _callCadLibraryListingApi(context: event.context);
    emit(const CadListLoadedMoreState());
  }

  void _onCadChangeListingTypeEvent(CadChangeListingTypeEvent event, Emitter<CadLibraryListingState> emit) {
    emit(const CadListingReloadState());
    isGrid = event.isGrid;
    emit(const CadChangeListingTypeState());
  }

  Future<void> _onCadListPullToRefresh(CadListPullToRefreshEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListingReloadState());
    emit(CadPullToRefreshState());
    gridPaginationScrollController.pullToRefresh();
    cadList.clear();
    await _callCadLibraryListingApi(context: event.context, isLoadMore: false);
    refreshCompleter.complete(true);
    emit(const CadListingLoadedState());
  }

  // _onCadSortEvent
  Future<void> _onCadSortEvent(CadSortEvent event, Emitter<CadLibraryListingState> emit) async {
    emit(const CadListingLoadingState());

    sortKey = event.sortData.sortKey ?? "";
    sortValue = event.sortData.sortValue ?? "";
    gridPaginationScrollController.pullToRefresh();
    if (screenIdentifier == ScreenIdentifier.productForLibraryStyle) {
      await _callStyleLibraryListingApi(context: event.context, isLoadMore: false);
    } else {
      await _callCadLibraryListingApi(context: event.context, isLoadMore: false);
    }
    emit(const CadListingLoadedState());
  }

  Future<bool> pullToRefresh({required BuildContext context}) async {
    refreshCompleter = Completer<bool>();
    add(CadListPullToRefreshEvent(context: context));
    return refreshCompleter.future;
  }

  Future<void> _setupFilters(BuildContext context) async {
    final String filterKey = screenIdentifier == ScreenIdentifier.productForLibraryStyle ? AppConst.styleLibrary : AppConst.cadLibrary;

    final List<FilterOptionModel> tempFilterData = await BlocProvider.of<AppBloc>(context).getFilterOptionList(context, filterKey);
    filterData.clear();
    for (FilterOptionModel filterOption in tempFilterData) {
      if (filterOption.data.isNotEmpty) {
        FilterData filter = FilterData(
          name: filterOption.name,
          code: filterOption.slug,
          inputType: filterOption.inputType,
          filterType: filterOption.filterType,
          subFilterCodes: filterOption.data.map((e) => e.toString()).join(','),
          secondaryFilterData: [],
        );
        if (!filterOption.fromCommon) {
          filter.secondaryFilterData = filterOption.data.map((e) => SecondaryFilterData(name: e.toString(), code: e.toString())).toList();
        } else if (filterOption.filterType == FilterType.boolean) {
          if (filterOption.data.isNotEmpty && filterOption.data.any((element) => element?.toString().toLowerCase() == 'yes')) {
            filter.secondaryFilterData = [SecondaryFilterData(name: filterOption.name)];
          } else {
            continue;
          }
        } else if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
          filter.minMaxValues = SfRangeValues(0, filterOption.data.lastOrNull?.toString().toDouble ?? 0);
        }
        filterData.add(filter);
      }
    }
  }

  Map<String, String> buildFilterQuery(Map<String, String> query, List<FilterData> filterData) {
    filterData
        .where((element) {
          return (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
              (element.filterType == FilterType.range && element.rangeValues != null);
        })
        .forEach((element) {
          if (element.filterType == FilterType.range) {
            query['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
            query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
          } else if (element.filterType == FilterType.boolean &&
              (element.secondaryFilterData ?? []).isNotEmpty &&
              element.secondaryFilterData!.any((e) => e.isSelected)) {
            query[element.code ?? ''] = AppConst.filterBoolYesValue;
          } else {
            query[element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
          }
        });
    return query;
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

  Future<void> _onCadLibraryFilterEvent(CadLibraryFilterEvent event, Emitter<CadLibraryListingState> emit) async {
    await _handleApplyFilter(context: event.context, emit: emit, appliedFilterData: event.filterData);
  }

  Future<void> _handleApplyFilter({
    required BuildContext context,
    required Emitter<CadLibraryListingState> emit,
    required List<FilterData> appliedFilterData,
  }) async {
    try {
      emit(const CadListingLoadingState());
      filterData = appliedFilterData;
      gridPaginationScrollController.pullToRefresh();
      cadList.clear();
      if (screenIdentifier == ScreenIdentifier.productForLibraryStyle) {
        await _callStyleLibraryListingApi(context: context, isLoadMore: false);
      } else {
        await _callCadLibraryListingApi(context: context, isLoadMore: false);
      }
      emit(const CadListingLoadedState());
    } catch (e) {
      debugPrint("Error in _handleApplyFilter: $e");
    }
  }

  String getTagImagePath(CadLibraryListItemDataModel sourceModel) {
    String tagImagePath = '';
    final String languageCode = _appBloc.locale.languageCode;
    if (sourceModel.isExclusive?.toLowerCase() == 'yes') {
      tagImagePath = AppImages.icExclusiveLabel(languageCode);
    }
    return tagImagePath;
  }
}
