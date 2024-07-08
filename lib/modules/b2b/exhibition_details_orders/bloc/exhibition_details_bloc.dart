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

  List<ExhibitionDetailsOrdersModel> exhibitionOrdersList = [];

  List<ProductDetails> productList = [];

  SmartPaginationScrollController orderScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController productPaginationScrollController = SmartPaginationScrollController();

  final GlobalKey targetKey = GlobalKey();

  ExhibitionDetailsBloc() : super(const ExhibitionDetailsInitialsState()) {
    on<ExhibitionDetailsInitialEvent>(_onInitialEvent);
    on<ChangeExhibitionTabsEvent>(_onChangeTabEvent);
    on<ExhibitionListingLoadMoreEvent>(_onExhibitionListingLoadMoreEvent);
    on<ExhibitionChangeListingTypeEvent>(_onExhibitionChangeListingTypeEvent);
  }

  void _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) {
    emit(const ExhibitionDetailsReloadState());
    appbarTitle = APPStrings.exhibition.tr;
    isGrid = true;
    productList.clear();
    exhibitionOrdersList.clear();
    _initScrollControllers();
    productList.addAll(_generateProductList());
    exhibitionOrdersList.addAll(_generateExhibitionOrdersList());
    emit(const ExhibitionDetailsLoadedState());
  }

  void _onChangeTabEvent(ChangeExhibitionTabsEvent event, Emitter<ExhibitionDetailsState> emit) {
    emit(const ExhibitionDetailsReloadState());
    currentIndex = tabController.index;
    emit(const ChangeExhibitionTabsState());
  }

  void _onExhibitionChangeListingTypeEvent(ExhibitionChangeListingTypeEvent event, Emitter<ExhibitionDetailsState> emit) {
    emit(const ExhibitionDetailsReloadState());
    isGrid = event.isGrid;
    productPaginationScrollController.onViewChange(!isGrid);
    emit(const ExhibitionChangeListingTypeState());
  }

  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    emit(const ExhibitionListingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    _pageChanged(event);
    emit(ExhibitionListingLoadedMoreState(event.currentPage + 1));
  }

  void _pageChanged(ExhibitionListingLoadMoreEvent event) {
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
    productPaginationScrollController.dispose();
    orderScrollController.dispose();
    return super.close();
  }

  static List<ProductDetails> _generateProductList() {
    return List.generate(10, (index) {
      return ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
      );
    });
  }

  static List<ExhibitionDetailsOrdersModel> _generateExhibitionOrdersList() {
    return List.generate(
      10,
      (index) => ExhibitionDetailsOrdersModel(
          approvedBy: "John Samanta",
          approvedByImageUrl: "https://i.ibb.co/BLyLVHS/Frame-3978.png",
          items: '5',
          totalAmount: '\$35,700',
          market: "New York, USA",
          marketImageUrl: AppImages.icFlagUSA,
          orderName: "Dianne Russell",
          id: index + 1),
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
}
