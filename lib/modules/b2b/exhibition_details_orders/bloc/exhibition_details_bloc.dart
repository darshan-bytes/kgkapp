import 'package:kgk/kgk.dart';

part 'exhibition_details_event.dart';

part 'exhibition_details_state.dart';

class ExhibitionDetailsBloc extends Bloc<ExhibitionDetailsEvent, ExhibitionDetailsState> {
  String appbarTitle = '';
  int currentIndex = 0;
  bool isGrid = true;

  late TabController tabController;

  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.products.tr),
    Tab(text: APPStrings.orders.tr),
  ];

  List<B2BCustomListingDataModel> exhibitionOrdersList = [];

  List<ProductDetailsModel> productList = [];

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
    // on<ExhibitionProductDetailsEvent>(_onExhibitionProductDetailsEvent);
  }

  Future<void> _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionDetailsReloadState());
    isGrid = true;
    Map<RoutesData, dynamic>? data = event.context.routesData;
    String exhibitionId = data?[RoutesData.exhibitionId] ?? '';

    _initScrollControllers();
    await _getExhibitionDetails(event.context, exhibitionId);
    appbarTitle = exhibitionDetails.name ?? '';
    await _getExhibitionProductDetails(event.context, exhibitionId);

    productList.addAll(_generateProductList());
    exhibitionOrdersList.addAll(_generateExhibitionOrdersList());
    emit(const ExhibitionDetailsLoadedState());
  }

  void _onChangeTabEvent(ExhibitionChangeTabsEvent event, Emitter<ExhibitionDetailsState> emit) {
    emit(const ExhibitionDetailsReloadState());
    scrollController.removeListener(scrollToTopListener);
    currentIndex = tabController.index;
    scrollController.addListener(scrollToTopListener);
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

  Future<void> _onExhibitionProductDetailsEvent(ExhibitionProductDetailsEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionDetailsReloadState());
    // await _getExhibitionProductDetails(event.context, productId);
    emit(const ExhibitionDetailsLoadedState());
  }

  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionListingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    _loadMoreData(event);
    emit(ExhibitionListingLoadedMoreState(event.currentPage + 1));
  }

  void _loadMoreData(ExhibitionListingLoadMoreEvent event) {
    if (currentIndex == 0) {
      productList.addAll(_generateProductList());
      productPaginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    } else {
      exhibitionOrdersList.addAll(_generateExhibitionOrdersList());
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
        print("ExhibitionProductDetailsDataModel: ${exhibitionProductDetailsData.toJson()}");
      },
    );
  }

  static List<ProductDetailsModel> _generateProductList() {
    return List.generate(10, (index) {
      return ProductDetailsModel(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
      );
    });
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
