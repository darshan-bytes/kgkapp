import 'package:kgk/kgk.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  /// This product list is used to show the products in screen view
  List<ProductDetailsModel> productList = [];

  /// This wishlistDataList is used to store the wishlist data from API
  List<WishlistDatum> wishlistDataList = [];

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  int? totalNumberOfPages;

  WishlistBloc() : super(WishlistInitial()) {
    on<InitialWishlistEvent>(onInitialWishlistEvent);
    on<LoadMoreWishlistEvent>(_onLoadMoreWishlistEvent);
    on<WishlistPullToRefreshEvent>(_onWishlistPullToRefreshEvent);
    on<ProductRemoveFromWishlistEvent>(_onRemoveFromWishlistEvent);
    on<WishlistFilterEvent>(_onWishlistFilterEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> onInitialWishlistEvent(InitialWishlistEvent event, Emitter<WishlistState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onLoadMoreWishlistEvent(LoadMoreWishlistEvent event, Emitter<WishlistState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onWishlistPullToRefreshEvent(WishlistPullToRefreshEvent event, Emitter<WishlistState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onRemoveFromWishlistEvent(ProductRemoveFromWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistReloadState());
    productList.remove(event.productDetails);
    emit(WishlistDataFetchedState());
  }

  Future<void> _onWishlistFilterEvent(WishlistFilterEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    filterData = event.filterData;
    await fetchWishlistData(event.context, emit, isLoadMore: false);
    emit(WishlistDataFetchedState());
  }

  ///Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    _initializePagination(context);
    if (filterData.isEmpty) {
      await _setupFilters(context);

      ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchWishlistData(isLoadMore: false, context, emit);
    }
    emit(WishlistDataFetchedState());
  }

  /// Initialize pagination
  _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreWishlistEvent(context, currentPage));
      },
    );
  }

  /// Fetch wishlist data
  Future<void> fetchWishlistData(BuildContext context, Emitter<WishlistState> emit,
      {bool isLoadMore = false, Map<String, String>? query}) async {
    query ??= {};
    filterData.where((element) => (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false)).forEach(
      (element) {
        query![element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
      },
    );

    Either<ErrorResponse, WishlistModel>? response = await AppRepository(context).fetchWishList(
      limit: AppConst.pageLimit.toString(),
      page: paginationScrollController.currentPage.toString(),
      query: query,
      isLoadMore: isLoadMore,
    );
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      WishlistModel wishlistModel = success;
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      productList.addAll(populateProductList(success.data));
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(WishlistDataFetchedState());
    });
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<WishlistState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(WishlistLoadingMoreState());
      await fetchWishlistData(context, emit, isLoadMore: false);
      emit(WishlistLoadedMoreState(currentPage + 1));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    wishlistDataList.clear();
    await fetchWishlistData(context, emit, isLoadMore: false);
    emit(WishlistDataFetchedState());
  }

  /// Populate product list
  List<ProductDetailsModel> populateProductList(List<WishlistDatum> wishlistData) {
    List<ProductDetailsModel> productList = [];
    for (WishlistDatum element in wishlistData) {
      if (element.productData != null) {
        ProductDetailsModel product = ProductDetailsModel(
          productId: element.productId ?? '',
          imageUrl: (element.productData?.multipleFinishedViewImage)?.isNotNullNorEmpty ?? false
              ? element.productData!.multipleFinishedViewImage.first.imageUrl
              : "",
          title: _buildTitleOfProduct(element: element),
          subTitle: _buildSubTitleOfProduct(element: element),
          originalPrice: element.productData?.discountPrice?.setCurrency,
          commodity: element.displayCommodity,
          isFavourite: element.productData?.isFavorite ?? true,
          wishlistId: element.productData?.wishlistId ?? "",
          gms: element.displayCommodity == Commodity.jewellery ? element.productData?.gms : null,
          colorsCode: _buildColorsCode(element: element),
        );
        productList.add(product);
      }
    }
    return productList;
  }

  String? _buildTitleOfProduct({required WishlistDatum element}) {
    switch (element.displayCommodity) {
      case Commodity.jewellery:
        return (element.productData?.multipleFinishedViewImage)?.isNotNullNorEmpty ?? false
            ? element.productData!.multipleFinishedViewImage.first.contractNo ?? ""
            : null;
      case Commodity.gemstone:
      case Commodity.diamond:
        return element.productData?.lotCode;
      default:
        return null;
    }
  }

  String? _buildSubTitleOfProduct({required WishlistDatum element}) {
    switch (element.displayCommodity) {
      case Commodity.jewellery:
        return element.productData?.productDescription;
      case Commodity.gemstone:
      case Commodity.diamond:
        return element.productData?.rmDescription;
      default:
        return null;
    }
  }

  List<String>? _buildColorsCode({required WishlistDatum element}) {
    switch (element.displayCommodity) {
      case Commodity.jewellery:
        return [
          element.productData?.metalColor1HexCode ?? "",
        ];
      default:
        return null;
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchWishlistFilterOptionList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) {
      filterData.clear();
      if (success.filters.isNotNullNorEmpty) {
        for (Filters filterOption in success.filters ?? []) {
          List<SecondaryFilterData> secondaryData =
              filterOption.options?.map((option) => SecondaryFilterData(name: option.label, code: option.value)).toList() ?? [];
          FilterData filter = FilterData(
            name: filterOption.title,
            code: filterOption.key,
            inputType: filterOption.type,
            filterType: FilterType.checkbox,
            secondaryFilterData: secondaryData,
          );
          filterData.add(filter);
        }
      }
    });
  }
}
