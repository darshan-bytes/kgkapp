import 'package:kgk/kgk.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //Jewellery List
  final List<AuctionListModel> jewelleryList = _generateJewelleryList();

  //Engagement List With slider controller
  int currentCarouselIndex = 0;
  final CarouselController engagementListCarouselController = CarouselController();
  final List<AuctionListModel> engagementList = _generateEngagementList();

  //Shop Diamonds List
  final List<AuctionListModel> shopDiamondsList = _generateShopDiamondList();

  //Shop Gemstones List
  final List<AuctionListModel> shopGemstonesList = _generateShopGemstonesList();

  //Top Selling Categories
  final List<AuctionListModel> topSellingCategoriesList = _generateTopSellingCategoriesList();

  //KGK Couture tabs with Controller
  late TabController tabController;
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.luminous.tr),
    Tab(text: APPStrings.elan.tr),
    Tab(text: APPStrings.huse.tr),
    Tab(text: APPStrings.mirage.tr),
  ];
  final List<ProductDetails> luminousTabViewList = _generateTabViewList();

  //Create Your Own Signature piece
  OrderStoneTypeModel? selectedStep1StoneType;
  OrderStoneTypeModel? selectedStep2RingType;

  final List<OrderStoneTypeModel> arrStoneType = [
    const OrderStoneTypeModel(name: "Regular"),
    const OrderStoneTypeModel(name: "Special"),
    const OrderStoneTypeModel(name: "Diamond"),
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
  final List<ProductDetails> dealOfTheDayList = _generateTabViewList();

  //Get Inspired With Scroll controller
  final List<AuctionListModel> getInspiredList = _generateShopByStyleList();

  //Shop By Style List
  final List<AuctionListModel> shopByStyleList = _generateShopByStyleList();

  //Recently Viewed
  final ScrollController recentlyViewedScrollController = ScrollController();
  final List<ProductDetails> recentlyViewList = _generateTabViewList();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<HomeJewelleryImagePageChangeEvent>(_onHomeJewelleryImagePageChangeEvent);
    on<ChangeHomeTabsEvent>(_onChangeHomeTabsEvent);
    on<ChangeHomeStep1StoneTypeEvent>(_onChangeHomeStep1StoneTypeEvent);
    on<ChangeHomeStep2StoneTypeEvent>(_onChangeHomeStep2StoneTypeEvent);
  }

  void _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }

  void _onHomeJewelleryImagePageChangeEvent(HomeJewelleryImagePageChangeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    currentCarouselIndex = event.index;
    emit(HomeJewelleryImagePageChangeState());
  }

  void _onChangeHomeTabsEvent(ChangeHomeTabsEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    switch (tabController.index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
    emit(HomeChangeTabsState());
  }

  void _onChangeHomeStep1StoneTypeEvent(ChangeHomeStep1StoneTypeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    selectedStep1StoneType = event.selectedStep1StoneType;
    emit(HomeStep1StoneTypeChangeState());
  }

  void _onChangeHomeStep2StoneTypeEvent(ChangeHomeStep2StoneTypeEvent event, Emitter<HomeState> emit) {
    emit(HomeReloadState());
    selectedStep2RingType = event.selectedStep2RingType;
    emit(HomeStep2StoneTypeChangeState());
  }

  //For Jewellery List
  static List<AuctionListModel> _generateJewelleryList() {
    List<String> nameList = ["Necklace", "Earrings", "Ring", "Bracelet", "Pendant"];
    List<String> imageList = [
      "https://i.ibb.co/5jmqMcF/image-18654.png",
      "https://i.ibb.co/vBG9fzy/image-18655.png",
      "https://i.ibb.co/D4kHrXY/image-18652.jpg",
    ];
    return List.generate(
      20,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[Random().nextInt(nameList.length)],
        imageUrl: imageList[Random().nextInt(imageList.length)],
      ),
    );
  }

  //For Engagement List
  static List<AuctionListModel> _generateEngagementList() {
    List<String> imageList = [
      "https://i.ibb.co/P5w4MHq/Banner.png",
      "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      "https://i.ibb.co/P5w4MHq/Banner.png",
      "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      "https://i.ibb.co/P5w4MHq/Banner.png",
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
    List<String> nameList = ["Round", "Oval", "Cushion", "Pear", "Pendant"];
    List<String> imageList = [
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
      "https://i.ibb.co/6RGVXbh/Mask-group-3.png",
      "https://i.ibb.co/8g83JhC/Mask-group.png",
    ];
    return List.generate(
      20,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[Random().nextInt(nameList.length)],
        imageUrl: imageList[Random().nextInt(imageList.length)],
      ),
    );
  }

  //For Shop gemstones List
  static List<AuctionListModel> _generateShopGemstonesList() {
    List<String> nameList = ["Emeralds", "Ruby", "Peridot", "Citrine", "Aquamari"];
    List<String> imageList = [
      "https://i.ibb.co/HdDPk1L/Image-1.png",
      "https://i.ibb.co/dt4GVp5/Image-2.png",
      "https://i.ibb.co/82W97Cb/Image-3.png",
      "https://i.ibb.co/ym2pkwD/Image.png",
    ];
    return List.generate(
      20,
      (index) => AuctionListModel(
        id: index.toString(),
        name: nameList[Random().nextInt(nameList.length)],
        imageUrl: imageList[Random().nextInt(imageList.length)],
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
  static List<ProductDetails> _generateTabViewList() {
    return List.generate(
      20,
      (index) => ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
      ),
    );
  }

  //For Shop by Style
  static List<AuctionListModel> _generateShopByStyleList() {
    List<String> titleList = ["Moissanite rings", "Aquamarine rings", "Peridot", "Morganite rings", "Gemstone jewelry"];
    List<String> imageList = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/syzfTzT/Bracelets.png",
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/zsvLW4N/Image.png"
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
}
