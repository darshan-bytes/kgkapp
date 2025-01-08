import 'package:kgk/kgk.dart';

part 'categories_event.dart';

part 'categories_state.dart';

enum ArrowPosition { leftTop, centerTop, rightTop }

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  UserType userType = UserType.b2cUser;
  int? selectedRowIndex;
  int? selectedItemIndex;
  ArrowPosition arrowPosition = ArrowPosition.rightTop;

  ScrollController scrollController = ScrollController();

  List<CategoriesModel> categories = [];
  List<ProductDetailModel> selectedCategoriesList = [];

  //B2C subCategory List
  List<ProductDetailModel> naturalDiamondSubOptionsB2CList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> labGrownDiamondSubOptionsB2CList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> gemstonesSubOptionsB2CList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> jewellerySubOptionsB2CList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> doItYourselfSubOptionsB2CList = [
    ProductDetailModel(name: 'Diamond', image: ''),
    ProductDetailModel(name: 'Gemstone', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> aboutUsSubOptionsB2CList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> educationSubOptionsB2CList = [
    ProductDetailModel(name: 'Diamonds', image: ''),
    ProductDetailModel(name: 'Lab created diamonds', image: ''),
    ProductDetailModel(name: 'Gemstone', image: ''),
    ProductDetailModel(name: 'Metals', image: ''),
    ProductDetailModel(name: 'Ring sizer', image: ''),
  ];

  //B2B subCategory List
  List<ProductDetailModel> pddSubOptionsList = [
    ProductDetailModel(name: 'Concept Listing', image: ''),
    ProductDetailModel(name: 'Presentation Listing', image: ''),
    ProductDetailModel(name: 'Project Listing', image: ''),
    ProductDetailModel(name: 'Design Listing', image: ''),
    ProductDetailModel(name: 'Styles Listing', image: ''),
    ProductDetailModel(name: 'Monitoring', image: ''),
  ];

  List<ProductDetailModel> jewellerySubOptionsB2BList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> diamondSubOptionsB2BList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> gemstoneSubOptionsB2BList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];

  List<ProductDetailModel> librarySubOptionsList = [
    ProductDetailModel(name: 'Product Library - Grey', image: ''),
    ProductDetailModel(name: 'Product Library MF - Platinum', image: ''),
    ProductDetailModel(name: 'Design Library', image: ''),
    ProductDetailModel(name: 'SKU Library', image: ''),
    ProductDetailModel(name: 'CAD Library', image: ''),
    ProductDetailModel(name: 'Style Library', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: '')
  ];

  List<ProductDetailModel> digitalCatalogueSubOptionsB2BList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> doItYourselfSubOptionsB2BList = [
    ProductDetailModel(name: 'Diamond', image: ''),
    ProductDetailModel(name: 'Gemstone', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];
  List<ProductDetailModel> orionSubCategoryList = [
    ProductDetailModel(name: 'Collection', image: ''),
    ProductDetailModel(name: 'Best Selling', image: ''),
    ProductDetailModel(name: 'Seasonal Offers', image: ''),
    ProductDetailModel(name: 'Occasion Offer', image: ''),
    ProductDetailModel(name: 'Deals', image: ''),
  ];

  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesSelectedEvent>(onCategoriesSelectedEvent);
    on<CategoriesInitialEvent>(onCategoriesInitialEvent);
  }

  void onCategoriesSelectedEvent(CategoriesSelectedEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesReloaded());

    if (selectedRowIndex == event.index && selectedItemIndex == event.itemIndex) {
      selectedRowIndex = -1;
      selectedItemIndex = -1;
    } else {
      selectedRowIndex = event.index;
      selectedItemIndex = event.itemIndex;
    }

    if (event.itemIndex == 0) {
      arrowPosition = ArrowPosition.leftTop;
    } else if (event.itemIndex == 1) {
      arrowPosition = ArrowPosition.centerTop;
    } else if (event.itemIndex == 2) {
      arrowPosition = ArrowPosition.rightTop;
    }

    selectedCategoriesList.clear();
    selectedCategoriesList.addAll(event.subList[event.itemIndex].productsDetailsList ?? []);

    emit(CategoriesSelected());
  }

  void onCategoriesInitialEvent(CategoriesInitialEvent event, Emitter<CategoriesState> emit) {
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    selectedRowIndex = null;
    categories.clear();
    if (userType == UserType.b2bUser) {
      categories.addAll([
        CategoriesModel(name: 'PDD', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: pddSubOptionsList),
        CategoriesModel(
            name: 'Jewellery', image: 'https://i.ibb.co/xXngyKk/Jewellery-Catelogue.png', productsDetailsList: jewellerySubOptionsB2BList),
        CategoriesModel(name: 'Diamond', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: diamondSubOptionsB2BList),
        CategoriesModel(
            name: 'Gemstone', image: 'https://i.ibb.co/w754LRZ/Gemstone-Category.png', productsDetailsList: gemstoneSubOptionsB2BList),
        CategoriesModel(
            name: 'Libraries', image: 'https://i.ibb.co/ScfcyDw/Libraries-Category.png', productsDetailsList: librarySubOptionsList),
        CategoriesModel(
            name: 'Digital \nCatalogue',
            image: 'https://i.ibb.co/7tr0GFf/Digital-Catalogue-Category.png',
            productsDetailsList: digitalCatalogueSubOptionsB2BList,
            isExpanded: false),
        CategoriesModel(
            name: 'Do It \nYourself',
            image: 'https://i.ibb.co/W3pW5Pw/Do-It-Your-Self-Category.png',
            productsDetailsList: doItYourselfSubOptionsB2BList),
        CategoriesModel(
            name: 'Orion',
            image: 'https://i.ibb.co/tDyD1Yj/Orion-Category.png',
            productsDetailsList: orionSubCategoryList,
            isExpanded: false),
        CategoriesModel(
          name: 'Exhibition',
          image: 'https://i.ibb.co/VxhKkNW/Mask-group.png',
          productsDetailsList: [],
          isExpanded: false,
        )
      ]);
    } else {
      categories.addAll([
        CategoriesModel(
            name: 'Natural \nDiamonds', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: naturalDiamondSubOptionsB2CList),
        CategoriesModel(
            name: 'Lab-grown \nDiamonds',
            image: 'https://i.ibb.co/1LRFJ3h/Lab-grown-Category.png',
            productsDetailsList: labGrownDiamondSubOptionsB2CList),
        CategoriesModel(
            name: 'Gemstone', image: 'https://i.ibb.co/w754LRZ/Gemstone-Category.png', productsDetailsList: gemstonesSubOptionsB2CList),
        CategoriesModel(
            name: 'Jewellery', image: 'https://i.ibb.co/xXngyKk/Jewellery-Catelogue.png', productsDetailsList: jewellerySubOptionsB2CList),
        CategoriesModel(
            name: 'Do It \nYourself',
            image: 'https://i.ibb.co/W3pW5Pw/Do-It-Your-Self-Category.png',
            productsDetailsList: doItYourselfSubOptionsB2CList),
        CategoriesModel(
          name: 'About Us',
          image: 'https://i.ibb.co/QD2Tw8M/About-Us-Category.png',
          productsDetailsList: aboutUsSubOptionsB2CList,
          isExpanded: false,
        ),
        CategoriesModel(
            name: 'Education', image: 'https://i.ibb.co/rFjpN0q/Education-Category.png', productsDetailsList: educationSubOptionsB2CList),
      ]);
    }
    emit(CategoriesFetchData());
  }

  // Navigate based on the selected category and subcategory
  void navigateBasedOnCategory({required BuildContext context, String? categoryName, String? categorySubName}) {
    if (categoryName.isNotNullNorEmpty) {
      String? routeName = _getRouteName(categoryName!, categorySubName);
      Map<RoutesData, dynamic>? arguments = _getRouteArguments(categoryName, categorySubName);

      if (routeName.isNotNullNorEmpty) {
        context.pushNamed(routeName!, arguments: arguments);
      }
    }
  }

  // Get route name based on user type and category
  String? _getRouteName(String categoryName, String? categorySubName) {
    if (userType == UserType.b2cUser) {
      return _getRouteNameForB2C(categoryName, categorySubName);
    } else {
      return _getRouteNameForB2B(categoryName, categorySubName);
    }
  }

  // Get route arguments based on user type and category
  Map<RoutesData, dynamic>? _getRouteArguments(String categoryName, String? categorySubName) {
    if (userType == UserType.b2cUser) {
      return _getRouteArgumentsForB2C(categoryName, categorySubName);
    } else {
      return _getRouteArgumentsForB2B(categoryName, categorySubName);
    }
  }

  // B2C category route names and arguments
  String? _getRouteNameForB2C(String categoryName, String? categorySubName) {
    switch (categoryName) {
      case 'Natural \nDiamonds':
        return _getNaturalDiamondsRouteNameForB2C(categorySubName);
      case 'Lab-grown \nDiamonds':
        return _getLabGrownDiamondsRouteNameForB2C(categorySubName);
      case 'Gemstone':
        return _getGemstoneRouteNameForB2C(categorySubName);
      case 'Jewellery':
        return _getJewelleryRouteNameForB2C(categorySubName);
      case 'Do It \nYourself':
        return _getDoItYourselfRouteNameForB2C(categorySubName);
      case 'About Us':
        return _getAboutUsRouteNameForB2C(categorySubName);
      case 'Education':
        return _getEducationRouteNameForB2C(categorySubName);
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getRouteArgumentsForB2C(String categoryName, String? categorySubName) {
    switch (categoryName) {
      case 'Natural \nDiamonds':
        return _getNaturalDiamondsRouteArgumentsForB2C(categorySubName);
      case 'Lab-grown \nDiamonds':
        return _getLabGrownDiamondsRouteArgumentsForB2C(categorySubName);
      case 'Gemstone':
        return _getGemstoneRouteArgumentsForB2C(categorySubName);
      case 'Jewellery':
        return _getJewelleryRouteArgumentsForB2C(categorySubName);
      case 'Do It \nYourself':
        return _getDoItYourselfRouteArgumentsForB2C(categorySubName);
      case 'About Us':
        return _getAboutUsRouteArgumentsForB2C(categorySubName);
      case 'Education':
        return _getEducationRouteArgumentsForB2C(categorySubName);
      default:
        return defaultAction();
    }
  }

  // B2B category route names and arguments
  String? _getRouteNameForB2B(String categoryName, String? categorySubName) {
    switch (categoryName) {
      case 'PDD':
        return _getPDDRouteNameB2B(categorySubName);
      case 'Jewellery':
        return _getJewelleryRouteNameB2B(categorySubName);
      case 'Diamond':
        return _getDiamondRouteNameB2B(categorySubName);
      case 'Gemstone':
        return _getGemstoneRouteNameB2B(categorySubName);
      case 'Libraries':
        return _getLibrariesRouteNameB2B(categorySubName);
      case 'Digital \nCatalogue':
        return _getDigitalCatalogueRouteNameB2B(categorySubName);
      case 'Do It \nYourself':
        return _getDoItYourselfRouteNameB2B(categorySubName);
      case 'Orion':
        return _getOrionRouteNameB2B(categorySubName);
      case 'Exhibition':
        return _getExhibitionRouteNameForB2B(categorySubName);
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getRouteArgumentsForB2B(String categoryName, String? categorySubName) {
    switch (categoryName) {
      case 'PDD':
        return _getPDDRouteArgumentsB2B(categorySubName);
      case 'Jewellery':
        return _getJewelleryRouteArgumentsB2B(categorySubName);
      case 'Diamond':
        return _getDiamondRouteArgumentsB2B(categorySubName);
      case 'Gemstone':
        return _getGemstoneRouteArgumentsB2B(categorySubName);
      case 'Libraries':
        return _getLibrariesRouteArgumentsB2B(categorySubName);
      case 'Digital \nCatalogue':
        return _getDigitalCatalogueRouteArgumentsB2B(categorySubName);
      case 'Do It \nYourself':
        return _getDoItYourselfRouteArgumentsB2B(categorySubName);
      case 'Orion':
        return _getOrionRouteArgumentsB2B(categorySubName);
      default:
        return defaultAction();
    }
  }

  // Additional helper methods to determine the route based on subcategories
  String? _getNaturalDiamondsRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stoneListingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getNaturalDiamondsRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault};
      default:
        return defaultAction();
    }
  }

  String? _getLabGrownDiamondsRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stoneListingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getLabGrownDiamondsRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault};
      default:
        return defaultAction();
    }
  }

  String? _getGemstoneRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stoneListingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getGemstoneRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.productForGemstones};
      default:
        return defaultAction();
    }
  }

  String _getJewelleryRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.collectionPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getJewelleryRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.productForRing};
      default:
        return defaultAction();
    }
  }

  String? _getDoItYourselfRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Diamond':
        return AppRoutes.stoneListingPage;

      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getDoItYourselfRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.diamondForDIY};

      default:
        return defaultAction();
    }
  }

  String? _getAboutUsRouteNameForB2C(String? categorySubName) {
    return AppRoutes.cmsWebViewPage;
  }

  String? _getExhibitionRouteNameForB2B(String? categorySubName) {
    return AppRoutes.exhibitionListingPage;
  }

  Map<RoutesData, dynamic>? _getAboutUsRouteArgumentsForB2C(String? categorySubName) {
    return {
      RoutesData.cmsPageData: CmsWebViewDataModel(
        url: AppConst.profileAboutUsWebViewURL,
        title: APPStrings.aboutUs.tr,
      )
    };
  }

  String? _getEducationRouteNameForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Diamonds':
        return AppRoutes.cmsWebViewPage;
      case 'Lab created diamonds':
        return AppRoutes.cmsWebViewPage;
      case 'Gemstone':
        return AppRoutes.cmsWebViewPage;
      case 'Metals':
        return AppRoutes.cmsWebViewPage;
      case 'Ring sizer':
        return AppRoutes.cmsWebViewPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getEducationRouteArgumentsForB2C(String? categorySubName) {
    switch (categorySubName) {
      case 'Diamonds':
        return {
          RoutesData.cmsPageData: CmsWebViewDataModel(
            url: AppConst.profileDiamondWebViewURL,
            title: APPStrings.diamonds.tr,
          )
        };
      case 'Lab created diamonds':
        return {
          RoutesData.cmsPageData: CmsWebViewDataModel(
            url: AppConst.profileDiamondWebViewURL,
            title: APPStrings.labCreatedDiamonds.tr,
          )
        };
      case 'Gemstone':
        return {
          RoutesData.cmsPageData: CmsWebViewDataModel(
            url: AppConst.profileGemstoneWebViewURL,
            title: APPStrings.gemstone.tr,
          )
        };
      case 'Metals':
        return {
          RoutesData.cmsPageData: CmsWebViewDataModel(
            url: AppConst.profileMetalsWebViewURL,
            title: APPStrings.metals.tr,
          )
        };
      case 'Ring sizer':
        return {
          RoutesData.cmsPageData: CmsWebViewDataModel(
            url: AppConst.profileRingSizerWebViewURL,
            title: APPStrings.ringSizer.tr,
          )
        };
      default:
        return defaultAction();
    }
  }

  // B2B sub category routes
  String? _getPDDRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Monitoring':
        return AppRoutes.monitoringPage;
      case 'Styles Listing':
        return AppRoutes.stylesListingPage;
      case 'Design Listing':
        return AppRoutes.designListingPage;
      case 'Project Listing':
        return AppRoutes.projectListingPage;
      case 'Presentation Listing':
        return AppRoutes.pddListingPage;
      case 'Concept Listing':
        return AppRoutes.conceptListPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getPDDRouteArgumentsB2B(String? categorySubName) {
    return defaultAction();
  }

  String? _getJewelleryRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stonesLandingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getJewelleryRouteArgumentsB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.landingForJewellery};
      default:
        return defaultAction();
    }
  }

  String? _getDiamondRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stonesLandingPage;
      default:
        return AppRoutes.stoneListingPage;
    }
  }

  Map<RoutesData, dynamic>? _getDiamondRouteArgumentsB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.landingForDiamonds};
      default:
        return defaultAction();
    }
  }

  String? _getGemstoneRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return AppRoutes.stonesLandingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getGemstoneRouteArgumentsB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Collection':
        return {RoutesData.isPageFor: ScreenIdentifier.landingForGemstones};
      default:
        return defaultAction();
    }
  }

  String? _getLibrariesRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Product Library - Grey':
        return AppRoutes.productListGridPage;
      case 'Product Library MF - Platinum':
        return AppRoutes.productListGridPage;
      case 'CAD Library':
        return AppRoutes.cadLibraryListingPage;
      case 'Style Library':
        return AppRoutes.cadLibraryListingPage;
      case 'Design Library':
        return AppRoutes.designLibraryScreen;
      case 'SKU Library':
        return AppRoutes.skuLibraryScreen;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getLibrariesRouteArgumentsB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Product Library - Grey':
        return {RoutesData.isPageFor: ScreenIdentifier.productForLibraryGrey};
      case 'Product Library MF - Platinum':
        return {RoutesData.isPageFor: ScreenIdentifier.productForLibraryPlatinum};
      case 'Style Library':
        return {RoutesData.isPageFor: ScreenIdentifier.productForLibraryStyle};
      case 'CAD Library':
        return {RoutesData.isPageFor: ScreenIdentifier.productForLibraryCAD};
      default:
        return defaultAction();
    }
  }

  String? _getDigitalCatalogueRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Digital \nCatalogue':
        return AppRoutes.digitalCataloguePage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getDigitalCatalogueRouteArgumentsB2B(String? categorySubName) {
    return defaultAction();
  }

  String? _getDoItYourselfRouteNameB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Diamond':
        return AppRoutes.stoneListingPage;
      default:
        return defaultAction();
    }
  }

  Map<RoutesData, dynamic>? _getDoItYourselfRouteArgumentsB2B(String? categorySubName) {
    switch (categorySubName) {
      case 'Diamond':
        return {RoutesData.isPageFor: ScreenIdentifier.diamondForDIY};
      default:
        return null;
    }
  }

  String? _getOrionRouteNameB2B(String? categorySubName) {
    return AppRoutes.orionPage;
  }

  Map<RoutesData, dynamic>? _getOrionRouteArgumentsB2B(String? categorySubName) {
    return defaultAction();
  }

  // This function returns the default action for the route
  defaultAction() {
    return null;
  }
}
