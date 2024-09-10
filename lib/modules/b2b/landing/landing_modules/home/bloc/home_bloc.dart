import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/landing/landing_modules/home/mode/home_strapi_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //Jewellery List
  final List<AuctionListModel> jewelleryList = _generateJewelleryList();

  //Engagement List With slider controller
  int currentCarouselIndex = 0;
  final CarouselSliderController engagementListCarouselController = CarouselSliderController();
  final List<AuctionListModel> engagementList = _generateEngagementList();
  final List<AuctionListModel> latestCollectionList = _generateLatestCollection();

  final List<AuctionListModel> trendingList = _generateTrendingList();

  final List<AuctionListModel> popularList = _generatePopularList();
  final List<AuctionListModel> exploreFancyColorDiamondsList = _generateFancyColorDiamondsList();

  //Shop Diamonds List
  final List<AuctionListModel> shopDiamondsList = _generateShopDiamondList();

  //Shop Rings List
  final List<AuctionListModel> shopByBrands = _generateShopByBrands();

  //Shop Gemstones List
  final List<AuctionListModel> shopGemstonesList = _generateShopGemstonesList();

  //Shop Gemstones2 List
  final List<AuctionListModel> shopGemstones2List = _generateShopGemstones2List();

  //Top Selling Categories
  final List<AuctionListModel> topSellingCategoriesList = _generateTopSellingCategoriesList();

  final List<AuctionListModel> eliganceList = _generateEliganceList();

  final List<AuctionListModel> eliganceList2 = _generateEligance2List();

  final List<AuctionListModel> shopBySpacificCategory = _generateShopBySpacificCategory();

  final List<AuctionListModel> eliganceList3 = _generateEligance3List();

  List<Home> homeStrapiList = [];
  HomeStrapiModel? homeStrapiModel;

  int kgkCoutureSelectedIndex = 0;

  List<String> kgkCoutureButtonsTitle = [
    APPStrings.all,
    APPStrings.luminous,
    APPStrings.elan,
    APPStrings.huse,
    APPStrings.mirage,
  ];
  final List<ProductDetails> luminousProductViewList = _generateTabViewList();

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
  final List<ProductDetails> dealOfTheDayList = _generateTabViewList(isOfferAvailable: true);

  //Get Inspired With Scroll controller
  // final List<AuctionListModel> getInspiredList = _generateGetInspireList();

  final List<AuctionListModel> getInspiredList = _generateGetInspireList();

  //Shop By Style List
  final List<AuctionListModel> shopByStyleList = _generateShopByStyleList();

  //Recently Viewed
  final ScrollController recentlyViewedScrollController = ScrollController();
  final List<ProductDetails> recentlyViewList = _generateTabViewList();

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
    emit(HomeReloadState());
    await fetchStrapiData(event.context, emit);
    refreshCompleter.complete(true);
  }

  void _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    currentPageIndex = 0;
    await fetchStrapiData(event.context, emit);
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    refreshCompleter.complete(true);
    emit(HomeInitial());
  }

  void _onHomeJewelleryImagePageChangeEvent(HomeJewelleryImagePageChangeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    currentCarouselIndex = event.index;
    emit(HomeJewelleryImagePageChangeState());
  }

  void _onChangeHomeStep1StoneTypeEvent(HomeSelectStoneChangeTypeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    selectedStep1StoneType = event.selectedStep1StoneType;
    emit(HomeSelectStoneTypeChangeState());
  }

  void _onChangeHomeStep2StoneTypeEvent(HomeSelectJewelleryChangeTypeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    selectedStep2RingType = event.selectedStep2RingType;
    emit(HomeSelectJewelleryTypeChangeState());
  }

  void _onHomeKgkCoutureSelectionChangeEvent(HomeKgkCoutureSelectionChangeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    int old = kgkCoutureSelectedIndex;
    kgkCoutureSelectedIndex = event.selectedIndex;
    emit(HomeKgkCoutureSelectionChangeState(kgkCoutureSelectedIndex, old));
  }

  void _onHomeCategoryPageChangeEvent(HomeCategoryPageChangeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
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

  // //For Jewellery List
  // static List<AuctionListModel> _generateJewelleryList() {
  //   List<String> nameList = ["Necklace", "Earrings", "Ring", "Bracelet", "Pendant", "XYZ"];
  //   List<String> imageList = [
  //     "https://i.ibb.co/TcT6YBX/Category8.png",
  //     "https://i.ibb.co/M1s88cn/Category7.png",
  //     "https://i.ibb.co/YfxWQ2X/Category6.jpg",
  //     "https://i.ibb.co/1sn6WX0/Category5.jpg",
  //     "https://i.ibb.co/0KKw83x/Category4.jpg",
  //     "https://i.ibb.co/qBYqg0B/Category3.jpg",
  //   ];
  //   return List.generate(
  //     5,
  //         (index) => AuctionListModel(
  //       id: index.toString(),
  //       name: nameList[index],
  //       imageUrl: imageList[index],
  //     ),
  //   );
  // }

  //For Jewellery List
  static List<AuctionListModel> _generateJewelleryList() {
    List<String> nameList = ["Necklace", "Earrings", "Ring", "Bracelet", "Pendant"];
    List<String> imageList = [
      "https://i.ibb.co/D4kHrXY/image-18652.jpg",
      "https://i.ibb.co/1f3SHWg/image-18653.png",
      "https://i.ibb.co/5jmqMcF/image-18654.png",
      "https://i.ibb.co/vBG9fzy/image-18655.png",
      "https://i.ibb.co/1f3SHWg/image-18653.png",
    ];
    return List.generate(
      5,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[index],
        imageUrl: imageList[index],
      ),
    );
  }

  //For Engagement List
  static List<AuctionListModel> _generateEngagementList() {
    List<String> imageList = [
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
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
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
      // "https://i.ibb.co/P5w4MHq/Banner.png",
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

  //For Shop by Style List
  static List<AuctionListModel> _generateShopDiamondList() {
    List<String> nameList = [
      "Round",
      "Oval",
      "Cushion",
      "Pear",
      "Pendant",
      "Round",
      "Oval",
      "Cushion",
      "Pear",
      "Pendant",
      "Round",
      "Oval",
      "Cushion",
      "Pear",
      "Pendant"
    ];
    List<String> imageList = [
      "https://i.ibb.co/8g83JhC/Mask-group.png",
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
      "https://i.ibb.co/6RGVXbh/Mask-group-3.png",
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
      "https://i.ibb.co/6RGVXbh/Mask-group-3.png",
      "https://i.ibb.co/8g83JhC/Mask-group.png",
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
      "https://i.ibb.co/6RGVXbh/Mask-group-3.png",
      "https://i.ibb.co/8g83JhC/Mask-group.png",
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
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
  static List<AuctionListModel> _generateShopGemstonesList() {
    List<String> nameList = [
      "Emeralds",
      "Ruby",
      "Peridot",
      "Citrine",
      "Aquamari",
      "Emeralds",
      "Ruby",
      "Peridot",
      "Citrine",
      "Aquamari",
      "Emeralds",
      "Ruby",
      "Peridot",
      "Citrine",
      "Aquamari",
      "Emeralds",
      "Ruby",
      "Peridot",
      "Citrine",
      "Aquamari"
    ];
    List<String> imageList = [
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
    ];
    return List.generate(
      20,
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

  //For Top Selling Categories
  static List<AuctionListModel> _generateTopSellingCategoriesList() {
    List<String> imageList = [
      "https://i.ibb.co/mXxkBC7/Necklaces.png",
      "https://i.ibb.co/syzfTzT/Bracelets.png",
      "https://i.ibb.co/GvyRJtx/Earrings.png",
      "https://i.ibb.co/2yNzxBw/Rings.png"
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
  static List<ProductDetails> _generateTabViewList({bool isOfferAvailable = false}) {
    return List.generate(
      20,
      (index) => ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
        discountPercentage: isOfferAvailable ? APPStrings.youHaveSavedX.tr.interpolate(["10%"]) : null,
        offerPrice: isOfferAvailable ? '\$4,000.00' : null,
      ),
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

  // //For Get Inspired
  // static List<AuctionListModel> _generateGetInspireList() {
  //   List<String> titleList = ["Diamonds rings", "Diamonds necklace", "Diamonds earrings", "Diamonds bracelet"];
  //   List<String> imageList = [
  //     "https://i.ibb.co/30MXHMT/Image5.png",
  //     "https://i.ibb.co/yRy2w21/Image1.png",
  //     "https://i.ibb.co/dmtHjL6/Image2.png",
  //     "https://i.ibb.co/VN2fDKh/Image4.png"
  //   ];
  //   return List.generate(
  //     imageList.length,
  //         (index) => AuctionListModel(
  //       id: index.toString(),
  //       name: titleList[index],
  //       imageUrl: imageList[index],
  //     ),
  //   );
  // }

  //For Shop by Style
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
  Future<void> fetchStrapiData(BuildContext context, Emitter<HomeState> emit) async {
    homeStrapiList.clear();
    await AppRepository(context).fetchStrapiHomeData().then((value) async {
      value.fold((l) {
        emit(HomeErrorState(errorMessage: l.message ?? ""));
        Utils.showMessage(l.message ?? "");
      }, (r) {
        homeStrapiList = r;
      });
    });
    emit(const HomeStrapiDataFetchedState());
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

          if (imageUrl != null) {
            dataList.add(AuctionListModel(
                id: element['id'].toString(),
                imageUrl: "${AppConst.strapiImgBaseUrl}$imageUrl",
                redirectTo: redirectTo,
                redirectionType: redirectionType,
                name: name));
          }
        }
      }
      return dataList;
    }

    switch (slug) {
      case HomeSlug.mobileHomeBanner:
        return HomeWidgets.buildEngagementImageSlider(
          homeBloc,
          parseDataList(homeStrapiList[index].data),
        );

      case HomeSlug.mobileTopSellingCategories:
        return HomeWidgets.buildTopSellingCategories(
          homeBloc,
          style,
          parseDataList(homeStrapiList[index].data),
          context: context,
        );

      case HomeSlug.mobileViewAllCollection:
        final imageUrl = homeStrapiList[index].data['image']?['data']?['attributes']?['url'];
        String redirectTo = homeStrapiList[index].data['redirectTo'];
        String redirectionType = homeStrapiList[index].data['redirectionType'];
        return HomeWidgets.buildViewAllCollectionsSection(
          homeBloc,
          style,
          context: context,
          url: imageUrl != null ? "${AppConst.strapiImgBaseUrl}$imageUrl" : '',
          redirectTo: redirectTo,
          redirectionType: redirectionType,
        );

      case HomeSlug.mobileGetInspired:
        return HomeWidgets.buildGetInspiredSection(
          context,
          homeBloc,
          style,
          parseDataList(homeStrapiList[index].data),
        );

      case HomeSlug.mobileShopByStyle:
        return HomeWidgets.buildShopByStyleSection(
          homeBloc,
          style,
          parseDataList(homeStrapiList[index].data),
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

      case HomeSlug.unknown:
      default:
        return const SizedBox.shrink();
    }
  }

  /// Handles redirection based on the [redirectTo] and [redirectionType]
  void handleRedirection({required BuildContext context, required RedirectionTo redirectTo, required RedirectionType redirectionType}) {
    Map<RoutesData, dynamic>? arguments;
    String routeName;

    switch (redirectTo) {
      case RedirectionTo.gemstone:
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.stoneDetailPage : AppRoutes.stoneListingPage;
        arguments = {RoutesData.isPageFor: ScreenIdentifier.productForGemstones};
        break;

      case RedirectionTo.diamond:
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.stoneDetailPage : AppRoutes.stoneListingPage;
        arguments = {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault};
        break;

      case RedirectionTo.jewellery:
        routeName = (redirectionType == RedirectionType.details) ? AppRoutes.productDetailsPage : AppRoutes.productListGridPage;
        arguments = {RoutesData.isPageFor: ScreenIdentifier.productForRing};
        break;

      case RedirectionTo.unknown:
      default:
        printWrapped('Unknown redirection');
        return; // Exit early for unknown redirection
    }

    context.pushNamed(routeName, arguments: arguments);
  }
}

enum HomeSlug {
  mobileHomeBanner('mobile-home-banner'),
  mobileTopSellingCategories('mobile-top-selling-categories'),
  mobileViewAllCollection('mobile-view-all-collection'),
  mobileGetInspired('mobile-get-inspired'),
  mobileShopByStyle('mobile-shop-by-style'),
  mobileDIYGuidance('mobile-diy-guidance'),
  unknown('unknown');

  const HomeSlug(this.value);

  final String value;
}

enum RedirectionTo {
  gemstone,
  diamond,
  jewellery,
  unknown,
}

enum RedirectionType {
  listing,
  details,
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
    default:
      return RedirectionType.unknown;
  }
}
