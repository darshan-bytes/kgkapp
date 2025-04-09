import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/landing/landing_modules/home/mode/home_strapi_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late AppBloc appBloc;

  //Jewellery List
  final List<AuctionListModel> jewelleryList = [];

  //Engagement List With slider controller
  int currentCarouselIndex = 0;
  final CarouselSliderController engagementListCarouselController = CarouselSliderController();
  final List<AuctionListModel> engagementList = _generateEngagementList();
  final List<AuctionListModel> latestCollectionList = _generateLatestCollection();

  final List<AuctionListModel> trendingList = _generateTrendingList();

  final List<AuctionListModel> popularList = _generatePopularList();
  final List<AuctionListModel> exploreFancyColorDiamondsList = _generateFancyColorDiamondsList();

  //Shop Diamonds List
  List<AuctionListModel> shopDiamondsList = [];
  List<ShapeMasterDetails> shopDiamondsShapeMasterList = [];

  //Shop Rings List
  final List<AuctionListModel> shopByBrands = _generateShopByBrands();

  //Shop Gemstones List
  List<AuctionListModel> shopGemstonesList = [];

  //Shop Gemstones2 List
  final List<AuctionListModel> shopGemstones2List = _generateShopGemstones2List();

  //Top Selling Categories
  final List<AuctionListModel> topSellingCategoriesList = [];

  final List<AuctionListModel> eliganceList = _generateEliganceList();

  final List<AuctionListModel> eliganceList2 = _generateEligance2List();

  final List<AuctionListModel> shopBySpacificCategory = _generateShopBySpacificCategory();

  final List<AuctionListModel> eliganceList3 = _generateEligance3List();

  List<Home> homeStrapiList = [];
  HomeStrapiModel? homeStrapiModel;

  int kgkCoutureSelectedIndex = 0;

  List<String> kgkCoutureButtonsTitle = [
    APPStrings.all,
  ];
  List<ProductDetailsModel> luminousProductViewList = [];

  //Create Your Own Signature piece
  OrderStoneTypeModel selectedStep1StoneType = const OrderStoneTypeModel(name: "Gemstone");
  OrderStoneTypeModel selectedStep2RingType = const OrderStoneTypeModel(name: "Ring");

  //Scroll Controller
  final ScrollController shopDiamondsScrollController = ScrollController();
  final ScrollController shopGemstonesScrollController = ScrollController();
  final ScrollController shopByBrandsScrollController = ScrollController();

  final List<OrderStoneTypeModel> arrStoneType = [
    const OrderStoneTypeModel(name: "Gemstone"),
    const OrderStoneTypeModel(name: "Jewellery"),
  ];

  final List<OrderStoneTypeModel> arrRingType = [
    const OrderStoneTypeModel(name: "Ring"),
    const OrderStoneTypeModel(name: "Bracelet"),
    const OrderStoneTypeModel(name: "Earring"),
    const OrderStoneTypeModel(name: "Necklace"),
    const OrderStoneTypeModel(name: "Anklet"),
  ];

  //Deal of the day With Scroll controller
  final ScrollController dealOfTheDayScrollController = ScrollController();

  /// Deal of the day for the jewellery
  List<ProductDetailsModel> dealOfTheDayJewelleryList = [];

  /// Deal of the day for the diamonds
  List<ProductDetailsModel> dealOfTheDayDiamondList = [];

  /// Deal of the day for the gemstones
  List<ProductDetailsModel> dealOfTheDayGemstoneList = [];

  //Get Inspired With Scroll controller
  // final List<AuctionListModel> getInspiredList = _generateGetInspireList();

  final List<AuctionListModel> getInspiredList = _generateGetInspireList();

  //Shop By Style List
  final List<AuctionListModel> shopByStyleList = _generateShopByStyleList();

  //Recently Viewed
  final ScrollController recentlyViewedScrollController = ScrollController();
  List<ProductDetailsModel> recentlyViewedJewelleryList = [];
  List<ProductDetailsModel> recentlyViewDiamondList = [];
  List<ProductDetailsModel> recentlyViewGemstoneList = [];

  int currentPageIndex = 0;
  PageController categoryPageController = PageController();

  final List<AuctionListModel> categoryList = _generateCategoriesList();

  static const int categoryPerPageLength = 6;

  int get categoryPageLength => categoryList.length <= categoryPerPageLength
      ? 1
      : categoryList.length % categoryPerPageLength == 0
          ? (categoryList.length ~/ categoryPerPageLength)
          : (categoryList.length ~/ categoryPerPageLength) + 1;

  Completer<bool> refreshCompleter = Completer<bool>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<HomeJewelleryImagePageChangeEvent>(_onHomeJewelleryImagePageChangeEvent);
    on<HomeSelectStoneChangeTypeEvent>(_onChangeHomeStep1StoneTypeEvent);
    on<HomeSelectJewelleryChangeTypeEvent>(_onChangeHomeStep2StoneTypeEvent);
    on<HomeKgkCoutureSelectionChangeEvent>(_onHomeKgkCoutureSelectionChangeEvent);
    on<HomeCategoryPageChangeEvent>(_onHomeCategoryPageChangeEvent);
    on<HomePullToRefreshEvent>(_onHomePullToRefreshEvent);
  }

  void _onHomePullToRefreshEvent(HomePullToRefreshEvent event, Emitter<HomeState> emit) async {
    emit(const HomeReloadState());
    kgkCoutureSelectedIndex = 0;
    await fetchStrapiData(event.context);
    await fetchKgkCoutureData(event.context);
    emit(const HomeStrapiDataFetchedState());
    refreshCompleter.complete(true);
  }

  /// Fetch Bag Data Because Add Logic For Add To Bag
  Future<void> fetchListOfBag(BuildContext context) async {
    if (!context.mounted) context = getNavigatorKeyContext;
    try {
      String id = StorageManager().getBagId() ?? '';
      if (id.isNullOrEmpty) return;
      Either<ErrorResponse, BagListDataModel>? response;
      response = await AppRepository(context).getBagListData(id: id, isShowLoader: false);
      response?.fold((l) {
        //Utils.showMessage(l.message);
      }, (r) async {
        if (!context.mounted) context = getNavigatorKeyContext;
        String? bagId = StorageManager().getBagId();
        BlocProvider.of<LandingBloc>(context).add(LandingChangeMyBagCountEvent(r.result.length));
        if (r.result.isNotEmpty && bagId.isNotNullNorEmpty) {
          MyBagDataModel myBagDataModel = MyBagDataModel(status: true, commodity: r.result[0].commodity, sId: bagId);

          await StorageManager().storeBagData(myBagDataModel);
        }
      });
    } catch (e) {
      // Utils.showMessage(e.toString());
    }
  }

  void _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(event.context);
    currentPageIndex = 0;
    kgkCoutureSelectedIndex = 0;
    currentCarouselIndex = 0;
    await fetchListOfBag(event.context);
    await fetchStrapiData(event.context);
    await shapeMasterFilters(event.context);
    await fetchCommodityMasterFilters(event.context);
    await fetchKgkCoutureData(event.context);
    await getJewelleryProductRecentlyViewed(event.context);
    await getDiamondProductRecentlyViewed(event.context);
    await getGemstoneProductRecentlyViewed(event.context);
    await _getJewelleryDealOfTheDayAPICall(event.context);
    await _getDiamondDealOfTheDayAPICall(event.context);
    await _getGemstoneDealOfTheDayAPICall(event.context);
    emit(const HomeReloadState());
    emit(const HomeStrapiDataFetchedState());
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    refreshCompleter.complete(true);
    emit(HomeInitial());
  }

  void _onHomeJewelleryImagePageChangeEvent(HomeJewelleryImagePageChangeEvent event, Emitter<HomeState> emit) {
    emit(const HomeReloadState());
    currentCarouselIndex = event.index;
    emit(HomeJewelleryImagePageChangeState());
  }

  void _onChangeHomeStep1StoneTypeEvent(HomeSelectStoneChangeTypeEvent event, Emitter<HomeState> emit) {
    emit(const HomeReloadState());
    selectedStep1StoneType = event.selectedStep1StoneType;
    emit(HomeSelectStoneTypeChangeState());
  }

  void _onChangeHomeStep2StoneTypeEvent(HomeSelectJewelleryChangeTypeEvent event, Emitter<HomeState> emit) {
    emit(const HomeReloadState());
    selectedStep2RingType = event.selectedStep2RingType;
    emit(HomeSelectJewelleryTypeChangeState());
  }

  Future<void> _onHomeKgkCoutureSelectionChangeEvent(HomeKgkCoutureSelectionChangeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeReloadState());
    int old = kgkCoutureSelectedIndex;
    kgkCoutureSelectedIndex = event.index;
    emit(HomeKgkCoutureSelectionChangeState(kgkCoutureSelectedIndex, old));
    await fetchKgkCoutureData(event.context);
    emit(const HomeStrapiDataFetchedState());
  }

  void _onHomeCategoryPageChangeEvent(HomeCategoryPageChangeEvent event, Emitter<HomeState> emit) {
    emit(const HomeReloadState());
    currentPageIndex = event.index;
    emit(HomeCategoryPageChangeState(event.index));
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(HomePullToRefreshEvent(context: context));
    return refreshCompleter.future;
  }

  //For Engagement List
  static List<AuctionListModel> _generateEngagementList() {
    List<String> imageList = [
      "https://i.ibb.co/tXQzK2j/Main-Banner1.jpg",
      "https://i.ibb.co/5cCtJPM/Main-Banner2.jpg",
      "https://i.ibb.co/4sSxLwF/Main-Banner3.jpg",
      "https://i.ibb.co/pz6MHRt/Main-Banner4.jpg"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  static List<AuctionListModel> _generateLatestCollection() {
    List<String> imageList = [
      "https://i.ibb.co/1fckq7Y/Single-Banner3.png",
      "https://i.ibb.co/GJC8rbV/Single-Banner4.png",
      "https://i.ibb.co/1fckq7Y/Single-Banner3.png",
      "https://i.ibb.co/GJC8rbV/Single-Banner4.png",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  static List<AuctionListModel> _generateShopByBrands() {
    List<String> nameList = [
      "Martin Flyer",
      "Entice",
      "Gregg Ruth",
      "Avita",
      "Martin Flyer",
      "Entice",
      "Gregg Ruth",
      "Avita",
      "Martin Flyer",
      "Entice",
      "Gregg Ruth",
      "Avita",
      "Martin Flyer",
      "Entice",
      "Gregg Ruth",
      "Avita"
    ];
    List<String> imageList = [
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
      "https://i.ibb.co/NNvhL4X/Image111.png",
      "https://i.ibb.co/r2Rb6y4/Image222.png",
      "https://i.ibb.co/yFhcvJM/Image333.png",
    ];
    return List.generate(
      nameList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //For Shop gemstones List
  static List<AuctionListModel> _generateShopGemstones2List() {
    List<String> nameList = [
      "SIDE-STONE",
      "HALO",
      "SOLITAIRE",
      "PAVE",
      "THREE-STONE",
      "VINTAGE",
      "CHANNEL SET",
      "TENSION",
    ];
    List<String> imageList = [
      "https://i.ibb.co/5M8fY0K/Ring1.png",
      "https://i.ibb.co/HnCgLGp/Ring2.png",
      "https://i.ibb.co/q9bQG8r/Ring3.png",
      "https://i.ibb.co/v4H3W92/Ring4.png",
      "https://i.ibb.co/PrjYxLr/Ring5.png",
      "https://i.ibb.co/D59FyN6/Ring6.png",
      "https://i.ibb.co/Wp8w6ht/Ring7.png",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //For Eligance List
  //For Top Selling Categories
  static List<AuctionListModel> _generateEliganceList() {
    List<String> imageList = [
      "https://i.ibb.co/GHLpDkC/Shopby1.png",
      "https://i.ibb.co/pLdn2mS/Shopby2.png",
      "https://i.ibb.co/FKH9Xz8/Shopby3.png",
      "https://i.ibb.co/vDw6mRT/Shopby4.png"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  //_generateEligance2List
  static List<AuctionListModel> _generateEligance2List() {
    List<String> imageList = [
      "https://i.ibb.co/2gbkgWX/Elegance1.jpg",
      "https://i.ibb.co/qDHqD5b/Elegance2.jpg",
      "https://i.ibb.co/w4CmR5w/Elegance3.jpg",
      "https://i.ibb.co/44FBc6T/Elegance4.jpg"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  //_generateEligance2List
  static List<AuctionListModel> _generateShopBySpacificCategory() {
    List<String> name = ["Metal", "Stone", "Colour", "Style", "Test"];
    List<String> imageList = [
      "https://i.ibb.co/2gbkgWX/Elegance1.jpg",
      "https://i.ibb.co/qDHqD5b/Elegance2.jpg",
      "https://i.ibb.co/w4CmR5w/Elegance3.jpg",
      "https://i.ibb.co/44FBc6T/Elegance4.jpg",
      "https://i.ibb.co/44FBc6T/Elegance4.jpg",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: name[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //_generateEligance2List
  static List<AuctionListModel> _generateEligance3List() {
    List<String> imageList = [
      "https://i.ibb.co/518CBsv/Shop-By-Metal-Type1.jpg",
      "https://i.ibb.co/28DXhtX/Shop-By-Metal-Type2.jpg",
      "https://i.ibb.co/64fzTc3/Shop-By-Metal-Type3.jpg",
      "https://i.ibb.co/FWJbb8L/Shop-By-Metal-Type4.jpg"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  //For Tab View
  static List<ProductDetailsModel> _generateTabViewList({bool isOfferAvailable = false}) {
    return List.generate(
      20,
      (index) => ProductDetailsModel(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
        discountPercentageString: isOfferAvailable ? APPStrings.youHaveSavedX.tr.interpolate(["10%"]) : null,
        finalPrice: isOfferAvailable ? '\$4,000.00' : null,
      ),
    );
  }

  Future<void> getJewelleryProductRecentlyViewed(BuildContext context) async {
    String recentlyViewedJewellery = StorageManager().getRecentlyViewedJewellery();

    String? token = StorageManager().getAuthToken();

    if (token.isNullOrEmpty && recentlyViewedJewellery.isNullOrEmpty) return;

    Either<ErrorResponse, JewelleryListingModel>? response = await AppRepository(context).getRecentlyViewedProductList(
      page: AppConst.page1.toString(),
      limit: AppConst.pageLimit10.toString(),
    );
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewedJewelleryList = data.data.map((e) {
          return Utils.convertJewelleryDataModelToProductDetailsModel(jewellery: e);
        }).toList();
      },
    );
  }

  Future<void> getDiamondProductRecentlyViewed(BuildContext context) async {
    String recentlyViewedDiamond = StorageManager().getRecentlyViewedDiamond();

    String? token = StorageManager().getAuthToken();
    if (token.isNullOrEmpty && recentlyViewedDiamond.isNullOrEmpty) return;
    Either<ErrorResponse, DiamondListingModel>? response = await AppRepository(context).getDiamondRecentlyViewedProductList(
      page: AppConst.page1.toString(),
      limit: AppConst.pageLimit10.toString(),
    );
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewDiamondList = data.data.map((e) {
          return Utils.convertDiamondDataModelToProductDetailsModel(diamond: e);
        }).toList();
      },
    );
  }

  ProductDetailsModel _convertDiamondDataModelToProductDetailsModel({required DiamondDataModel diamond}) {
    return ProductDetailsModel(
      suid: diamond.suid,
      productId: diamond.suid,
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      originalPrice: diamond.finalPrice?.toString().setCurrency,
      finalPrice: diamond.discountPrice?.toString().setCurrency,
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
      isAddedToCart: diamond.isAddedToCart,
    );
  }

  Future<void> getGemstoneProductRecentlyViewed(BuildContext context) async {
    String recentlyViewedGemstone = StorageManager().getRecentlyViewedGemstone();

    String? token = StorageManager().getAuthToken();
    if (token.isNullOrEmpty && recentlyViewedGemstone.isNullOrEmpty) return;

    Either<ErrorResponse, GemstoneListingModel>? response = await AppRepository(context).getGemstoneRecentlyViewedProductList(
      page: AppConst.page1.toString(),
      limit: AppConst.pageLimit10.toString(),
    );
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewGemstoneList = data.data.map((e) {
          return Utils.convertGemstoneDatumToProductDetailsModel(gemstone: e);
        }).toList();
      },
    );
  }

  //For Get Inspired
  static List<AuctionListModel> _generateGetInspireList() {
    List<String> imageList = [
      "https://i.ibb.co/fGQnv1D/Shop-By-Colour1.png",
      "https://i.ibb.co/cTvkXwZ/Shop-By-Colour2.png",
      "https://i.ibb.co/VQcXnTg/Shop-By-Colour3.png",
      "https://i.ibb.co/G0Ptgz2/Shop-By-Colour4.png"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: imageList[index],
      ),
    );
  }

  static List<AuctionListModel> _generateShopByStyleList() {
    List<String> titleList = ["Moissanite rings", "Aquamarine rings", "Morganite rings", "Gemstone jewelry"];
    List<String> imageList = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/x1q3y0C/Image11.png",
      "https://i.ibb.co/G7RH7k4/Image22.png",
      "https://i.ibb.co/XYsTf4M/Image33.png"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: titleList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //For Trending List
  static List<AuctionListModel> _generateTrendingList() {
    List<String> titleList = ["Moissanite rings", "Aquamarine rings", "Morganite rings", "Gemstone jewelry "];
    List<String> imageList = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/x1q3y0C/Image11.png",
      "https://i.ibb.co/G7RH7k4/Image22.png",
      "https://i.ibb.co/XYsTf4M/Image33.png"
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: titleList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //For Popular List
  static List<AuctionListModel> _generatePopularList() {
    List<String> percentageList = ["40% off", "20% off", "30% Off", "10% off"];
    List<String> titleList = ["Offer", "Offer", "Offer", "Offer"];
    List<String> imageList = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/x1q3y0C/Image11.png",
      "https://i.ibb.co/G7RH7k4/Image22.png",
      "https://i.ibb.co/XYsTf4M/Image33.png"
    ];
    return List.generate(
      imageList.length,
      (index) =>
          AuctionListModel(id: index.toString(), name: titleList[index], imageUrl: imageList[index], percentageOff: percentageList[index]),
    );
  }

  static List<AuctionListModel> _generateFancyColorDiamondsList() {
    // List<String> percentageList = ["40% off", "20% off", "30% Off", "10% off"];
    // List<String> titleList = ["Offer", "Offer", "Offer", "Offer"];
    List<String> imageList = [
      "https://i.ibb.co/t2vyNp1/orange-diamond.png",
      "https://i.ibb.co/wSksxzZ/pink-diamond.png",
      "https://i.ibb.co/3SN5S8h/purple-diamond.png",
      "https://i.ibb.co/DrGnpqL/red-diamond.png",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        /*name: titleList[index],*/ imageUrl: imageList[index], /*percentageOff: percentageList[index]*/
      ),
    );
  }

  static List<AuctionListModel> _generateCategoriesList() {
    List<String> nameList = [
      "PENDANT",
      "RING",
      "SETS",
      "SILVER CHAINS",
      "MANGALSUTRAS",
      "NOSE PINS",
      // "Pendant",
      // "Earrings",
      // "Ring",
      // "Bracelet",
      // "Necklace",
      // "Anklet",
      // "Chain",
      // "Sets",
      // "Studs",
      // "Hoops",
      // "Drop Earrings",
      // "Chandelier Earrings",
      // "Ear Cuffs",
      // "Bangles",
      // "Cuffs",
      // "Charm Bracelets",
      // "Tennis Bracelets",
      // "Beaded Bracelets",
      // "Brooches",
      // "Pins",
      // "Cufflinks",
      // "Body Jewelry",
      // "Belly Chains",
      // "Nose Rings",
      // "Nipple Rings",
      // "Eyebrow Rings",
      // "Tongue Rings",
      // "Tiara",
      // "Headpieces",
      // "Lockets",
      // "Medallions",
      // "Cameos",
      // "Armlets",
      // "Toe Rings",
      // "Toe Rings 1",
    ];

    List<String> imageList = [
      "https://i.ibb.co/Wc9ZQRr/Category1.jpg",
      "https://i.ibb.co/YBPwZ8K/Category2.jpg",
      "https://i.ibb.co/tL0c3VV/Category3.jpg",
      "https://i.ibb.co/Lv1RCdc/Category4.jpg",
      "https://i.ibb.co/8msvLfL/Category5.jpg",
      "https://i.ibb.co/QdsWS2s/Category6.jpg",
      "https://i.ibb.co/MC3vvzm/Category7.png",
      "https://i.ibb.co/ZB1zbvq/Category8.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      // "https://i.ibb.co/1f3SHWg/image-18653.png",
      // "https://i.ibb.co/5jmqMcF/image-18654.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
      // "https://i.ibb.co/vBG9fzy/image-18655.png",
    ];

    return List.generate(
      nameList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  /// Fetches the Strapi data from the server
  Future<void> fetchStrapiData(BuildContext context) async {
    homeStrapiList.clear();
    await AppRepository(context).fetchStrapiHomeData().then((value) async {
      value.fold((l) {}, (r) {
        homeStrapiList = r;
      });
    });
  }

  /// Returns the widgets based on the [HomeSlug]
  Widget getWidgetsForHomeSlug(
    BuildContext context,
    HomeSlug slug,
    HomeBloc homeBloc,
    HomeScreenStyle style,
    int index,
  ) {
    List<AuctionListModel> parseDataList(dynamic data) {
      List<AuctionListModel> dataList = [];
      if (data is List) {
        for (var element in data) {
          final imageUrl = element['image']?['data']?['attributes']?['url'];
          String redirectTo = element['redirectTo'];
          String? name = element['title'];
          String redirectionType = element['redirectionType'];
          String? redirectionUrl = element['redirection_url'];

          if (imageUrl != null) {
            dataList.add(AuctionListModel(
              id: element['id']?.toString(),
              imageUrl: "${AppConst.strapiQaEnvImgBaseUrl}$imageUrl",
              redirectTo: redirectTo,
              redirectionType: redirectionType,
              name: name,
              redirectionUrl: redirectionUrl,
            ));
          }
        }
      }
      return dataList;
    }

    switch (slug) {
      case HomeSlug.mobileProductCategories:
        return HomeWidgets.buildJewelleryList(
          homeStrapiList[index].title ?? '',
          homeBloc,
          style,
          parseDataList(homeStrapiList[index].data),
        );

      case HomeSlug.mobileHomeBanner:
        return HomeWidgets.buildEngagementImageSlider(
          homeBloc,
          parseDataList(homeStrapiList[index].data),
        );

      case HomeSlug.mobileTopSellingCategories:
        return HomeWidgets.buildTopSellingCategories(
          homeBloc,
          homeStrapiList[index].title,
          style,
          parseDataList(homeStrapiList[index].data),
          context: context,
        );

      case HomeSlug.mobileViewAllCollection:
        final imageUrl = homeStrapiList[index].data['image']?['data']?['attributes']?['url'];
        String redirectTo = homeStrapiList[index].data['redirectTo'];
        String redirectionType = homeStrapiList[index].data['redirectionType'];
        String? redirectionUrl = homeStrapiList[index].data['redirection_url'];
        return HomeWidgets.buildViewAllCollectionsSection(
          homeBloc,
          style,
          context: context,
          url: imageUrl != null ? "${AppConst.strapiQaEnvImgBaseUrl}$imageUrl" : '',
          redirectTo: redirectTo,
          redirectionType: redirectionType,
          title: homeStrapiList[index].data['title'].toString(),
          redirectionUrl: redirectionUrl,
        );

      case HomeSlug.mobileGetInspired:
        return HomeWidgets.buildGetInspiredSection(
          context,
          homeStrapiList[index].title,
          homeBloc,
          style,
          parseDataList(homeStrapiList[index].data),
        );

      case HomeSlug.mobileShopByStyle:
        List<AuctionListModel> dataList = parseDataList(homeStrapiList[index].data);
        if (dataList.isEmpty) {
          return SizedBox.shrink();
        }
        return HomeWidgets.buildShopByStyleSection(
          homeBloc,
          style,
          dataList,
        );

      case HomeSlug.mobileDIYGuidance:
        final title = homeStrapiList[index].data['title'].toString();
        final subTitle = homeStrapiList[index].data['tagline'].toString();
        return HomeWidgets.buildCreateYourOwnSignaturePiece(
          homeBloc,
          style,
          context: context,
          title: title,
          subTitle: subTitle,
        );

      case HomeSlug.kgkDiamondShape:
        return Container();
      // return HomeWidgets.buildShopDiamondSection(homeBloc, style);

      case HomeSlug.kgkGemstone:
        return Container();

      case HomeSlug.mobileShopDiamonds:
        final title = homeStrapiList[index].info?.title ?? '';
        return HomeWidgets.buildShopDiamondSection(homeBloc, style, title);

      case HomeSlug.mobileShopGemstone:
        return HomeWidgets.buildShopGemstoneSection(homeBloc, style,
            title: homeStrapiList[index].info?.title ?? APPStrings.shopGemstones.tr);

      case HomeSlug.mobileKGKCouture:
        return HomeWidgets.buildKGKCoutureTabBarSection(homeBloc, style, homeStrapiList[index].info?.title, context: context);

      case HomeSlug.mobileRecentlyViewed:
        if (homeStrapiList[index].category == 'jewellery' && homeBloc.recentlyViewedJewelleryList.isNotNullNorEmpty) {
          return HomeWidgets.buildRecentlyViewedSection(homeStrapiList[index].info?.title ?? APPStrings.recentlyViewedJewellery.tr,
              homeBloc, style, homeBloc.recentlyViewedJewelleryList, ScreenIdentifier.productForRing,
              context: context);
        } else if (homeStrapiList[index].category == 'diamond' && homeBloc.recentlyViewDiamondList.isNotNullNorEmpty) {
          return HomeWidgets.buildRecentlyViewedSection(homeStrapiList[index].info?.title ?? APPStrings.recentlyViewedDiamond.tr, homeBloc,
              style, homeBloc.recentlyViewDiamondList, ScreenIdentifier.productForDiamonds,
              context: context, isCrtAndGramVisible: false);
        } else if (homeStrapiList[index].category == 'gemstone' && homeBloc.recentlyViewGemstoneList.isNotNullNorEmpty) {
          return HomeWidgets.buildRecentlyViewedSection(homeStrapiList[index].info?.title ?? APPStrings.recentlyViewedGemstone.tr, homeBloc,
              style, homeBloc.recentlyViewGemstoneList, ScreenIdentifier.productForGemstones,
              context: context, isCrtAndGramVisible: false);
        }

        return SizedBox.shrink();

      case HomeSlug.mobileDealsOfDay:
        if (homeStrapiList[index].category == 'diamond' && homeBloc.dealOfTheDayDiamondList.isNotNullNorEmpty) {
          return HomeWidgets.buildDealOfTheDaySection(
              homeBloc: homeBloc,
              style: style,
              title: homeStrapiList[index].info?.title,
              screenIdentifier: ScreenIdentifier.productForDiamonds,
              arrProductList: homeBloc.dealOfTheDayDiamondList,
              context: context,
              isCrtAndGramVisible: false);
        } else if (homeStrapiList[index].category == 'gemstone' && homeBloc.dealOfTheDayGemstoneList.isNotNullNorEmpty) {
          return HomeWidgets.buildDealOfTheDaySection(
            homeBloc: homeBloc,
            style: style,
            title: homeStrapiList[index].info?.title,
            screenIdentifier: ScreenIdentifier.productForGemstones,
            arrProductList: homeBloc.dealOfTheDayGemstoneList,
            context: context,
            isCrtAndGramVisible: false,
          );
        } else if (homeStrapiList[index].category == 'jewellery' && homeBloc.dealOfTheDayJewelleryList.isNotNullNorEmpty) {
          return HomeWidgets.buildDealOfTheDaySection(
            homeBloc: homeBloc,
            style: style,
            title: homeStrapiList[index].info?.title,
            screenIdentifier: ScreenIdentifier.productForRing,
            arrProductList: homeBloc.dealOfTheDayJewelleryList,
            context: context,
            isCrtAndGramVisible: false,
          );
        }
        return Container();

      case HomeSlug.unknown:
        //TODO: For KGK Couture _buildKGKCoutureTabBarSection(homeBloc, style, context: context)

        // TODO: For shop by diamond _buildShopDiamondSection(homeBloc, style)

        return const SizedBox.shrink();
    }
  }

  /// Handles redirection based on the [redirectTo] and [redirectionType]
  void handleRedirection({
    required BuildContext context,
    required RedirectionTo redirectTo,
    required RedirectionType redirectionType,
    Map<dynamic, dynamic>? redirectionData,
    String? redirectionTitle,
  }) {
    Map<RoutesData, dynamic>? arguments;
    String routeName;

    switch (redirectTo) {
      case RedirectionTo.gemstone:
        if (redirectionData == null || redirectionData.isEmpty || redirectTo.name.isEmpty || redirectionType.name.isEmpty) return;
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.stoneDetailPage : AppRoutes.stoneListingPage;
        arguments = {
          RoutesData.isPageFor: ScreenIdentifier.productForGemstones,
          RoutesData.filterData: redirectionData,
        };
        break;

      case RedirectionTo.diamond:
        if (redirectionData == null || redirectionData.isEmpty || redirectTo.name.isEmpty || redirectionType.name.isEmpty) return;
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.productDetailsPage : AppRoutes.stoneListingPage;
        arguments = {
          RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
          RoutesData.filterData: redirectionData,
        };
        break;

      case RedirectionTo.jewellery:
        if (redirectionData == null || redirectionData.isEmpty || redirectTo.name.isEmpty || redirectionType.name.isEmpty) return;
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.productDetailsPage : AppRoutes.productListGridPage;
        arguments = {
          RoutesData.isPageFor: ScreenIdentifier.productForRing,
          RoutesData.filterData: redirectionData,
        };
        break;
      case RedirectionTo.collection:
        if (redirectionData == null || redirectTo.name.isEmpty || redirectionType.name.isEmpty) return;
        routeName =
            (redirectionType == RedirectionType.listing || redirectionType == RedirectionType.collection) && redirectionData.isNotEmpty
                ? AppRoutes.productListGridPage
                : AppRoutes.collectionPage;
        arguments = (redirectionType == RedirectionType.listing || redirectionType == RedirectionType.collection)
            ? {
                RoutesData.isPageFor: ScreenIdentifier.productForRing,
                RoutesData.filterData: redirectionData,
                RoutesData.appBarTitle: APPStrings.collection.tr,
              }
            : {};
        break;

      case RedirectionTo.unknown:
        printWrapped('Unknown redirection');
        return; // Exit early for unknown redirection
    }

    if (redirectionType == RedirectionType.details) {
      arguments[RoutesData.productId] = redirectionData[RoutesData.productId];
    }

    if (redirectionTitle.isNotNullNorEmpty) {
      arguments[RoutesData.appBarTitle] = redirectionTitle;
    }

    context.pushNamed(routeName, arguments: arguments);
  }

  Future<void> fetchKgkCoutureData(BuildContext context) async {
    try {
      String? kgkCollection = kgkCoutureSelectedIndex == 0 ? null : kgkCoutureButtonsTitle[kgkCoutureSelectedIndex];
      final response = await AppRepository(context).homePageKgkCoutureCollections(
          page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString(), kgkCollection: kgkCollection, isLoadMore: true);
      response?.fold(
        (l) {
          //Utils.showMessage(l.message);
        },
        (r) {
          kgkCoutureButtonsTitle = [
            APPStrings.all,
            ...(r.kgkCollectionList ?? []),
          ];
          luminousProductViewList = List.generate(
            r.dataList?.length ?? 0,
            (index) {
              KgkCoutureDetails item = r.dataList![index];
              return ProductDetailsModel(
                productId: item.suid ?? '',
                commodity: Commodity.jewellery,
                imageUrl: item.multipleFinishedViewImage ?? '',
                title: item.jewelleryTypeName ?? '',
                subTitle: item.productDescription ?? '',
                originalPrice: item.finalPrice?.toString().setCurrency ?? '-',
                finalPrice: item.discountPrice?.toString().setCurrency ?? '',
              );
            },
          );
        },
      );
    } catch (e) {
      // Utils.showMessage(e.toString());
    }
  }

  Future<void> shapeMasterFilters(BuildContext context) async {
    try {
      shopDiamondsShapeMasterList = await appBloc.fetchShapeMasterFilters(context, isShowLoader: false);
      shopDiamondsList = List.generate(shopDiamondsShapeMasterList.length, (index) {
        ShapeMasterDetails item = shopDiamondsShapeMasterList[index];
        return AuctionListModel(
          id: item.id?.toString() ?? '',
          name: item.shapeName,
          imageUrl: item.image ?? '',
          redirectTo: RedirectionTo.diamond.toString(),
        );
      });
    } catch (e) {
      // Utils.showMessage(e.toString());
      printWrapped('Error in fetching shape master filters: $e');
    }
  }

  Future<void> fetchCommodityMasterFilters(BuildContext context) async {
    try {
      final response = await appBloc.fetchHomeGemstiones(context, isShowLoader: false);
      shopGemstonesList = List.generate(response.length, (index) {
        HomeGemstonesModel item = response[index];
        return AuctionListModel(
          id: item.id?.toString() ?? '',
          name: item.commodityName,
          imageUrl: item.image ?? '',
          redirectTo: RedirectionTo.jewellery.toString(),
          subTypeCode: item.subTypeCode,
        );
      });
    } catch (e) {
      // Utils.showMessage(e.toString());
      printWrapped('Error in fetching shape master filters: $e');
    }
  }

  Future<void> _getJewelleryDealOfTheDayAPICall(BuildContext context) async {
    final Either<ErrorResponse, JewelleryListingModel>? response = await AppRepository(context).getJewelleryDealOfTheDayProductList(
      page: AppConst.page1.toString(),
      limit: AppConst.pageLimit10.toString(),
    );

    response?.fold(
      (error) {
        if (error.message?.isNotEmpty == true) {
          Utils.showMessage(error.message!);
        }
      },
      (data) {
        dealOfTheDayJewelleryList = data.data.map((e) => Utils.convertJewelleryDataModelToProductDetailsModel(jewellery: e)).toList();
      },
    );
  }

  Future<void> _getGemstoneDealOfTheDayAPICall(BuildContext context) async {
    Map<String, String> queryParams = {
      ApiKey.page: AppConst.page1.toString(),
      ApiKey.limit: AppConst.pageLimit10.toString(),
      ApiKey.stone: AppConst.gemstoneDealsOfTheDayParam
    };

    final Either<ErrorResponse, GemstoneListingModel>? response =
        await AppRepository(context).getGemstoneDealOfTheDayProductList(query: queryParams);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      final List<GemstoneDatum> gemstoneList = success.data;
      dealOfTheDayGemstoneList = gemstoneList.map((e) => Utils.convertGemstoneDatumToProductDetailsModel(gemstone: e)).toList();
    });
  }

  Future<void> _getDiamondDealOfTheDayAPICall(BuildContext context) async {
    Map<String, String> queryParams = {
      ApiKey.page: AppConst.page1.toString(),
      ApiKey.limit: AppConst.pageLimit10.toString(),
      ApiKey.stone: AppConst.diamondsDealsOfTheDayParam
    };

    final Either<ErrorResponse, DiamondListingModel>? response =
        await AppRepository(context).getDiamondDealOfTheDayProductList(query: queryParams);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      final List<DiamondDataModel> diamondList = success.data;
      dealOfTheDayDiamondList = diamondList.map((e) => Utils.convertDiamondDataModelToProductDetailsModel(diamond: e)).toList();
    });
  }

  String getTitleForDealOfTheDay(ScreenIdentifier screenIdentifier) {
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        return ('${APPStrings.jewellery.tr} ${APPStrings.dealOfTheDay.tr}');
      case ScreenIdentifier.productForDiamonds:
        return ('${APPStrings.diamond.tr} ${APPStrings.dealOfTheDay.tr}');
      case ScreenIdentifier.productForGemstones:
        return ('${APPStrings.gemstone.tr} ${APPStrings.dealOfTheDay.tr}');
      default:
        return '';
    }
  }
}

enum HomeSlug {
  mobileHomeBanner('mobile-home-banner'),
  mobileTopSellingCategories('mobile-top-selling-categories'),
  mobileViewAllCollection('mobile-view-all-collection'),
  mobileGetInspired('mobile-get-inspired'),
  mobileShopByStyle('mobile-shop-by-style'),
  mobileDIYGuidance('mobile-diy-guidance'),
  mobileShopDiamonds('mobile-shop-diamonds'),
  mobileShopGemstone('mobile-shop-gemstone'),
  kgkDiamondShape('kgk-diamond-shape'),
  kgkGemstone('kgk-gemstone'),
  mobileProductCategories('mobile-product-categories'),
  mobileKGKCouture('mobile-kgk-couture'),
  mobileDealsOfDay('mobile-deals-of-day'),
  mobileRecentlyViewed('mobile-recently-viewed'),
  unknown('unknown');

  const HomeSlug(this.value);

  final String value;
}

enum RedirectionTo {
  gemstone,
  diamond,
  jewellery,
  collection,
  unknown,
}

enum RedirectionType {
  listing,
  details,
  collection,
  unknown,
}

// HomeSlug getHomeSlugFromString(String slug) {
//   switch (slug) {
//     case 'mobile-home-banner':
//       return HomeSlug.mobileHomeBanner;
//     case 'mobile-top-selling-categories':
//       return HomeSlug.mobileTopSellingCategories;
//     case 'mobile-view-all-collection':
//       return HomeSlug.mobileViewAllCollection;
//     case 'mobile-get-inspired':
//       return HomeSlug.mobileGetInspired;
//     case 'mobile-shop-by-style':
//       return HomeSlug.mobileShopByStyle;
//     case 'mobile-diy-guidance':
//       return HomeSlug.mobileDIYGuidance;
//     default:
//       return HomeSlug.unknown;
//   }
// }

RedirectionTo getRedirectionToFromString(String value) {
  switch (value.toLowerCase()) {
    case 'gemstone':
      return RedirectionTo.gemstone;
    case 'diamond':
      return RedirectionTo.diamond;
    case 'jewellery':
      return RedirectionTo.jewellery;
    case 'collection':
      return RedirectionTo.collection;
    default:
      return RedirectionTo.unknown;
  }
}

RedirectionType getRedirectionTypeFromString(String value) {
  switch (value.toLowerCase()) {
    case 'product list':
      return RedirectionType.listing;
    case 'product details':
      return RedirectionType.details;
    case 'collection':
      return RedirectionType.collection;
    default:
      return RedirectionType.unknown;
  }
}

Map<dynamic, String> getQueryParamFromUrlForFilter(
  String url, {
  RedirectionType redirectionType = RedirectionType.listing,
}) {
  if (url.isEmpty) return {};
  if (redirectionType == RedirectionType.details) {
    return {RoutesData.productId: url.split('/').last};
  }
  final uri = Uri.parse(url);
  return uri.queryParameters;
}
