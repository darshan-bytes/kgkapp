// ignore_for_file: unused_local_variable

import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/stone_landing/model/gemstone_strapi_model.dart';
import 'package:kgk/modules/b2b/stone_landing/model/jewelleries_strapi_model.dart';

import '../model/diamonds_strapi_model.dart';

part 'stones_landing_event.dart';

part 'stones_landing_state.dart';

class StonesLandingBloc extends Bloc<StonesLandingEvent, StonesLandingState> {
  // For Screen Identifier
  ScreenIdentifier screenIdentifier = ScreenIdentifier.landingForDiamonds;

  // For Appbar Title
  String appbarTitle = APPStrings.diamond.tr;

  // Shop Diamonds List
  final ScrollController shopDiamondsScrollController = ScrollController();
  List<AuctionListModel> shopDiamondsByStyleList = [];

  bool isInitialized = false;

  // Origin of Diamonds List
  final List<AuctionListModel> originOfDiamondsList = _generateShopDiamondList(isForCountry: true);

  // Get Inspired List
  final List<AuctionListModel> getInspiredList = _generateGetInspiredList(isForDiamond: true);

  // Diamond FAQs List
  final List<FAQ> diamondFAQS = _generateDiamondFAQS();

  // Gemstone FAQs List
  final List<FAQ> gemstoneFAQS = _generateGemstoneFAQS();

  // Shop Gemstones List
  final ScrollController shopGemstonesScrollController = ScrollController();
  List<AuctionListModel> shopGemstonesList = [];

  // Shop by Style List
  final List<AuctionListModel> shopByStyleList = _generateGetInspiredList(isGemstone: true);

  // Newly Launched Items List
  List<ProductDetailsModel> newlyLaunchedItemsList = [];

  // Shop by Metal List
  final ScrollController shopByMetalScrollController = ScrollController();
  final List<AuctionListModel> shopByMetalList = _generateShopByMetalList();

  // Top Selling Categories List
  final List<AuctionListModel> topSellingCategoriesList = _generateTopSellingCategoriesList();

  List<DiamondData> diamondStrapiList = [];

  List<Gemstone> gemstoneStrapiList = [];

  List<Jewellery> jewelleryStrapiList = [];

  Completer<bool> refreshCompleter = Completer<bool>();

  // Constructor
  StonesLandingBloc() : super(InitialStoneLandingState()) {
    on<InitialStonesLandingEvent>(_onStonesLandingInitialEvent);
    on<PullToRefreshStonesLandingEvent>(_onPullToRefreshStonesLandingEvent);
  }

  // Event handler for InitialStonesLandingEvent
  void _onStonesLandingInitialEvent(InitialStonesLandingEvent event, Emitter<StonesLandingState> emit) async {
    emit(DiamondLandingReloadState());
    if (!isInitialized) {
      isInitialized = true;
      await fetchNewlyLaunchesData(event.context, isShowLoader: false);
      await shapeMasterFilters(event.context);
      await fetchCommodityMasterFilters(event.context);
      emit(InitialStoneLandingState());
      await getScreenIdentifier(event.context, emit);
    }
  }

  Future<void> fetchNewlyLaunchesData(BuildContext context, {bool isShowLoader = true}) async {
    final response = await BlocProvider.of<AppBloc>(context).fetchNewlyLaunchesData(context, isShowLoader: isShowLoader);
    newlyLaunchedItemsList = List.generate(response.length, (index) {
      HomeNewLanuchesDatum item = response[index];
      return ProductDetailsModel(
        productId: item.suid ?? '',
        subTitle: item.productDescription ?? '',
        imageUrl:
            item.multipleFinishedViewImage.isNotEmpty && item.multipleFinishedViewImage.first.imageAvailable == "Yes"
                ? (item.multipleFinishedViewImage.first.imageUrl ?? '')
                : '',
        originalPrice: item.finalPrice?.toStringAsFixed(2).setCurrency,
        finalPrice: item.discountPrice?.toStringAsFixed(2).setCurrency,
      );
    });
  }

  // Get screen identifier based on the context
  Future<void> getScreenIdentifier(BuildContext context, Emitter<StonesLandingState> emit) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.landingForDiamonds;
    appbarTitle = getAppbarTitle();
    await makeStrapiCallBasedOnScreenIdentifier(context, emit);
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    refreshCompleter.complete(true);
  }

  // Event handler for PullToRefreshStonesLandingEvent
  void _onPullToRefreshStonesLandingEvent(PullToRefreshStonesLandingEvent event, Emitter<StonesLandingState> emit) async {
    emit(DiamondLandingReloadState());
    await makeStrapiCallBasedOnScreenIdentifier(event.context, emit);
    refreshCompleter.complete(true);
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

  Future<void> makeStrapiCallBasedOnScreenIdentifier(BuildContext context, Emitter<StonesLandingState> emit) async {
    switch (screenIdentifier) {
      case ScreenIdentifier.landingForDiamonds:
        await fetchStrapiDataForDiamond(context, emit);
        break;
      case ScreenIdentifier.landingForGemstones:
        await fetchStrapiDataForGemstones(context, emit);
        break;
      case ScreenIdentifier.landingForJewellery:
        await fetchStrapiDataForJewellery(context, emit);
        break;
      default:
        await fetchStrapiDataForDiamond(context, emit);
    }
  }

  // Fetch Strapi data
  Future<void> fetchStrapiDataForDiamond(BuildContext context, Emitter<StonesLandingState> emit) async {
    await AppRepository(context).fetchStrapiDiamondLandingData().then((value) {
      value.fold(
        (l) {
          emit(DiamondStrapiDataErrorState(errorResponse: l));
          Utils.showMessage(l.message);
        },
        (r) {
          diamondStrapiList = r;
        },
      );
    });
    emit(const DiamondStrapiDataFetchedState());
  }

  // Fetch Strapi data for Gemstones
  Future<void> fetchStrapiDataForGemstones(BuildContext context, Emitter<StonesLandingState> emit) async {
    await AppRepository(context).fetchStrapiGemstoneLandingData().then((value) {
      value.fold(
        (l) {
          emit(GemstoneStrapiDataErrorState(errorResponse: l));
          Utils.showMessage(l.message);
        },
        (r) {
          gemstoneStrapiList = r;
        },
      );
    });
    emit(const GemstoneStrapiDataFetchedState());
  }

  // Fetch Strapi data for Jewellery
  Future<void> fetchStrapiDataForJewellery(BuildContext context, Emitter<StonesLandingState> emit) async {
    await AppRepository(context).fetchStrapiJewelleryLandingData().then((value) {
      value.fold(
        (l) {
          emit(JewelleryStrapiDataErrorState(errorResponse: l));
          Utils.showMessage(l.message);
        },
        (r) {
          jewelleryStrapiList.clear();
          jewelleryStrapiList = r;
        },
      );
    });
    emit(const JewelleryStrapiDataFetchedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(PullToRefreshStonesLandingEvent(context: context));
    return refreshCompleter.future;
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
  static List<AuctionListModel> _generateGetInspiredList({bool isGemstone = false, bool isForDiamond = false}) {
    List<String> titleList = ["Diamonds rings", "Diamonds necklace", "Diamonds earrings", "Diamonds bracelet"];
    List<String> imageList = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/syzfTzT/Bracelets.png",
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/syzfTzT/Bracelets.png",
    ];
    List<String> shopByStyleImage = [
      "https://i.ibb.co/zsvLW4N/Image.png",
      "https://i.ibb.co/x1q3y0C/Image11.png",
      "https://i.ibb.co/G7RH7k4/Image22.png",
      "https://i.ibb.co/XYsTf4M/Image33.png",
    ];

    List<String> diamondImageList = [
      "https://i.ibb.co/30MXHMT/Image5.png",
      "https://i.ibb.co/yRy2w21/Image1.png",
      "https://i.ibb.co/dmtHjL6/Image2.png",
      "https://i.ibb.co/VN2fDKh/Image4.png",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(
        id: index.toString(),
        name: titleList[index],
        imageUrl:
            isForDiamond
                ? diamondImageList[index]
                : isGemstone
                ? shopByStyleImage[index]
                : imageList[index],
      ),
    );
  }

  // Generate Diamond FAQs
  static List<FAQ> _generateDiamondFAQS() {
    return [
      FAQ(
        question: "How can you tell if a diamond is real?",
        answer:
            "The best way to tell if a diamond is real is to check for any imperfections or inclusions within the diamond. "
            "Real diamonds, whether they are formed naturally or in the lab, will likely have some internal flaws. You can also "
            "perform the fog test by breathing on the diamond, as real diamonds disperse heat quickly and will not fog up for more "
            "than a few short seconds. If you have a mounted diamond, you can take it to a jeweler who can examine it with a loupe, "
            "microscope, or diamond tester, which uses electrical conductivity to differentiate between real and fake diamonds. "
            "Learn more in our guide.",
      ),
      FAQ(
        question: "How are diamonds made?",
        answer:
            "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What are the 4Cs of diamonds?",
        answer:
            "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What are the different kinds of diamond shapes?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "Which diamonds are the most popular?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What jewelry looks best with diamonds?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal,"
            " diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
    ];
  }

  // Generate Gemstone FAQs
  static List<FAQ> _generateGemstoneFAQS() {
    return [
      FAQ(
        question: "What is a gemstone?",
        answer:
            "A gemstone is a mineral or rock that is cut and polished for use in jewelry or other decorative items."
            "There are hundreds of types of gemstones, but the most common are diamonds, rubies, emeralds, sapphires, and pearls. "
            "Gemstones are formed deep within the Earth's crust under extreme heat and pressure. "
            "They are found in a variety of locations around the world, including mines, riverbeds, and volcanic areas.",
      ),
      FAQ(
        question: "What is the rarest gemstone?",
        answer:
            "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "How are gemstones cut?",
        answer:
            "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What are the different kinds of diamond shapes?",
        answer:
            "We provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, "
            "ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "Which diamonds are the most popular?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, "
            "diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What jewelry looks best with diamonds?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, "
            "diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
    ];
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
      "https://i.ibb.co/2yNzxBw/Rings.png",
    ];
    return List.generate(
      imageList.length,
      (index) => AuctionListModel(id: index.toString(), name: nameList[index], imageUrl: imageList[index]),
    );
  }

  /// Returns a Widget based on the given LandingSlug type.
  ///
  Widget getDiamondWidgetsFromSlug(
    BuildContext context,
    LandingSlug slug,
    StonesLandingBloc stoneLandingBloc,
    StonesLandingScreenStyle style,
    HomeScreenStyle homeScreenStyle,
    int index,
  ) {
    switch (slug) {
      case LandingSlug.landingBanner:
        String title = diamondStrapiList[index].poster?.title ?? '';
        String description = Utils.parseHtmlString(diamondStrapiList[index].poster?.description ?? '');
        String? image =
            (diamondStrapiList[index].poster?.mobileImage?.data).isNotNullNorEmpty
                ? diamondStrapiList[index].poster?.mobileImage?.data.first.attributes?.url
                : '';

        List<Widget> buttonList = [];
        for (int i = 0; i < diamondStrapiList[index].button.length; i++) {
          buttonList.add(
            SmartButton(
              margin:
                  i != diamondStrapiList[index].button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
              onTap: () {
                handleRedirection(
                  context: context,
                  redirectTo: getRedirectionToFromString(diamondStrapiList[index].button[i].redirectTo ?? ""),
                  redirectionType: getRedirectionTypeFromString(diamondStrapiList[index].button[i].redirectionType ?? ""),
                );
              },

              /// Todo : fix in next strapi update
              title: diamondStrapiList[index].button[i]['label'],
            ),
          );
        }
        return StoneBannerView(
          imagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
          title: title,
          subTitle: description,
          naturalDiamondsButtonTitle: APPStrings.shopNaturalDiamonds.tr,
          onTapShopNaturalDiamonds: () {},
          labDiamondsButtonTitle: APPStrings.shopLabDiamonds.tr,
          onTapShopLabDiamonds: () {},
          buttonList: buttonList,
        );

      case LandingSlug.kgkDiamondShape:
        return ShopStoneByShapeSection(
          title: APPStrings.shopDiamondsByShape.tr,
          itemList: shopDiamondsByStyleList,
          onTap: (context, item) {},
          homeScreenStyle: homeScreenStyle,
          style: style,
          scrollController: shopDiamondsScrollController,
        );

      case LandingSlug.jewelstonePoster || LandingSlug.diamondLandingPoster:
        String buttonTitle = diamondStrapiList[index].button['label'] ?? '';
        String backgroundImage =
            (diamondStrapiList[index].backgroundImage?.mobileImage?.data).isNotNullNorEmpty
                ? diamondStrapiList[index].backgroundImage?.mobileImage?.data.first.attributes?.url ?? ''
                : '';
        String title = diamondStrapiList[index].title ?? '';
        String description = Utils.parseHtmlString((diamondStrapiList[index].description ?? ''));
        return CraftedForYourSpecialMomentSection(
          style: style,
          title: title,
          buttonCallBack: () {
            handleRedirection(
              context: context,
              redirectTo: getRedirectionToFromString(diamondStrapiList[index].button.first.redirectTo ?? ""),
              redirectionType: getRedirectionTypeFromString(diamondStrapiList[index].button.first.redirectionType ?? ""),
            );
          },
          buttonTitle: buttonTitle,
          // APPStrings.shopDiamonds.tr
          description: description,
          backgroundImage: "${AppConst.strapiQaEnvImgBaseUrl}$backgroundImage", // "https://i.ibb.co/NnpfYJW/Image.png",
        );

      case LandingSlug.originOfDiamonds:
        return _buildOriginOfDiamondsSection(
          stoneLandingBloc,
          style,
          context,
          homeScreenStyle,
          index,
          diamondStrapiList[index].details,
          diamondStrapiList[index].country,
        );

      case LandingSlug.landingGetInspired:
        getInspiredList.clear();
        String title = diamondStrapiList[index].details?.title ?? '';
        for (int i = 0; i < diamondStrapiList[index].country.length; i++) {
          getInspiredList.add(
            AuctionListModel(
              id: i.toString(),
              name: diamondStrapiList[index].country[i].title ?? '',
              imageUrl:
                  (diamondStrapiList[index].country[i].mobileImage?.data).isNotNullNorEmpty
                      ? '${AppConst.strapiQaEnvImgBaseUrl}${diamondStrapiList[index].country[i].mobileImage?.data.first.attributes?.url}'
                      : "",
              redirectTo: diamondStrapiList[index].country[i].redirecTo ?? '',
              redirectionType: diamondStrapiList[index].country[i].redirectionType ?? '',
            ),
          );
        }

        return GetInspiredSection(
          title: title,
          onTap: (context, auctionModel) {
            handleRedirection(
              context: context,
              redirectTo: getRedirectionToFromString(auctionModel.redirectTo ?? ""),
              redirectionType: getRedirectionTypeFromString(auctionModel.redirectionType ?? ""),
            );
          },
          itemList: getInspiredList,
          bloc: stoneLandingBloc,
          homeScreenStyle: homeScreenStyle,
          style: style,
        );

      case LandingSlug.designAllJewellery:
        List<Widget> stonesBannerView = [];

        String mainBannerTitle = diamondStrapiList[index].title ?? '';
        String mainBannerDescription = Utils.parseHtmlString(diamondStrapiList[index].description ?? '');
        String mainBannerForegroundImagePath =
            '${AppConst.strapiQaEnvImgBaseUrl}${diamondStrapiList[index].image?.data.first.attributes?.url}';
        List<Widget> buttonList = [];

        for (int i = 0; i < diamondStrapiList[index].button.length; i++) {
          buttonList.add(
            SmartButton(
              margin:
                  i != diamondStrapiList[index].button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
              onTap: () {
                handleRedirection(
                  context: context,
                  redirectTo: getRedirectionToFromString(diamondStrapiList[index].button[i].redirectTo ?? ""),
                  redirectionType: getRedirectionTypeFromString(diamondStrapiList[index].button[i].redirectionType ?? ""),
                );
              },
              title: diamondStrapiList[index].button[i]['label'],
            ),
          );
        }

        stonesBannerView.add(
          StonesBannerView(
            padding: EdgeInsetsDirectional.zero,
            foregroundImagePath: mainBannerForegroundImagePath,
            spaceBetweenImageAndTitle: 16.h,
            bannerTitleText: mainBannerTitle,
            bannerTitleStyle: style.craftedSectionTitleStyle,
            bannerSubTitleText: mainBannerDescription,
            bannerSubTitleStyle: style.originSectionSubTitleStyle,
            margin: EdgeInsetsDirectional.only(bottom: 24.h),
            buttonList: buttonList,
          ),
        );

        for (int i = 0; i < diamondStrapiList[index].banner.length; i++) {
          String title = diamondStrapiList[index].banner[i].title ?? '';
          String description = Utils.parseHtmlString(diamondStrapiList[index].banner[i].description ?? '');
          String? image =
              (diamondStrapiList[index].banner[i].image?.data).isNotNullNorEmpty
                  ? diamondStrapiList[index].banner[i].image?.data.first.attributes?.url
                  : '';
          String buttonTitle = diamondStrapiList[index].banner[i].buttonLabel ?? '';

          stonesBannerView.add(
            StonesBannerView(
              padding: EdgeInsetsDirectional.all(16.w),
              margin:
                  i != diamondStrapiList[index].banner.length - 1 ? EdgeInsetsDirectional.only(bottom: 24.h) : EdgeInsetsDirectional.zero,
              backgroundImagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
              backgroundImageHeight: 200.h,
              spaceBetweenTitleAndSubTitle: 4.h,
              bannerTitleText: title,
              bannerSubTitleText: description,
              bannerTitleStyle: style.designOwnEarringTextStyle,
              bannerSubTitleStyle: style.sparkleSubTitleStyle,
              buttonList: [
                SmartButton(
                  onTap: () {
                    handleRedirection(
                      context: context,
                      redirectTo: getRedirectionToFromString(diamondStrapiList[index].button[i].redirectTo ?? ""),
                      redirectionType: getRedirectionTypeFromString(diamondStrapiList[index].button[i].redirectionType ?? ""),
                    );
                  },
                  title: buttonTitle,
                ),
              ],
            ),
          );
        }

        return Container(
          color: style.designYourOwnStoneBgColor,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
          child: Column(children: stonesBannerView),
        );

      case LandingSlug.aboutEntity:
        String title = diamondStrapiList[index].about?.title ?? '';
        String description = Utils.parseHtmlString(diamondStrapiList[index].about?.description ?? '');
        String? image =
            (diamondStrapiList[index].about?.image?.data).isNotNullNorEmpty
                ? diamondStrapiList[index].about?.image?.data.first.attributes?.url
                : '';
        return AboutOurStoneSection(
          style: style,
          learnMore: () {
            printWrapped("Learn More");
          },
          title: title,
          imagePath: '${AppConst.strapiQaEnvImgBaseUrl}$image',
          subTitle: description,
        );

      case LandingSlug.landingFaq:
        diamondFAQS.clear();
        String title = diamondStrapiList[index].title ?? '';
        for (int i = 0; i < diamondStrapiList[index].faQs.length; i++) {
          diamondFAQS.add(
            FAQ(question: diamondStrapiList[index].faQs[i].question ?? '', answer: diamondStrapiList[index].faQs[i].answer ?? ''),
          );
        }

        return StonesFAQSection(title: title, style: style, faqs: diamondFAQS);

      case LandingSlug.unknown:
      default:
        return const SizedBox.shrink();
    }
  }

  /// Returns a Widget based on the given LandingSlug type.
  Widget getGemStoneWidgetsFromSlug(
    BuildContext context,
    LandingSlug slug,
    StonesLandingBloc stoneLandingBloc,
    StonesLandingScreenStyle style,
    HomeScreenStyle homeScreenStyle,
    int index,
  ) {
    switch (slug) {
      case LandingSlug.landingBanner:
        String title = gemstoneStrapiList[index].poster?.title ?? '';
        String description = Utils.parseHtmlString(gemstoneStrapiList[index].poster?.description ?? '');
        String? image =
            (gemstoneStrapiList[index].poster?.mobileImage?.data).isNotNullNorEmpty
                ? gemstoneStrapiList[index].poster?.mobileImage?.data.first.attributes?.url
                : '';
        List<Widget> buttonList = [];
        for (int i = 0; i < gemstoneStrapiList[index].button.length; i++) {
          buttonList.add(
            SmartButton(
              margin:
                  i != gemstoneStrapiList[index].button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
              onTap: () {
                handleRedirection(
                  context: context,
                  redirectTo: getRedirectionToFromString(gemstoneStrapiList[index].button[i].redirectTo ?? ""),
                  redirectionType: getRedirectionTypeFromString(gemstoneStrapiList[index].button[i].redirectionType ?? ""),
                );
              },
              title: gemstoneStrapiList[index].button[i]['label'] ?? '',
            ),
          );
        }
        return StoneBannerView(
          imagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
          title: title,
          subTitle: description,
          naturalDiamondsButtonTitle: APPStrings.shopNaturalDiamonds.tr,
          onTapShopNaturalDiamonds: () {},
          labDiamondsButtonTitle: APPStrings.shopLabDiamonds.tr,
          onTapShopLabDiamonds: () {},
          buttonList: buttonList,
        );

      case LandingSlug.jewelstonePoster:
        String buttonTitle = gemstoneStrapiList[index].button.first.label ?? '';
        String backgroundImage =
            (gemstoneStrapiList[index].poster?.image?.data).isNotNullNorEmpty
                ? gemstoneStrapiList[index].poster?.image?.data.first.attributes?.url ?? ''
                : '';
        String title = gemstoneStrapiList[index].poster?.title ?? '';
        String description = Utils.parseHtmlString((gemstoneStrapiList[index].poster?.description ?? ''));
        return CraftedForYourSpecialMomentSection(
          style: style,
          title: title,
          buttonCallBack: () {
            handleRedirection(
              context: context,
              redirectTo: getRedirectionToFromString(gemstoneStrapiList[index].button.first.redirectTo ?? ""),
              redirectionType: getRedirectionTypeFromString(gemstoneStrapiList[index].button.first.redirectionType ?? ""),
            );
          },
          buttonTitle: buttonTitle,
          description: description,
          backgroundImage: "${AppConst.strapiImgBaseUrl}$backgroundImage", // "https://i.ibb.co/NnpfYJW/Image.png",
        );

      case LandingSlug.originOfDiamonds:
        return _buildOriginOfDiamondsSection(
          stoneLandingBloc,
          style,
          context,
          homeScreenStyle,
          index,
          gemstoneStrapiList[index].details,
          gemstoneStrapiList[index].country,
        );

      case LandingSlug.landingGetInspired:
        getInspiredList.clear();
        String title = gemstoneStrapiList[index].details?.title ?? '';
        for (int i = 0; i < gemstoneStrapiList[index].country.length; i++) {
          getInspiredList.add(
            AuctionListModel(
              id: i.toString(),
              name: gemstoneStrapiList[index].country[i].title ?? '',
              imageUrl:
                  (gemstoneStrapiList[index].country[i].mobileImage?.data).isNotNullNorEmpty
                      ? '${AppConst.strapiQaEnvImgBaseUrl}${gemstoneStrapiList[index].country[i].mobileImage?.data.first.attributes?.url}'
                      : "",
              redirectTo: gemstoneStrapiList[index].country[i].redirecTo ?? '',
              redirectionType: gemstoneStrapiList[index].country[i].redirectionType ?? '',
            ),
          );
        }

        return GetInspiredSection(
          title: title,
          onTap: (context, auctionModel) {
            handleRedirection(
              context: context,
              redirectTo: getRedirectionToFromString(auctionModel.redirectTo ?? ""),
              redirectionType: getRedirectionTypeFromString(auctionModel.redirectionType ?? ""),
            );
          },
          itemList: getInspiredList,
          bloc: stoneLandingBloc,
          homeScreenStyle: homeScreenStyle,
          style: style,
        );

      case LandingSlug.designAllJewellery:
        List<Widget> stonesBannerView = [];

        if (gemstoneStrapiList[index].title.isNotNullNorEmpty) {
          String mainBannerTitle = gemstoneStrapiList[index].title ?? '';
          String mainBannerDescription = Utils.parseHtmlString(gemstoneStrapiList[index].description ?? '');
          String mainBannerForegroundImagePath =
              '${AppConst.strapiQaEnvImgBaseUrl}${gemstoneStrapiList[index].mobileImage?.data.firstOrNull?.attributes?.url}';
          List<Widget> buttonList = [];

          for (int i = 0; i < gemstoneStrapiList[index].button.length; i++) {
            buttonList.add(
              SmartButton(
                margin:
                    i != gemstoneStrapiList[index].button.length - 1
                        ? EdgeInsetsDirectional.only(bottom: 16.h)
                        : EdgeInsetsDirectional.zero,
                onTap: () {
                  handleRedirection(
                    context: context,
                    redirectTo: getRedirectionToFromString(gemstoneStrapiList[index].button[i].redirectTo ?? ""),
                    redirectionType: getRedirectionTypeFromString(gemstoneStrapiList[index].button[i].redirectionType ?? ""),
                  );
                },
                title: gemstoneStrapiList[index].button[i]['label'] ?? '',
              ),
            );
          }

          stonesBannerView.add(
            StonesBannerView(
              padding: EdgeInsetsDirectional.zero,
              foregroundImagePath: mainBannerForegroundImagePath,
              spaceBetweenImageAndTitle: 16.h,
              bannerTitleText: mainBannerTitle,
              bannerTitleStyle: style.craftedSectionTitleStyle,
              bannerSubTitleText: mainBannerDescription,
              bannerSubTitleStyle: style.originSectionSubTitleStyle,
              margin: EdgeInsetsDirectional.only(bottom: 24.h),
              buttonList: buttonList,
            ),
          );
        }

        if (gemstoneStrapiList[index].banner.isNotNullNorEmpty) {
          for (int i = 0; i < gemstoneStrapiList[index].banner.length; i++) {
            String title = gemstoneStrapiList[index].banner[i].title ?? '';
            String description = Utils.parseHtmlString(gemstoneStrapiList[index].banner[i].description ?? '');
            String? image =
                (gemstoneStrapiList[index].banner[i].image?.data).isNotNullNorEmpty
                    ? gemstoneStrapiList[index].banner[i].image?.data.first.attributes?.url
                    : '';
            String buttonTitle = gemstoneStrapiList[index].banner[i].buttonLabel ?? '';

            stonesBannerView.add(
              StonesBannerView(
                padding: EdgeInsetsDirectional.all(16.w),
                margin:
                    i != gemstoneStrapiList[index].banner.length - 1
                        ? EdgeInsetsDirectional.only(bottom: 24.h)
                        : EdgeInsetsDirectional.zero,
                backgroundImagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
                backgroundImageHeight: 200.h,
                spaceBetweenTitleAndSubTitle: 4.h,
                bannerTitleText: title,
                bannerSubTitleText: description,
                bannerTitleStyle: style.designOwnEarringTextStyle,
                bannerSubTitleStyle: style.sparkleSubTitleStyle,
                buttonList: [
                  SmartButton(
                    onTap: () {
                      handleRedirection(
                        context: context,
                        redirectTo: getRedirectionToFromString(gemstoneStrapiList[index].button[i].redirectTo ?? ""),
                        redirectionType: getRedirectionTypeFromString(gemstoneStrapiList[index].button[i].redirectionType ?? ""),
                      );
                    },
                    title: buttonTitle,
                  ),
                ],
              ),
            );
          }
        }

        return stonesBannerView.isNotNullNorEmpty
            ? Container(
              color: style.designYourOwnStoneBgColor,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
              child: Column(children: stonesBannerView),
            )
            : const SizedBox.shrink();

      case LandingSlug.aboutEntity:
        String title = gemstoneStrapiList[index].about?.title ?? '';
        String description = Utils.parseHtmlString(gemstoneStrapiList[index].about?.description ?? '');
        String? image =
            (gemstoneStrapiList[index].about?.image?.data).isNotNullNorEmpty
                ? gemstoneStrapiList[index].about?.image?.data.first.attributes?.url
                : '';
        return AboutOurStoneSection(
          style: style,
          learnMore: () {
            printWrapped("Learn More");
          },
          title: title,
          imagePath: '${AppConst.strapiQaEnvImgBaseUrl}$image',
          subTitle: description,
        );

      case LandingSlug.landingFaq:
        diamondFAQS.clear();
        String title = gemstoneStrapiList[index].title ?? '';
        for (int i = 0; i < gemstoneStrapiList[index].faQs.length; i++) {
          diamondFAQS.add(
            FAQ(question: gemstoneStrapiList[index].faQs[i].question ?? '', answer: gemstoneStrapiList[index].faQs[i].answer ?? ''),
          );
        }

        return StonesFAQSection(title: title, style: style, faqs: diamondFAQS);

      case LandingSlug.shopByGemstones:
        return ShopStoneByShapeSection(
          title: APPStrings.shopByGemstones.tr,
          itemList: shopGemstonesList,
          onTap: (context, item) {},
          homeScreenStyle: homeScreenStyle,
          style: style,
          scrollController: shopGemstonesScrollController,
        );

      case LandingSlug.unknown:
      default:
        return const SizedBox.shrink();
    }
  }

  /// Returns a Widget based on the given LandingSlug type.
  Widget getJewelleriesWidgetsFromSlug(
    BuildContext context,
    LandingSlug slug,
    StonesLandingBloc stoneLandingBloc,
    StonesLandingScreenStyle style,
    HomeScreenStyle homeScreenStyle,
    int index,
  ) {
    switch (slug) {
      case LandingSlug.landingBanner:
        String title = jewelleryStrapiList[index].poster?.title ?? '';
        String description = Utils.parseHtmlString(jewelleryStrapiList[index].poster?.description ?? '');
        String? image =
            (jewelleryStrapiList[index].poster?.mobileImage?.data).isNotNullNorEmpty
                ? jewelleryStrapiList[index].poster?.mobileImage?.data.first.attributes?.url
                : '';
        List<Widget> buttonList = [];
        for (int i = 0; i < jewelleryStrapiList[index].button.length; i++) {
          buttonList.add(
            SmartButton(
              margin:
                  i != jewelleryStrapiList[index].button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
              onTap: () {
                handleRedirection(
                  context: context,
                  redirectTo: getRedirectionToFromString(jewelleryStrapiList[index].button[i].redirectTo ?? ""),
                  redirectionType: getRedirectionTypeFromString(jewelleryStrapiList[index].button[i].redirectionType ?? ""),
                );
              },
              title: jewelleryStrapiList[index].button[i]['label'] ?? '',
            ),
          );
        }
        return StoneBannerView(
          imagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
          title: title,
          subTitle: description,
          naturalDiamondsButtonTitle: APPStrings.shopNaturalDiamonds.tr,
          onTapShopNaturalDiamonds: () {},
          labDiamondsButtonTitle: APPStrings.shopLabDiamonds.tr,
          onTapShopLabDiamonds: () {},
          buttonList: buttonList,
        );

      case LandingSlug.originOfDiamonds:
        return _buildOriginOfDiamondsSection(
          stoneLandingBloc,
          style,
          context,
          homeScreenStyle,
          index,
          jewelleryStrapiList[index].details,
          jewelleryStrapiList[index].country,
        );

      case LandingSlug.landingGetInspired:
        getInspiredList.clear();
        String title = jewelleryStrapiList[index].details?.title ?? '';
        for (int i = 0; i < jewelleryStrapiList[index].country.length; i++) {
          getInspiredList.add(
            AuctionListModel(
              id: i.toString(),
              name: jewelleryStrapiList[index].country[i].title ?? '',
              imageUrl: '${AppConst.strapiQaEnvImgBaseUrl}${jewelleryStrapiList[index].country[i].image?.data.first.attributes?.url}',
              redirectTo: jewelleryStrapiList[index].country[i].redirecTo ?? '',
              redirectionType: jewelleryStrapiList[index].country[i].redirectionType ?? '',
            ),
          );
        }

        return GetInspiredSection(
          title: title,
          onTap: (context, auctionModel) {
            handleRedirection(
              context: context,
              redirectTo: getRedirectionToFromString(auctionModel.redirectTo ?? ""),
              redirectionType: getRedirectionTypeFromString(auctionModel.redirectionType ?? ""),
            );
          },
          height: 216.h,
          itemList: getInspiredList,
          bloc: stoneLandingBloc,
          homeScreenStyle: homeScreenStyle,
          backgroundColor: style.designYourOwnStoneBgColor,
          style: style,
        );

      case LandingSlug.designAllJewellery:
        List<Widget> stonesBannerView = [];

        if (jewelleryStrapiList[index].banner.isNotNullNorEmpty) {
          for (int i = 0; i < jewelleryStrapiList[index].banner.length; i++) {
            if (jewelleryStrapiList[index].banner[i].title.isNullOrEmpty ||
                jewelleryStrapiList[index].banner[i].description.isNullOrEmpty) {
              continue;
            }

            String title = jewelleryStrapiList[index].banner[i].title ?? '';
            String description = Utils.parseHtmlString(jewelleryStrapiList[index].banner[i].description ?? '');
            String? image =
                (jewelleryStrapiList[index].banner[i].image?.data).isNotNullNorEmpty
                    ? jewelleryStrapiList[index].banner[i].image?.data.first.attributes?.url
                    : '';
            String buttonTitle = jewelleryStrapiList[index].banner[i].buttonLabel ?? '';
            stonesBannerView.add(
              StonesBannerView(
                margin: EdgeInsetsDirectional.only(
                  top: 24.h,
                  start: 17.w,
                  end: 17.w,
                  bottom: i == jewelleryStrapiList[index].banner.length - 1 ? 24.h : 0,
                ),
                backgroundImagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
                backgroundImageHeight: 200.h,
                spaceBetweenTitleAndSubTitle: 4.h,
                bannerTitleText: title,
                bannerSubTitleText: description,
                bannerTitleStyle: style.designOwnEarringTextStyle,
                bannerSubTitleStyle: style.sparkleSubTitleStyle,
                buttonList: [
                  SmartButton(
                    onTap: () {
                      if (jewelleryStrapiList[index].button.isEmpty) return;
                      handleRedirection(
                        context: context,
                        redirectTo: getRedirectionToFromString(jewelleryStrapiList[index].button[i].redirectTo ?? ""),
                        redirectionType: getRedirectionTypeFromString(jewelleryStrapiList[index].button[i].redirectionType ?? ""),
                      );
                    },
                    title: "buttonTitle",
                  ),
                ],
              ),
            );
          }
        }

        if (jewelleryStrapiList[index].title != null && jewelleryStrapiList[index].title.isNotNullNorEmpty) {
          String mainBannerTitle = jewelleryStrapiList[index].title ?? '';
          String mainBannerDescription = Utils.parseHtmlString(jewelleryStrapiList[index].description ?? '');
          String mainBannerForegroundImagePath =
              '${AppConst.strapiQaEnvImgBaseUrl}${jewelleryStrapiList[index].image?.data.first.attributes?.url}';
          List<Widget> buttonList = [];

          for (int i = 0; i < jewelleryStrapiList[index].button.length; i++) {
            if (i > 0) {
              buttonList.add(SmartText(APPStrings.or.tr, optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 4.h)));
            }
            buttonList.add(
              SmartButton(
                onTap: () {
                  handleRedirection(
                    context: context,
                    redirectTo: getRedirectionToFromString(jewelleryStrapiList[index].button[i].redirectTo ?? ""),
                    redirectionType: getRedirectionTypeFromString(jewelleryStrapiList[index].button[i].redirectionType ?? ""),
                  );
                },
                title: jewelleryStrapiList[index].button[i].label ?? '',
              ),
            );
          }

          stonesBannerView.add(
            Container(
              color: style.designYourOwnStoneBgColor,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
              child: StonesBannerView(
                crossAxisAlignment: CrossAxisAlignment.center,
                titleTextAlign: TextAlign.center,
                subTitleTextAlign: TextAlign.center,
                backgroundImagePath: mainBannerForegroundImagePath,
                bannerTitleText: mainBannerTitle,
                bannerSubTitleText: mainBannerDescription,
                bannerTitleStyle: style.sectionLabelStyle,
                bannerSubTitleStyle: style.jewelleryCreateOwnSubTitleStyle,
                padding: EdgeInsetsDirectional.all(16.w),
                backgroundImageHeight: 448.h,
                spaceBetweenTitleAndSubTitle: 4.h,
                buttonList: buttonList,
              ),
            ),
          );
        }

        return stonesBannerView.isNotNullNorEmpty ? Column(children: stonesBannerView) : const SizedBox.shrink();

      case LandingSlug.kgkDiamondShape:
        return ShopStoneByShapeSection(
          title: APPStrings.shopDiamondsByShape.tr,
          itemList: shopDiamondsByStyleList,
          onTap: (context, item) {},
          homeScreenStyle: homeScreenStyle,
          style: style,
          scrollController: shopDiamondsScrollController,
        );

      case LandingSlug.newlyLaunched:
        return buildNewlyLaunchedSection(style);

      case LandingSlug.unknown:
      default:
        return const SizedBox.shrink();
    }
  }

  /// Handles redirection based on the [redirectTo] and [redirectionType]
  void handleRedirection({
    required BuildContext context,
    required RedirectionTo redirectTo,
    required RedirectionType redirectionType,
    Map<String, dynamic>? redirectionData,
  }) {
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

      case RedirectionTo.collection:
        routeName = (redirectionType == RedirectionType.listing) ? AppRoutes.productListGridPage : AppRoutes.collectionPage;
        arguments =
            (redirectionType == RedirectionType.listing)
                ? {RoutesData.isPageFor: ScreenIdentifier.productForRing, RoutesData.filterData: {}}
                : {};
        break;

      case RedirectionTo.unknown:
        printWrapped('Unknown redirection');
        return; // Exit early for unknown redirection
    }

    context.pushNamed(routeName, arguments: arguments);
  }

  // Widget getDiamondWidgetsFromSlug(
  //     BuildContext context,
  //     LandingSlug slug,
  //     StonesLandingBloc stoneLandingBloc,
  //     StonesLandingScreenStyle style,
  //     HomeScreenStyle homeScreenStyle,
  //     int index,
  //     ) {
  //   final DiamondData item = diamondStrapiList[index];
  //
  //   switch (slug) {
  //     case LandingSlug.landingBanner:
  //       return _buildLandingBanner(item, style);
  //     case LandingSlug.jewelstonePoster:
  //       return _buildJewelstonePoster(item, style);
  //     case LandingSlug.originOfDiamonds:
  //       return _buildOriginOfDiamondsSection(stoneLandingBloc, style, context, homeScreenStyle, index);
  //     case LandingSlug.landingGetInspired:
  //       return _buildGetInspiredSection(item, stoneLandingBloc, homeScreenStyle, style);
  //     case LandingSlug.designAllJewellery:
  //       return _buildDesignAllJewellerySection(item, style);
  //     case LandingSlug.aboutEntity:
  //       return _buildAboutEntitySection(item, style);
  //     case LandingSlug.landingFaq:
  //       return _buildLandingFaqSection(item, style);
  //     case LandingSlug.unknown:
  //     default:
  //       return const SizedBox.shrink();
  //   }
  // }

  /// Builds the landing banner widget.
  Widget _buildLandingBanner(DiamondData item, StonesLandingScreenStyle style) {
    final title = item.poster?.title ?? '';
    final description = Utils.parseHtmlString(item.poster?.description ?? '');
    final image = (item.poster?.image?.data).isNotNullNorEmpty ? item.poster?.image?.data.first.attributes?.url : '';

    // Create a list of SmartButton widgets
    final buttonList =
        item.button
            .asMap()
            .entries
            .map<Widget>(
              (entry) => SmartButton(
                margin: entry.key != item.button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
                onTap: () => printWrapped("Button ${entry.key} clicked"),
                title: entry.value.label ?? '',
              ),
            )
            .toList();

    return StoneBannerView(
      imagePath: "${AppConst.strapiQaEnvImgBaseUrl}$image",
      title: title,
      subTitle: description,
      naturalDiamondsButtonTitle: APPStrings.shopNaturalDiamonds.tr,
      onTapShopNaturalDiamonds: () {},
      labDiamondsButtonTitle: APPStrings.shopLabDiamonds.tr,
      onTapShopLabDiamonds: () {},
      buttonList: buttonList,
    );
  }

  /// Builds the jewelstone poster widget.
  Widget _buildJewelstonePoster(DiamondData item, StonesLandingScreenStyle style) {
    final buttonTitle = item.button.first.label ?? '';
    final backgroundImage = (item.poster?.image?.data).isNotNullNorEmpty ? "" : item.poster?.image?.data.first.attributes?.url ?? '';
    final title = item.poster?.title ?? '';
    final description = Utils.parseHtmlString(item.poster?.description ?? '');

    return CraftedForYourSpecialMomentSection(
      style: style,
      title: title,
      buttonCallBack: () {},
      buttonTitle: buttonTitle,
      description: description,
      backgroundImage: "${AppConst.strapiQaEnvImgBaseUrl}$backgroundImage",
    );
  }

  /// Builds the "Get Inspired" section widget.
  // Widget _buildGetInspiredSection(DiamondData item,StonesLandingBloc stoneLandingBloc, HomeScreenStyle homeScreenStyle, StonesLandingScreenStyle style) {
  //   getInspiredList.clear();
  //   for (int i = 0; i < item.getInspired.length; i++) {
  //     getInspiredList.add(AuctionListModel(
  //       id: i.toString(),
  //       name: item.getInspired[i].title ?? '',
  //       imageUrl: item.getInspired[i].image?.data.isNotNullNorEmpty ? "${AppConst.strapiImgBaseUrl}${item.getInspired[i].image?.data.first.attributes?.url ?? ''}" : "",
  //     ));
  //   }
  //   return GetInspiredSection(
  //     title: APPStrings.getInspired.tr,
  //     onTap: (context, auctionModel) {},
  //     itemList: getInspiredList,
  //     bloc: stoneLandingBloc,
  //     homeScreenStyle: homeScreenStyle,
  //     style: style,
  //   );
  // }

  /// Builds the "Design All Jewellery" section widget.
  Widget _buildDesignAllJewellerySection(DiamondData item, StonesLandingScreenStyle style) {
    final title = item.title ?? '';
    final description = Utils.parseHtmlString(item.description ?? '');

    // Create a list of SmartButton widgets
    final buttonList =
        item.button
            .asMap()
            .entries
            .map<Widget>(
              (entry) => SmartButton(
                margin: entry.key != item.button.length - 1 ? EdgeInsetsDirectional.only(bottom: 16.h) : EdgeInsetsDirectional.zero,
                onTap: () => printWrapped("Button ${entry.key} clicked"),
                title: entry.value.label ?? '',
              ),
            )
            .toList();

    return DesignYourOwnStoneSection(
      style: style,
      mainBannerTitle: title,
      mainBannerDescription: description,
      mainBannerForegroundImagePath: "https://i.ibb.co/hZ4YjSR/Image-3.png",
      firstBannerTitle: "Design your own earrings",
      firstBannerDescription: "Select your setting and diamonds to get exactly what you're looking for.",
      firstBannerBackgroundImagePath: "https://i.ibb.co/1J2wWPr/Image-4.png",
      firstBannerButtonTitle: APPStrings.getStarted.tr,
      firstBannerButtonCallback: () {},
      secondBannerTitle: "Design your own necklace",
      secondBannerDescription: "Customize a solitaire necklace with a setting and gemstone that suit your style.",
      secondBannerBackgroundImagePath: "https://i.ibb.co/FVJDbvp/Image323.png",
      secondBannerButtonTitle: APPStrings.getStarted.tr,
      secondBannerButtonCallback: () {},
      buttonList: buttonList,
    );
  }

  /// Builds the "About Entity" section widget.
  Widget _buildAboutEntitySection(DiamondData item, StonesLandingScreenStyle style) {
    final title = item.about?.title ?? '';
    final description = Utils.parseHtmlString(item.about?.description ?? '');

    return AboutOurStoneSection(style: style, title: title, imagePath: "https://i.ibb.co/M6TZT3y/image-304.png", subTitle: description);
  }

  /// Builds the FAQ section widget.
  Widget _buildLandingFaqSection(DiamondData item, StonesLandingScreenStyle style) {
    final title = item.title ?? '';

    // Create a list of FAQ objects
    final faqs = item.faQs.map<FAQ>((faq) => FAQ(question: faq.question ?? '', answer: faq.answer ?? '')).toList();

    return StonesFAQSection(title: title, style: style, faqs: faqs);
  }

  Widget _buildJewelleryCreateOwnSection({required StonesLandingScreenStyle style}) {
    return Container(
      color: style.designYourOwnStoneBgColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
      child: StonesBannerView(
        crossAxisAlignment: CrossAxisAlignment.center,
        titleTextAlign: TextAlign.center,
        subTitleTextAlign: TextAlign.center,
        backgroundImagePath: "https://i.ibb.co/4VSsw5B/Image-8.png",
        bannerTitleText: "Create your own \nsignature piece",
        bannerSubTitleText: "Unleash your creativity and design your own exquisite jewelry piece that truly reflects your unique style.",
        bannerTitleStyle: style.sectionLabelStyle,
        bannerSubTitleStyle: style.jewelleryCreateOwnSubTitleStyle,
        padding: EdgeInsetsDirectional.all(16.w),
        backgroundImageHeight: 448.h,
        spaceBetweenTitleAndSubTitle: 4.h,
        buttonList: [
          SmartButton(onTap: () {}, title: APPStrings.startWithSetting.tr),
          SmartText(APPStrings.or.tr, optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 4.h)),
          SmartButton(onTap: () {}, title: APPStrings.startWithDiamond.tr),
        ],
      ),
    );
  }

  Widget _buildOriginOfDiamondsSection(
    StonesLandingBloc bloc,
    StonesLandingScreenStyle style,
    BuildContext context,
    HomeScreenStyle homeScreenStyle,
    int index,
    Details? details,
    List<Poster> country,
  ) {
    String title = details?.title ?? '';
    String description = Utils.parseHtmlString(details?.description ?? '');
    bloc.originOfDiamondsList.clear();
    for (int i = 0; i < country.length; i++) {
      bloc.originOfDiamondsList.add(
        AuctionListModel(
          id: i.toString(),
          name: country[i].title ?? '',
          imageUrl:
              (country[i].image?.data).isNotNullNorEmpty
                  ? "${AppConst.strapiQaEnvImgBaseUrl}${country[i].image?.data.first.attributes?.url ?? ''}"
                  : "",
        ),
      );
    }
    return SmartHorizontalItemBuilder(
      title: title,
      widgetBetweenTitleAndItems: SmartText(
        description,
        optionalPadding: EdgeInsetsDirectional.only(start: 17.w, top: 12.h, end: 17.w, bottom: 16.h),
        style: style.originSectionSubTitleStyle,
      ),
      titleStyle: style.sectionLabelStyle,
      backgroundColor: style.originSectionBgColor,
      itemCount: bloc.originOfDiamondsList.length,
      itemBetweenSpace: 17.w,
      titleOptionalPadding: EdgeInsetsDirectional.only(start: 17.w),
      listPadding: EdgeInsetsDirectional.only(end: 17.w),
      padding: EdgeInsetsDirectional.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = bloc.originOfDiamondsList[index];
        return SmartImageTitleColumn(
          onTap: () {},
          width: 88.w,
          title: item.name ?? '',
          titleStyle: homeScreenStyle.shopGemstoneTitleStyle,
          margin: EdgeInsetsDirectional.only(start: index == 0 ? 17.w : 0, end: index == bloc.originOfDiamondsList.length - 1 ? 17.w : 0),
          titleMaxLines: 1,
          fit: BoxFit.fill,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  Future<void> shapeMasterFilters(BuildContext context) async {
    try {
      final response = await BlocProvider.of<AppBloc>(context).fetchShapeMasterFilters(context);
      shopDiamondsByStyleList = List.generate(response.length, (index) {
        ShapeMasterDetails item = response[index];
        return AuctionListModel(
          id: item.id?.toString() ?? '',
          name: item.shapeName,
          imageUrl: item.image ?? '',
          redirectTo: RedirectionTo.diamond.toString(),
        );
      });
    } catch (e) {
      printWrapped('Error in fetching shape master filters: $e');
    }
  }

  Future<void> fetchCommodityMasterFilters(BuildContext context) async {
    try {
      final response = await BlocProvider.of<AppBloc>(context).fetchHomeGemstiones(context);
      shopGemstonesList = List.generate(response.length, (index) {
        HomeGemstonesModel item = response[index];
        return AuctionListModel(
          id: item.id?.toString() ?? '',
          name: item.commodityName,
          imageUrl: item.image,
          redirectTo: RedirectionTo.jewellery.toString(),
        );
      });
    } catch (e) {
      printWrapped('Error in fetching shape master filters: $e');
    }
  }

  Widget buildNewlyLaunchedSection(StonesLandingScreenStyle style) {
    return Container(
      color: style.newlyLaunchedBackgroundColor,
      padding: EdgeInsetsDirectional.symmetric(vertical: 32.h, horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(APPStrings.newlyLaunched.tr, style: style.newlyLaunchedStyle),
          SizedBox(height: 4.h),
          SmartText(APPStrings.exploreNewlyLaunchedProducts.tr, style: style.sparkleSubTitleStyle),
          SizedBox(height: 24.h),
          SmartGridView(
            items: List.generate(
              newlyLaunchedItemsList.length > 4
                  ? 4
                  : (newlyLaunchedItemsList.length % 2 == 0 ? newlyLaunchedItemsList.length : newlyLaunchedItemsList.length - 1),
              (index) => ProductGridItem(productDetails: newlyLaunchedItemsList[index], onEyeTap: () {}, onFavTap: () {}, onTap: () {}),
            ),
          ),
          SizedBox(height: 24.h),
          SmartButton(onTap: () {}, title: APPStrings.exploreNow.tr),
        ],
      ),
    );
  }
}

enum LandingSlug {
  landingBanner('landing-banner'),
  jewelstonePoster('jewelstone-poster'),
  diamondLandingPoster('diamond-landing-poster'),
  originOfDiamonds('origin-of-diamonds'),
  landingGetInspired('landing-get-inspired'),
  designAllJewellery('design-all-jewellery'),
  aboutEntity('about-entity'),
  landingFaq('landing-faqs'),
  kgkDiamondShape('kgk-diamond-shape'),
  kgkGemstone('kgk-gemstone'),
  newlyLaunched('newly-launch'),
  shopByGemstones('shop-by-gemstones'),
  unknown('unknown');

  const LandingSlug(this.value);

  final String value;
}
