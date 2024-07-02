import 'package:kgk/kgk.dart';

part 'stones_landing_event.dart';

part 'stones_landing_state.dart';

class StonesLandingBloc extends Bloc<StonesLandingEvent, StonesLandingState> {
  // For Screen Identifier
  ScreenIdentifier screenIdentifier = ScreenIdentifier.landingForDiamonds;

  // For Appbar Title
  String appbarTitle = APPStrings.diamond.tr;

  // Shop Diamonds List
  final List<AuctionListModel> shopDiamondsByStyleList = _generateShopDiamondList();

  // Origin of Diamonds List
  final List<AuctionListModel> originOfDiamondsList = _generateShopDiamondList(isForCountry: true);

  // Get Inspired List
  final List<AuctionListModel> getInspiredList = _generateGetInspiredList();

  // Diamond FAQs List
  final List<FAQ> diamondFAQS = _generateDiamondFAQS();

  // Gemstone FAQs List
  final List<FAQ> gemstoneFAQS = _generateDiamondFAQS();

  // Shop Gemstones List
  final List<AuctionListModel> shopGemstonesList = _generateShopGemstonesList();

  // Shop by Style List
  final List<AuctionListModel> shopByStyleList = _generateGetInspiredList();

  // Newly Launched Items List
  final List<ProductDetails> newlyLaunchedItemsList = _generateNewlyLaunchedList();

  // Shop by Metal List
  final List<AuctionListModel> shopByMetalList = _generateShopByMetalList();

  // Top Selling Categories List
  final List<AuctionListModel> topSellingCategoriesList = _generateTopSellingCategoriesList();

  // Constructor
  StonesLandingBloc() : super(InitialStoneLandingState()) {
    on<InitialStonesLandingEvent>(_onStonesLandingInitialEvent);
  }

  // Event handler for InitialStonesLandingEvent
  void _onStonesLandingInitialEvent(InitialStonesLandingEvent event, Emitter<StonesLandingState> emit) {
    emit(DiamondLandingReloadState());
    getScreenIdentifier(event.context);
    emit(InitialStoneLandingState());
  }

  // Get screen identifier based on the context
  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.landingForDiamonds;
    appbarTitle = getAppbarTitle();
  }

  // Get appbar title
  String getAppbarTitle() {
    switch (screenIdentifier) {
      case ScreenIdentifier.landingForDiamonds:
        return APPStrings.diamond.tr;
      case ScreenIdentifier.landingForGemstones:
        return APPStrings.gemstone.tr;
      case ScreenIdentifier.landingForJewellery:
        return APPStrings.jewellery.tr;
      default:
        return APPStrings.diamond.tr;
    }
  }

  // Generate Shop Diamond List
  static List<AuctionListModel> _generateShopDiamondList({bool isForCountry = false}) {
    List<String> nameList = ["Round", "Oval", "Cushion", "Pear", "Pendant"];
    List<String> countriesName = ["Brazil", "South Africa", "Botswana", "Russia"];

    List<String> imageList = [
      "https://i.ibb.co/KrzYdKc/Mask-group-1.png",
      "https://i.ibb.co/85Xqqqc/Mask-group-2.png",
      "https://i.ibb.co/6RGVXbh/Mask-group-3.png",
      "https://i.ibb.co/8g83JhC/Mask-group.png",
    ];

    List<String> countriesImageList = [
      "https://i.ibb.co/f4ZFdMc/Botswana.png",
      "https://i.ibb.co/g9dfWKR/Brazil.png",
      "https://i.ibb.co/GMyYvMF/South-Africa.png",
    ];

    return List.generate(
      20,
      (index) => AuctionListModel(
        id: index.toString(),
        name: isForCountry ? countriesName[Random().nextInt(countriesName.length)] : nameList[Random().nextInt(nameList.length)],
        imageUrl:
            isForCountry ? countriesImageList[Random().nextInt(countriesImageList.length)] : imageList[Random().nextInt(imageList.length)],
      ),
    );
  }

  // Generate Get Inspired List
  static List<AuctionListModel> _generateGetInspiredList() {
    List<String> titleList = ["Diamonds rings", "Diamonds necklace", "Diamonds earrings", "Diamonds bracelet"];
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

  // Generate Shop Gemstones List
  static List<AuctionListModel> _generateShopGemstonesList() {
    List<String> nameList = ["Amethyst", "Blue Sapphire", "Citrine", "Aquamari"];
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

  // Generate Diamond FAQs
  static List<FAQ> _generateDiamondFAQS() {
    return [
      FAQ(
          question: "How can you tell if a diamond is real?",
          answer: "The best way to tell if a diamond is real is to check for any imperfections or inclusions within the diamond. "
              "Real diamonds, whether they are formed naturally or in the lab, will likely have some internal flaws. You can also "
              "perform the fog test by breathing on the diamond, as real diamonds disperse heat quickly and will not fog up for more "
              "than a few short seconds. If you have a mounted diamond, you can take it to a jeweler who can examine it with a loupe, "
              "microscope, or diamond tester, which uses electrical conductivity to differentiate between real and fake diamonds. Learn more in our guide."),
      FAQ(
          question: "What types of diamonds and gemstones do you offer?",
          answer: "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
              "ring heads, settings, and more to create a unique and personalized piece of jewelry."),
      FAQ(
          question: "How can I determine the quality and authenticity of the jewelry I purchase?",
          answer: "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
              "ring heads, settings, and more to create a unique and personalized piece of jewelry."),
      FAQ(
        question: "What types of diamonds and gemstones do you offer?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "How can I determine the quality and authenticity of the jewelry I purchase?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      )
    ];
  }

  // Generate Newly Launched List
  static List<ProductDetails> _generateNewlyLaunchedList() {
    return List.generate(
      20,
      (index) => ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
      ),
    );
  }

  // Generate Shop by Metal List
  static List<AuctionListModel> _generateShopByMetalList() {
    List<String> nameList = ["14k white gold", "14k rose gold", "14k yellow gold"];
    List<String> imageList = [
      "https://i.ibb.co/Zzd66J6/Ellipse-117.png",
      "https://i.ibb.co/DYMS4xm/Ellipse-117-1.png",
      "https://i.ibb.co/XsKxFtz/Ellipse-117-2.png",
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

  // Generate Top Selling Categories List
  static List<AuctionListModel> _generateTopSellingCategoriesList() {
    List<String> nameList = ["Necklace", "Bracelet", "Earrings", "Rings"];
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
        name: nameList[index],
        imageUrl: imageList[index],
      ),
    );
  }
}
