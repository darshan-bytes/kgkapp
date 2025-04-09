import 'package:kgk/kgk.dart';

part 'exhibition_details_event.dart';

part 'exhibition_details_state.dart';

class ExhibitionDetailsBloc extends Bloc<ExhibitionDetailsEvent, ExhibitionDetailsState> {
  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// App bar title for the screen
  String appbarTitle = '';

  String exhibitionId = '';

  /// Exhibition type is required for fetching exhibition product listing
  String exhibitionType = '';

  /// Identify Current user type
  UserType userType = UserType.b2cUser;

  /// For keeping track of the current tab and stop same tab on click event
  int currentTab = -1;

  /// TabController for managing tabs in the UI.
  late TabController tabController;

  /// List of tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.products.tr),
    Tab(text: APPStrings.orders.tr),
  ];

  /// The total number of filtered records
  int totalFilteredRecords = 0;

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// List of exhibition products
  List<ProductDetailsModel> productList = [];

  /// List of exhibition orders
  List<B2BCustomListingDataModel> exhibitionOrdersList = [];

  /// Exhibition details
  ExhibitionListDataModel exhibitionDetails = ExhibitionListDataModel();
  ExhibitionProductDetailsDataModel exhibitionProductDetailsData = ExhibitionProductDetailsDataModel();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// Text editing controller
  final TextEditingController searchOrderController = TextEditingController();

  /// Focus node
  FocusNode focusNode = FocusNode();

  final GlobalKey tabTargetKey = GlobalKey();

  ExhibitionDetailsBloc() : super(const ExhibitionDetailsInitialsState()) {
    on<ExhibitionDetailsInitialEvent>(_onInitialEvent);
    on<ExhibitionChangeTabsEvent>(_onChangeTabEvent);
    on<ExhibitionListingLoadMoreEvent>(_onExhibitionListingLoadMoreEvent);
    on<ExhibitionChangeListingTypeEvent>(_onExhibitionChangeListingTypeEvent);
    on<ExhibitionOrdersListSearchEvent>(_onListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<ExhibitionOrdersListFilterEvent>(_onListFilterEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  /// Initializes the OrdersBloc by fetching order data
  Future<void> _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _initializeBloc(context: event.context, emit: emit);
  }

  /// Handles the ChangeOrderTabsEvent for tab switching
  Future<void> _onChangeTabEvent(ExhibitionChangeTabsEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleTabSelection(context: event.context, index: event.index, emit: emit);
  }

  /// Handles the load more event for order listings
  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleLoadMore(context: event.context, emit: emit, currentPage: event.currentPage);
  }

  /// Handles the change listing type event
  Future<void> _onExhibitionChangeListingTypeEvent(ExhibitionChangeListingTypeEvent event, Emitter<ExhibitionDetailsState> emit) async {
    _toggleViewType(isGridValue: event.isGrid, emit: emit);
  }

  /// Handles the search event for order listings
  Future<void> _onListSearchEvent(ExhibitionOrdersListSearchEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleSearch(emit, context: event.context);
  }

  /// Handles the filter event for order listings
  Future<void> _onListFilterEvent(ExhibitionOrdersListFilterEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  Future<void> _initializeBloc({required Emitter<ExhibitionDetailsState> emit, required BuildContext context}) async {
    emit(const ExhibitionDetailsReloadState());

    /// Set the current user type.
    userType = BlocProvider.of<AppBloc>(context).userType;

    /// Extract exhibitionId number from route data.
    _getRouteData(context);

    /// Initialize pagination.
    _initializePagination(context);

    /// Fetch exhibition details
    await _getExhibitionDetails(context, exhibitionId);

    /// Fetch exhibition product details
    await _getExhibitionProductDetails(context, exhibitionId);

    /// Fetch exhibition product listing
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      /// Fetch exhibition product listing
      await _callProductListingApi(context: context, exhibitionType: exhibitionType, emit: emit);
    }
    emit(const ExhibitionDetailsLoadedState());
  }

  /// Extract exhibitionId number from route data.
  void _getRouteData(BuildContext context) {
    String exhibitionIdValue = context.routesData?[RoutesData.exhibitionId] ?? '';
    if (exhibitionIdValue.isNotNullNorEmpty) {
      exhibitionId = exhibitionIdValue;
    }
  }

  /// Initializes pagination for loading more order data
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ExhibitionListingLoadMoreEvent(currentPage: currentPage, context: context));
      },
    );
  }

  /// Fetches the exhibition details data from the API
  Future<void> _getExhibitionDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionListDataModel>? response = await AppRepository(context).fetchExhibitionDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) {
        /// Set the exhibition details.
        exhibitionDetails = data;
        appbarTitle = exhibitionDetails.name ?? '';
        exhibitionType = exhibitionDetails.exhibitionType ?? "";
      },
    );
  }

  /// Fetches the exhibition product details data from the API
  Future<void> _getExhibitionProductDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionProductDetailsDataModel>? response = await AppRepository(context).fetchExhibitionProductDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) => exhibitionProductDetailsData = data,
    );
  }

  /// Handles tab selection and reloads order data accordingly
  Future<void> _handleTabSelection(
      {required BuildContext context, required int index, required Emitter<ExhibitionDetailsState> emit}) async {
    if (currentTab == index) return;
    currentTab = index;
    emit(const ExhibitionDetailsReloadState());

    /// Reload order data
    await _reloadTabData(context, emit);
    emit(const ExhibitionChangeTabsState());
  }

  /// Reloads the order data for the specified category
  Future<void> _reloadTabData(BuildContext context, Emitter<ExhibitionDetailsState> emit) async {
    searchOrderController.clear();
    paginationScrollController.pullToRefresh();

    if (currentTab == 0) {
      /// Fetch exhibition product listing
      productList.clear();
      await _callProductListingApi(context: context, exhibitionType: exhibitionType, emit: emit);
    } else {
      _fetchFilterData(context, emit);

      /// Fetch exhibition order listing
      exhibitionOrdersList.clear();
      await _callExhibitionOrderListingApi(context, emit);
    }
  }

  /// Fetches filter data
  void _fetchFilterData(BuildContext context, Emitter<ExhibitionDetailsState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  /// Toggle between grid and list view
  void _toggleViewType({bool isGridValue = false, required Emitter<ExhibitionDetailsState> emit}) {
    emit(const ExhibitionDetailsReloadState());
    isGrid = isGridValue;
    emit(const ExhibitionChangeListingTypeState());
  }

  Future<void> _handleLoadMore(
      {required BuildContext context, required Emitter<ExhibitionDetailsState> emit, required int currentPage}) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(ExhibitionListingLoadingMoreState());
      await _callProductListingApi(context: context, exhibitionType: exhibitionType, emit: emit);
      emit(ExhibitionListingLoadedMoreState(currentPage));
    }
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<ExhibitionDetailsState> emit, List<FilterData> newAppliedFilterData) async {
    emit(ExhibitionDetailsLoadingState());
    paginationScrollController.pullToRefresh();
    exhibitionOrdersList.clear();
    filterData = newAppliedFilterData;
    await _callExhibitionOrderListingApi(context, emit);
    emit(ExhibitionDetailsLoadedState());
  }

  /// Handles the search event locally
  Future<void> _handleSearch(Emitter<ExhibitionDetailsState> emit, {required BuildContext context}) async {
    emit(const ExhibitionDetailsLoadingState());
    paginationScrollController.pullToRefresh();
    exhibitionOrdersList.clear();
    await _callExhibitionOrderListingApi(context, emit);
    if (searchOrderController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(const ExhibitionDetailsLoadedState());
  }

  Future<void> _callProductListingApi(
      {required BuildContext context, required String exhibitionType, required Emitter<ExhibitionDetailsState> emit}) async {
    Either<ErrorResponse, dynamic>? response;

    /// Call appropriate API based on exhibitionType
    if (exhibitionType == AppConst.diamond) {
      response = await AppRepository(context).fetchDiamondList(
        limit: AppConst.pageLimit.toString(),
        page: paginationScrollController.currentPage.toString(),
        query: {ApiKey.exhibitionId: exhibitionId},
      );
    } else if (exhibitionType == AppConst.jewellery) {
      response = await AppRepository(context).fetchJewelleryList(
        limit: AppConst.pageLimit.toString(),
        page: paginationScrollController.currentPage.toString(),
        query: {ApiKey.exhibitionId: exhibitionId},
      );
    } else if (exhibitionType == AppConst.gemstone) {
      response = await AppRepository(context).fetchGemstoneList(
        limit: AppConst.pageLimit.toString(),
        page: paginationScrollController.currentPage.toString(),
        query: {ApiKey.exhibitionId: exhibitionId},
        isLoadMore: false,
      );
    } else if (exhibitionType == AppConst.cadLibrary) {
      response = await AppRepository(context).getCadLibraryList(query: {
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.exhibitionId: exhibitionId,
      }, isLoadMore: false);
    } else if (exhibitionType == AppConst.designLibrary) {
      response = await AppRepository(context).getDesignLibraryList(query: {
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.exhibitionId: exhibitionId,
      });
    } else if (exhibitionType == AppConst.styleLibrary) {
      response = await AppRepository(context).getStyleLibraryList(query: {
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.exhibitionId: exhibitionId,
      }, isLoadMore: false);
    } else if (exhibitionType == AppConst.skuLibrary) {
      response = await AppRepository(context).getSkuLibraryList(query: {
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.exhibitionId: exhibitionId,
      });
    }

    /// Process API response
    await response?.fold(
      (error) => Utils.showMessage(error.message),
      (success) async {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        totalFilteredRecords = success.filteredRecords ?? 0;

        /// Populate product list
        if (exhibitionType == AppConst.diamond) {
          productList.addAll(_populateDiamondProductList(success.data));
        } else if (exhibitionType == AppConst.jewellery) {
          productList.addAll(_populateJewelleryProductList(success.data));
        } else if (exhibitionType == AppConst.gemstone) {
          productList.addAll(_populateGemstoneProductList(success.data));
        } else if (exhibitionType == AppConst.cadLibrary) {
          productList.addAll(_populateCadLibraryProductList(success.dataList ?? []));
        } else if (exhibitionType == AppConst.designLibrary) {
          productList.addAll(_populateDesignLibraryProductList(success.dataList ?? []));
        } else if (exhibitionType == AppConst.styleLibrary) {
          productList.addAll(_populateStyleLibraryProductList(success.dataList ?? []));
        } else if (exhibitionType == AppConst.skuLibrary) {
          productList.addAll(_populateSkuLibraryProductList(success.dataList ?? []));
        }

        /// Manage pagination state
        if (!paginationScrollController.isPageLoaded.isCompleted) {
          paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
        }
      },
    );

    emit(ExhibitionDetailsLoadedState());
  }

  /// Builds the filters dynamically based on the filter data
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD)
            ].join(',');
          }
          break;
        case FilterType.checkbox:
          List<String?>? selectedCodes = element.secondaryFilterData?.where((e) => e.isSelected).map((e) => e.code).toList();
          if (selectedCodes != null && selectedCodes.isNotEmpty) {
            filters[element.code ?? ''] = selectedCodes.join(',');
          }
          break;
        default:
          break;
      }
    }

    return filters;
  }

  /// Builds the query dynamically based on the filter data, pagination, and sorting
  Map<String, dynamic> buildQuery({
    required List<FilterData> filterData,
    required int currentPage,
    required int pageLimit,
    String? commodity,
    required String searchQuery,
  }) {
    Map<String, dynamic> query = {};
    query.addAll(buildFilters(filterData));
    query.addAll({
      ApiKey.search: searchQuery,
      ApiKey.page: currentPage,
      ApiKey.limit: pageLimit,
      ApiKey.dir: AppConst.sortValueDesc,
      ApiKey.field: AppConst.uniqueId,
      ApiKey.orderContextId: exhibitionId,
    });
    return query;
  }

  Future<void> _callExhibitionOrderListingApi(BuildContext context, Emitter<ExhibitionDetailsState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query}) async {
    /// Build the query base on the current tab applied filters data
    query = buildQuery(
      filterData: filterData,
      searchQuery: searchOrderController.text,
      currentPage: paginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );
    Either<ErrorResponse, PaginationData<OrderItem>>? response =
        await AppRepository(context).getMyOrderList(body: query, isLoadMore: isLoadMore);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      totalFilteredRecords = success.filteredRecords ?? 0;

      exhibitionOrdersList.addAll(_populateOrderList((success.dataList as List<OrderItem>)));

      /// Manage pagination state
      if (!paginationScrollController.isPageLoaded.isCompleted) {
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      }
    });
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchOrderListingFilterOptionList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) {
      filterData.clear();
      if (success.filters.isNotNullNorEmpty) {
        for (Filters filterOption in success.filters ?? []) {
          FilterData filter = FilterData(
            name: filterOption.title,
            code: filterOption.key,
            inputType: filterOption.type,
            filterType: filterOption.getFilterType(filterType: filterOption.type),
            secondaryFilterData: _getSecondaryFilterData(filterOption: filterOption),
          );
          filterData.add(filter);
        }
      }
    });
  }

  /// Get secondary filter data
  List<SecondaryFilterData> _getSecondaryFilterData({required Filters filterOption}) {
    FilterType filterType = filterOption.getFilterType(filterType: filterOption.type);
    List<SecondaryFilterData> tempSecondaryData = [];
    if (filterType == FilterType.checkbox) {
      tempSecondaryData = filterOption.options?.map((option) => SecondaryFilterData(name: option.label, code: option.value)).toList() ?? [];
    }
    return tempSecondaryData;
  }

  /// Populates the product list for diamond.
  List<ProductDetailsModel> _populateDiamondProductList(List<DiamondDataModel> diamondDataList) {
    return List.generate(
      diamondDataList.length,
      (index) => ProductDetailsModel(
        productId: diamondDataList[index].id,
        imageUrl: (diamondDataList[index].image.isNotNullNorEmpty) ? diamondDataList[index].image.first.url : '',
        title: diamondDataList[index].lotCode,
        subTitle: diamondDataList[index].rmDescription,
        originalPrice: diamondDataList[index].finalPrice?.toString().setCurrency,
        finalPrice: diamondDataList[index].discountPrice?.toString().setCurrency,
        isCommentVisible: true,
        commodity: Commodity.diamond,
      ),
    ).toList();
  }

  /// Populates the product list for jewellery.
  List<ProductDetailsModel> _populateJewelleryProductList(List<JewelleryDataModel> jewelleryDataList) {
    return List.generate(
      jewelleryDataList.length,
      (index) => ProductDetailsModel(
        productId: jewelleryDataList[index].id,
        imageUrl: (jewelleryDataList[index].multipleFinishedViewImage.isNotNullNorEmpty)
            ? jewelleryDataList[index].multipleFinishedViewImage.first.imageUrl
            : '',
        title: jewelleryDataList[index].contractNoSkuNo,
        subTitle: jewelleryDataList[index].productDescription,
        kgkCollectionName: jewelleryDataList[index].kgkCollection ?? "\n",
        businessCategoryName: jewelleryDataList[index].businessCategoryName ?? "\n",
        originalPrice: jewelleryDataList[index].finalPrice?.toString().setCurrency,
        finalPrice: jewelleryDataList[index].discountPrice?.toString().setCurrency,
        cts: jewelleryDataList[index].crt,
        gms: jewelleryDataList[index].gms,
        colorsCode: [
          jewelleryDataList[index].metalColor1HexCode ?? "",
          jewelleryDataList[index].metalColor2HexCode ?? "",
          jewelleryDataList[index].metalColor3HexCode ?? "",
        ],
        isCommentVisible: true,
        commodity: Commodity.jewellery,
      ),
    ).toList();
  }

  /// Populates the product list for gemstone.
  List<ProductDetailsModel> _populateGemstoneProductList(List<GemstoneDatum> gemstoneDataList) {
    return List.generate(
      gemstoneDataList.length,
      (index) => ProductDetailsModel(
        productId: gemstoneDataList[index].id,
        imageUrl: (gemstoneDataList[index].image.isNotNullNorEmpty) ? gemstoneDataList[index].image.first.url : '',
        title: gemstoneDataList[index].lotCode,
        subTitle: gemstoneDataList[index].rmDescription,
        originalPrice: gemstoneDataList[index].finalPrice?.toString().setCurrency,
        finalPrice: gemstoneDataList[index].discountPrice?.toString().setCurrency,
        isCommentVisible: true,
        commodity: Commodity.gemstone,
      ),
    ).toList();
  }

  /// Populates the product list for CAD library.
  List<ProductDetailsModel> _populateCadLibraryProductList(List<CadLibraryListItemDataModel> cadLibraryListItemDataList) {
    return List.generate(
      cadLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: cadLibraryListItemDataList[index].sId,
        imageUrl: cadLibraryListItemDataList[index].strCADLibraryImageUrl,
        title: cadLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: cadLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: cadLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: cadLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
        commodity: Commodity.cadLibrary,
      ),
    ).toList();
  }

  /// Populates the product list for design library.
  List<ProductDetailsModel> _populateDesignLibraryProductList(List<DesignLibraryListItemDataModel> designLibraryListItemDataList) {
    return List.generate(
      designLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: designLibraryListItemDataList[index].sId,
        imageUrl: (designLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? designLibraryListItemDataList[index].images?.first
            : '',
        title: designLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: designLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: designLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: designLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
        commodity: Commodity.designLibrary,
      ),
    ).toList();
  }

  /// Populates the product list for style library.
  List<ProductDetailsModel> _populateStyleLibraryProductList(List<CadLibraryListItemDataModel> styleLibraryListItemDataList) {
    return List.generate(
      styleLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: styleLibraryListItemDataList[index].sId,
        imageUrl: (styleLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? styleLibraryListItemDataList[index].images?.first
            : '',
        title: styleLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: styleLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: styleLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: styleLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
        commodity: Commodity.styleLibrary,
      ),
    ).toList();
  }

  /// Populates the product list for SKU library.
  List<ProductDetailsModel> _populateSkuLibraryProductList(List<SkuLibraryListItemDataModel> skuProductList) {
    return List.generate(
      skuProductList.length,
      (index) => ProductDetailsModel(
        productId: skuProductList[index].suid,
        imageUrl: (skuProductList[index].multipleFinishedViewImage.isNotNullNorEmpty)
            ? skuProductList[index].multipleFinishedViewImage.first.imageUrl
            : '',
        title: skuProductList[index].contractNumber,
        subTitle: skuProductList[index].productDescription ?? '',
        kgkCollectionName: skuProductList[index].kgkCollection ?? "\n",
        businessCategoryName: skuProductList[index].businessCategoryName ?? "\n",
        originalPrice: skuProductList[index].finalPrice?.toString().setCurrency,
        finalPrice: skuProductList[index].discountPrice?.toString().setCurrency,
        isCommentVisible: true,
        commodity: Commodity.skuLibrary,
      ),
    ).toList();
  }

  List<B2BCustomListingDataModel> _populateOrderList(List<OrderItem> dataList) {
    return dataList.map<B2BCustomListingDataModel>((OrderItem data) {
      return B2BCustomListingDataModel(
        id: data.uniqueId?.toString(),
        strOrderId: data.uniqueId?.toString(),
        strCustomerName: data.name,
        strEmail: data.email,
        strMobileNumber: data.phone,
        strItems: data.items?.toString(),
        strTotalAmount: data.totalPrice?.setCurrency,
        strOrderedBy: data.createdByDetails?.fullName,
        strCreatedOn: data.createdAt?.changeDateFormat(
            inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ, outputDateFormat: DateFormatter.dateFormatDDMMMYYYY),
        strOrderedByImageUrl: data.createdByDetails?.profilePicUrl,
        strTotalQuantity: data.totalQuantity?.toString(),
      );
    }).toList();
  }
}
