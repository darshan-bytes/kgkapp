import 'package:kgk/kgk.dart';

part 'exhibition_details_event.dart';

part 'exhibition_details_state.dart';

class ExhibitionDetailsBloc extends Bloc<ExhibitionDetailsEvent, ExhibitionDetailsState> {
  String appbarTitle = '';
  int currentIndex = 0;
  bool isGrid = true;
  bool isInitialToggle = true;
  String exhibitionId = '';

  late TabController tabController;

  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.products.tr),
    Tab(text: APPStrings.orders.tr),
  ];

  List<B2BCustomListingDataModel> exhibitionOrdersList = [];

  List<ProductDetailsModel> productList = [];

  /// List of applied filter data
  final Map<int, List<FilterData>> appliedFilterData = {};

  /// Store filter and sort data
  List<FilterData> filterData = [];
  List<SortOptions> sortOptions = [];

  int? totalNumberOfPages;

  String sortKey = AppConst.sortKeyUpdatedDateTime;
  String sortValue = AppConst.sortValueDesc;

  SmartPaginationScrollController orderScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController productPaginationScrollController = SmartPaginationScrollController();

  final GlobalKey tabBarKey = GlobalKey();

  ValueNotifier<bool> canScrollToTop = ValueNotifier<bool>(false);

  ExhibitionListDataModel exhibitionDetails = ExhibitionListDataModel();
  ExhibitionProductDetailsDataModel exhibitionProductDetailsData = ExhibitionProductDetailsDataModel();

  ExhibitionDetailsBloc() : super(const ExhibitionDetailsInitialsState()) {
    on<ExhibitionDetailsInitialEvent>(_onInitialEvent);
    on<ExhibitionChangeTabsEvent>(_onChangeTabEvent);
    on<ExhibitionListingLoadMoreEvent>(_onExhibitionListingLoadMoreEvent);
    on<ExhibitionChangeListingTypeEvent>(_onExhibitionChangeListingTypeEvent);
  }

  Future<void> _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionDetailsReloadState());
    isGrid = true;
    Map<RoutesData, dynamic>? data = event.context.routesData;
    String exhibitionId = data?[RoutesData.exhibitionId] ?? '';
    if (exhibitionId.isNullOrEmpty) return;
    _initScrollControllers();
    await _getExhibitionDetails(event.context, exhibitionId);
    appbarTitle = exhibitionDetails.name ?? '';
    await _getExhibitionProductDetails(event.context, exhibitionId);
    await fetchDiamondList(event.context, emit, isLoadMore: false, exhibitionId: exhibitionId);
    emit(const ExhibitionDetailsLoadedState());
  }

  Future<void> _onChangeTabEvent(ExhibitionChangeTabsEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionDetailsReloadState());
    scrollController.removeListener(scrollToTopListener);
    currentIndex = tabController.index;
    scrollController.addListener(scrollToTopListener);
    if (currentIndex == 1) {
      await fetchOrderListData(event.context, emit, isLoadMore: false, exhibitionId: exhibitionId);
    } else {
      await fetchDiamondList(event.context, emit, isLoadMore: false, exhibitionId: exhibitionId);
    }
    emit(const ExhibitionChangeTabsState());
  }

  void _onExhibitionChangeListingTypeEvent(ExhibitionChangeListingTypeEvent event, Emitter<ExhibitionDetailsState> emit) {
    emit(const ExhibitionDetailsReloadState());
    scrollController.removeListener(scrollToTopListener);
    isGrid = event.isGrid;
    productPaginationScrollController.onViewChange(!isGrid);
    scrollController.addListener(scrollToTopListener);
    emit(const ExhibitionChangeListingTypeState());
  }

  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionListingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    _loadMoreData(event);
    emit(ExhibitionListingLoadedMoreState(event.currentPage + 1));
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
    required String orderContextId,
  }) {
    Map<String, dynamic> query = {};
    query.addAll(buildFilters(filterData));
    query.addAll({
      ApiKey.page: currentPage,
      ApiKey.limit: pageLimit,
      ApiKey.orderContextId: orderContextId,
    });
    return query;
  }

  /// Fetches the order list data from the API
  Future<void> fetchOrderListData(BuildContext context, Emitter<ExhibitionDetailsState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query, required String exhibitionId}) async {
    /// Build the query base on the current tab applied filters data
    query = buildQuery(
      filterData: appliedFilterData[tabController.index] ?? [],
      currentPage: productPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
      orderContextId: exhibitionId,
    );
    Either<ErrorResponse, PaginationData<OrderItem>>? response =
        await AppRepository(context).getMyOrderList(body: query, isLoadMore: isLoadMore);

    response?.fold((error) {
      Utils.showMessage(error.message);
      emit(ExhibitionDetailsReloadState());
    }, (success) {
      // exhibitionOrdersList = success.dataList ;
      // as List<OrderItem>;
      exhibitionOrdersList.clear();
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      exhibitionOrdersList.addAll(_populateOrderList((success.dataList as List<OrderItem>)));
      // filteredOrderList = List.from(originalOrderList);
      // if (!orderPaginationScrollController.isPageLoaded.isCompleted) {
      //   orderPaginationScrollController.isPageLoaded.complete(orderPaginationScrollController.currentPage == totalNumberOfPages);
      // }
    });
    exhibitionOrdersList
        .map((e) => B2BCustomListingDataModel(
              id: e.id,
              strOrderName: e.strOrderName,
              strOrderId: e.strOrderId,
              strMarket: e.strMarket,
              strApprovedBy: e.strApprovedBy,
              strApprovedByImageUrl: e.strApprovedByImageUrl,
              strItems: e.strItems,
              strTotalAmount: e.strTotalAmount?.setCurrency,
              strMarketFlagImageUrl: e.strMarketFlagImageUrl,
            ))
        .toList();
    emit(ExhibitionDetailsLoadedState());
  }

  /// Populates the order list from the API data
  List<B2BCustomListingDataModel> _populateOrderList(List<OrderItem> dataList) {
    return dataList.map<B2BCustomListingDataModel>((OrderItem e) {
      return B2BCustomListingDataModel(
        id: e.uniqueId?.toString(),
        strOrderName: e.name,
        strOrderId: e.sId?.toString(),
        strMarket: e.name,
        strApprovedBy: e.createdByDetails?.fullName,
        strApprovedByImageUrl: e.name,
        strItems: e.items.toString(),
        strTotalAmount: e.totalPrice,
        strMarketFlagImageUrl: e.name,
      );
    }).toList();
  }

  void _loadMoreData(ExhibitionListingLoadMoreEvent event) {
    if (currentIndex == 0) {
      productPaginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    } else {
      orderScrollController.isPageLoaded.complete(event.currentPage == 3);
    }
  }

  void _initScrollControllers() {
    if (productPaginationScrollController.isInitialised) {
      productPaginationScrollController.dispose();
      productPaginationScrollController = SmartPaginationScrollController();
    }
    productPaginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(ExhibitionListingLoadMoreEvent(currentPage));
      },
    );

    if (isGrid) {
      productPaginationScrollController.controller.addListener(scrollToTopListener);
    }

    if (orderScrollController.isInitialised) {
      orderScrollController.dispose();
      orderScrollController = SmartPaginationScrollController();
    }
    orderScrollController.init(
      loadAction: (int currentPage) async {
        add(ExhibitionListingLoadMoreEvent(currentPage));
      },
    );
  }

  @override
  Future<void> close() {
    scrollController.removeListener(scrollToTopListener);
    productPaginationScrollController.dispose();
    orderScrollController.dispose();
    return super.close();
  }

  Future<void> _getExhibitionDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionListDataModel>? response = await AppRepository(context).fetchExhibitionDetails(id: id);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        exhibitionDetails = data;
      },
    );
  }

  Future<void> _getExhibitionProductDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionProductDetailsDataModel>? response = await AppRepository(context).fetchExhibitionProductDetails(id: id);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        exhibitionProductDetailsData = data;
      },
    );
  }

  /// Fetch diamond list
  Future<void> fetchDiamondList(BuildContext context, Emitter<ExhibitionDetailsState> emit,
      {required bool isLoadMore, Map<String, String>? query, required String exhibitionId}) async {
    final String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, DiamondListingModel>? response;
    query ??= {};
    CscDetails? cscCode = StorageManager().getSelectedCsc();
    print('cscCode: ${cscCode?.cscCode}');
    filterData
        .where((element) =>
            (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
            (element.filterType == FilterType.range && element.rangeValues != null))
        .forEach(
      (element) {
        if (element.filterType == FilterType.range) {
          query!['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
          query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
        } else {
          query![element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
        }
      },
    );

    query = {ApiKey.exhibitionId: exhibitionId};
    response = await AppRepository(context).fetchDiamondList(
      page: productPaginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
      limit: AppConst.pageLimit.toString(),
      type: type,
      sortKey: sortKey,
      sortValue: sortValue,
      query: query,
      headers: {ApiKey.cscCode: cscCode?.cscCode ?? ""},
    );
    _handleDiamondListResponse(emit: emit, response: response);
  }

  /// Handle diamond list response
  void _handleDiamondListResponse(
      {required Either<ErrorResponse, DiamondListingModel>? response, required Emitter<ExhibitionDetailsState> emit}) {
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      productList.clear();
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final diamondList = success.data;
      productList.addAll(
        diamondList.map((diamond) => _convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList(),
      );
      productPaginationScrollController.isPageLoaded.complete(productPaginationScrollController.currentPage == totalNumberOfPages);
    });
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertDiamondDataModelToProductDetailsModel({required DiamondDataModel diamond}) {
    return ProductDetailsModel(
      productId: diamond.id,
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      originalPrice: diamond.finalPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
      offerPrice: diamond.finalPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
      finalPrice: diamond.discountPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
      lotCode: diamond.lotCode,
      productSku: diamond.lotCode,
      shape: diamond.shape,
      fluorescence: diamond.fluorescence,
      labs: diamond.labs,
      lsp: diamond.lsp,
      color: diamond.color,
      clarity: diamond.clarity,
      cut: diamond.cut,
      certificateFile: diamond.certificateFile,
      openDnaUrl: diamond.openDnaUrl,
      commodity: Commodity.diamond,
      company: diamond.id,
      isFavourite: diamond.isFavorite,
      wishlistId: diamond.wishlistID,
      title: diamond.lotCode ?? "",
      subTitle: diamond.rmDescription ?? "",
      isForAuction: diamond.isAuction,
    );
  }

  static List<B2BCustomListingDataModel> _generateExhibitionOrdersList() {
    return List.generate(
      10,
      (index) => B2BCustomListingDataModel(
          strApprovedBy: "John Samanta",
          strApprovedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          strItems: '5',
          strTotalAmount: '\$35,700',
          strMarket: "New York, USA",
          strMarketFlagImageUrl: AppImages.icFlagUSA,
          strOrderName: "Dianne Russell",
          strOrderId: "ORD00${index + 1}",
          id: "${index + 1}"),
    );
  }

  ScrollController get scrollController {
    if (currentIndex == 0) {
      if (isGrid) {
        return productPaginationScrollController.scrollController;
      } else {
        return productPaginationScrollController.secondaryScrollController;
      }
    } else {
      return orderScrollController.scrollController;
    }
  }

  void scrollToKey() {
    RenderBox? renderBox = tabBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Scrollable.ensureVisible(
        tabBarKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTopListener() {
    RenderBox? renderBox = tabBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset position = renderBox.localToGlobal(Offset.zero);
      canScrollToTop.value = position.dy < 50.h;
    } else {
      canScrollToTop.value = false;
    }
  }
}
