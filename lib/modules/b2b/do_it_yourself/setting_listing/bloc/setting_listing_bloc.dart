import 'package:kgk/kgk.dart';

part 'setting_listing_event.dart';

part 'setting_listing_state.dart';

class SettingListingBloc extends Bloc<SettingListingEvent, SettingListingState> {
  /// Hold the current [AppBloc]
  late AppBloc appBloc;

  /// Current screen identifier
  ScreenIdentifier? screenIdentifier;

  /// Holds selected diamond data for the DIY feature
  DiamondDataModel? diamondDataForDIY;
  GemstoneDatum? gemstoneDataForDIY;

  /// Indicates if the toggle is in its initial state
  bool isInitialToggle = true;

  /// Determines if the product view is in grid mode
  bool isGrid = true;

  /// Current sorting key used for listing
  String sortKey = AppConst.sortKeySuid;

  /// Current sorting order (ascending/descending)
  String sortValue = AppConst.sortValueAsc;

  /// List of applied filter data
  List<FilterData> filterData = [];

  /// List of applied filter data from navigation
  Map<String, dynamic>? filterDataMap;

  /// List to store loaded product details
  final List<ProductDetailsModel> productList = [];

  /// List to store available DIY styles
  final List<DiyStyleListModel> diyStyleList = [];

  /// Total number of pages available in pagination
  int? totalNumberOfPages;

  /// Title of the AppBar in the DIY listing screen
  String settingListingAppbarTitle = APPStrings.doItYourself;

  /// Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  DIYType? diyType;

  SettingListingBloc() : super(const SettingListingInitial()) {
    on<SettingListingInitialEvent>(_onSettingListingInitialEvent);
    on<SettingChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<LoadMoreSettingProductListEvent>(_onLoadMoreSettingProductListEvent);
    on<SettingListPullToRefreshEvent>(_onSettingListPullToRefresh);
    on<SettingListingOnTapEvent>(_onSettingListingOnTapEvent);
    on<SettingLibraryFilterEvent>(_onSettingLibraryFilterEvent);
  }

  Future<void> _onSettingListingInitialEvent(SettingListingInitialEvent event, Emitter<SettingListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _initializeBloc(BuildContext context, Emitter<SettingListingState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(context);
    getRouteData(context);
    _initializePagination(context);
    productList.clear();
    diyStyleList.clear();
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
    await _fetchSettingProductList(context, emit, false);
    emit(const SettingLoadedState());
  }

  /// Get screen identifier
  void getRouteData(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor];
    diyType = data?[RoutesData.type] ?? DIYType.diamond;
    if (screenIdentifier != null && screenIdentifier == ScreenIdentifier.jewelleryForDIY) {
      diamondDataForDIY = null;
      gemstoneDataForDIY = null;
    } else {
      diamondDataForDIY = appBloc.diamondDataForDIY;
      gemstoneDataForDIY = appBloc.gemstoneDataForDIY;
    }
    filterDataMap = data?[RoutesData.filterData];
  }

  /// Initialize pagination
  _initializePagination(BuildContext context) {
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(LoadMoreSettingProductListEvent(context: context, currentPage: currentPage));
      },
    );
  }

  void _onChangeListingTypeEvent(SettingChangeListingTypeEvent event, Emitter<SettingListingState> emit) {
    emit(const SettingProductReloadState());
    isGrid = !isGrid;
    emit(SettingChangeListingTypeState());
  }

  Future<void> _onLoadMoreSettingProductListEvent(LoadMoreSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    if (event.currentPage <= totalNumberOfPages!) {
      emit(const SettingLoadingMoreState());
      await _fetchSettingProductList(event.context, emit, true);
      emit(SettingProductLoadedMoreState(event.currentPage));
    }
  }

  Future<void> _onSettingListPullToRefresh(SettingListPullToRefreshEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingProductReloadState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    await _fetchSettingProductList(event.context, emit, false);
    emit(const SettingLoadedState());
  }

  Future<void> _onSettingListingOnTapEvent(SettingListingOnTapEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingLoadedState());
  }

  Future<void> _setupFilters(BuildContext context) async {
    final filterList = await BlocProvider.of<AppBloc>(
      context,
    ).getFilterOptionList(context, AppConst.diyStyleListing, subTypeCode: filterDataMap?[ApiKey.jewelleryTypeName]);
    filterData.clear();
    for (FilterOptionModel filterOption in filterList) {
      if (filterDataMap?.containsKey(filterOption.slug) == true) {
        continue;
      }
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
          if (filterOption.data.isNotEmpty) {
            filter.minMaxValues = SfRangeValues(0, filterOption.data.lastOrNull?.toString().toDouble ?? 0);
          } else {
            continue;
          }
        }
        filterData.add(filter);
      }
    }
  }

  Future<void> _fetchSettingProductList(BuildContext context, Emitter<SettingListingState> emit, bool isLoadMore) async {
    Either<ErrorResponse, PaginationData<DiyStyleListModel>>? response;

    Map<String, String> query = {};
    filterDataMap?.forEach((key, value) {
      query[key] = value.toString(); // Add filterDataMap to query
    });
    filterData
        .where(
          (element) =>
              (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
              (element.filterType == FilterType.range && element.rangeValues != null),
        )
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

    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      query[ApiKey.shapeCode] = diyType == DIYType.diamond ? diamondDataForDIY?.shapeCode ?? '' : gemstoneDataForDIY?.shapeCode ?? '';
    }

    response = await AppRepository(context).diyStyleFilters(
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
      limit: AppConst.pageLimit.toString(),
      sortKey: sortKey,
      sortValue: sortValue,
      query: query,
    );

    response?.fold((error) => Utils.showMessage(error.message), (PaginationData<DiyStyleListModel> success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final List<DiyStyleListModel> localList = (success.dataList ?? []);
      diyStyleList.addAll(localList);
      productList.addAll(
        localList.map((item) {
          return ProductDetailsModel(
            suid: item.suid ?? "",
            imageUrl: item.multipleFinishedViewImage.firstOrNull?.imageUrl ?? "",
            subTitle: item.autoDescription,
            originalPrice: item.finalPrice?.toString().setCurrency,
            finalPrice: item.discountPrice?.toString().setCurrency,
            productId: item.suid ?? "",
            commodity: Commodity.jewellery,
            businessCategoryName: item.businessCategoryName ?? "",
            colorsCode: [item.metalColor1HexCode ?? ""],
          );
        }).toList(),
      );
      if (paginationScrollController.isPageLoaded.isCompleted) {
        paginationScrollController.isPageLoaded = Completer<bool>();
      }
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
    });
  }

  Future<void> _onSettingLibraryFilterEvent(SettingLibraryFilterEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    diyStyleList.clear();
    filterData = event.filterData;
    await _fetchSettingProductList(event.context, emit, false);
    emit(const SettingLoadedState());
  }
}
