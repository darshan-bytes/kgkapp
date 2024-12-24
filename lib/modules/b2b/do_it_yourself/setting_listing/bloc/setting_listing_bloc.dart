import 'package:kgk/kgk.dart';

part 'setting_listing_event.dart';

part 'setting_listing_state.dart';

class SettingListingBloc extends Bloc<SettingListingEvent, SettingListingState> {
  late AppBloc appBloc;
  DiyDiamondDataModel? diamondDataForDIY;
  bool isInitialToggle = true;
  bool isGrid = true;
  String sortKey = AppConst.sortKeySuid;
  String sortValue = AppConst.sortValueAsc;
  List<FilterData> filterData = [];
  final List<ProductDetailsModel> productList = [];
  final List<DiyStyleListModel> diyStyleList = [];
  int? totalNumberOfPages;
  String settingListingAppbarTitle = "DIY";

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  SettingListingBloc() : super(const SettingListingInitial()) {
    on<SettingListingInitialEvent>(_onSettingListingInitialEvent);
    on<SettingChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<LoadMoreSettingProductListEvent>(_onLoadMoreSettingProductListEvent);
    on<SettingListPullToRefreshEvent>(_onSettingListPullToRefresh);
  }

  Future<void> _onSettingListingInitialEvent(SettingListingInitialEvent event, Emitter<SettingListingState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(event.context);
    diamondDataForDIY = appBloc.diamondDataForDIY;
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreSettingProductListEvent(context: event.context, currentPage: currentPage));
      },
    );
    productList.clear();
    diyStyleList.clear();
    await _fetchSettingProductList(event.context, emit, false);

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }
    emit(const SettingLoadedState());
  }

  void _onChangeListingTypeEvent(SettingChangeListingTypeEvent event, Emitter<SettingListingState> emit) {
    emit(const SettingProductReloadState());
    isGrid = !isGrid;
    emit(SettingChangeListingTypeState());
  }

  Future<void> _onLoadMoreSettingProductListEvent(LoadMoreSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingLoadingMoreState());
    await _fetchSettingProductList(event.context, emit, true);

    emit(SettingProductLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onSettingListPullToRefresh(SettingListPullToRefreshEvent event, Emitter<SettingListingState> emit) async {
    paginationScrollController.pullToRefresh();
    await _fetchSettingProductList(event.context, emit, false);

    refreshCompleter.complete(true);
    emit(const SettingLoadedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(SettingListPullToRefreshEvent(context: context));
    bool result = await refreshCompleter.future;
    return result;
  }

  Future<void> _fetchSettingProductList(
    BuildContext context,
    Emitter<SettingListingState> emit,
    bool isLoadMore, {
    Map<String, String>? query,
  }) async {
    Either<ErrorResponse, PaginationData<DiyStyleListModel>>? response;

    query ??= {};

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

    if (diamondDataForDIY?.shapeCode != null) {
      query[ApiKey.shapeCode] = diamondDataForDIY?.shapeCode ?? '';
    }

    response = await AppRepository(context).diyStyleFilters(
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
      limit: AppConst.pageLimit.toString(),
      sortKey: sortKey,
      sortValue: sortValue,
      query: query,
    );

    response?.fold(
      (error) => Utils.showMessage(error.message),
      (PaginationData<DiyStyleListModel> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        final List<DiyStyleListModel> localList = (success.dataList ?? []) as List<DiyStyleListModel>;
        diyStyleList.addAll(localList);
        productList.addAll(localList.map((item) {
          return ProductDetailsModel(
            suid: item.suid ?? "",
            imageUrl: item.imageSketch,
            subTitle: item.autoDescription,
            originalPrice: item.finalPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
            offerPrice: item.discountPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
            finalPrice: item.discountPrice?.toString().toDouble?.toStringAsFixed(2).setCurrency,
            productId: item.suid ?? "",
            commodity: Commodity.jewellery,
            businessCategoryName: item.businessCategoryName ?? "",
            colorsCode: [item.metalColor1HexCode ?? ""],
          );
        }).toList());
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      },
    );
  }
}
