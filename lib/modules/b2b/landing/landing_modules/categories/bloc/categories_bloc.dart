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
  List<String> selectedCategoriesList = [];

  List<String> productsDetailsList = ['Collection', 'Best Selling', 'Seasonal Offers', 'Occasion Offer', 'Deals'];
  List<String> pddSubOptionsList = [
    'Concept Listing',
    'Presentation Listing',
    'Project Listing',
    'Design Listing',
    'Styles Listing',
    'Monitoring'
  ];

  List<String> librarySubOptionsList = [
    'Product Library - Grey',
    'Product Library MF - Platinum',
    'Design Library',
    'CAD Library',
    'Seasonal Offers',
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
    if (userType == UserType.b2bUser) {
      categories.clear();
      categories.addAll([
        CategoriesModel(name: 'PDD', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: pddSubOptionsList),
        CategoriesModel(name: 'Jewellery', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Diamond', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Gemstone', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Libraries', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: librarySubOptionsList),
        CategoriesModel(
            name: 'Digital \nCatalogue',
            image: 'https://i.ibb.co/ZWKWks5/Image.png',
            productsDetailsList: productsDetailsList,
            isExpanded: false),
        CategoriesModel(name: 'Do It \nYourself', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(
            name: 'Orion', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList, isExpanded: false),
      ]);
    } else {
      categories.addAll([
        CategoriesModel(
          name: 'Natural \nDiamonds',
          image: 'https://i.ibb.co/HgjT1rt/Image.png',
        ),
        CategoriesModel(
            name: 'Lab-grown \nDiamonds', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Gemstone', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Jewellery', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Do It \nYourself', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'About Us', image: 'https://i.ibb.co/ZWKWks5/Image.png', productsDetailsList: productsDetailsList),
        CategoriesModel(name: 'Education', image: 'https://i.ibb.co/HgjT1rt/Image.png', productsDetailsList: productsDetailsList),
      ]);
    }
    emit(CategoriesFetchData());
  }

  void navigateBasedOnCategory(BuildContext context, String categoryName, String categorySubName) {
    switch (categoryName) {
      case 'Gemstone':
        context.pushNamed(
          AppRoutes.stoneListingPage,
          arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones},
        );
        break;

      case 'Do It \nYourself':
        context.pushNamed(
          AppRoutes.stoneListingPage,
          arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDIY},
        );
        break;

      case 'PDD':
        if (categorySubName == 'Monitoring') {
          context.pushNamed(AppRoutes.monitoringPage);
        } else if (categorySubName == 'Styles Listing') {
          context.pushNamed(AppRoutes.stylesListingPage);
        } else if (categorySubName == 'Design Listing') {
          context.pushNamed(AppRoutes.designListingPage);
        } else if (categorySubName == 'Project Listing') {
          context.pushNamed(AppRoutes.projectListingPage);
        } else if (categorySubName == 'Presentation Listing') {
          context.pushNamed(AppRoutes.pddListingPage);
        } else if (categorySubName == 'Concept Listing') {
          context.pushNamed(AppRoutes.conceptListPage);
        } else {
          context.pushNamed(AppRoutes.conceptListPage);
        }
        break;

      case 'Project':
        context.pushNamed(AppRoutes.projectListingPage);
        break;

      case 'Libraries':
        if (categorySubName == 'Product Library MF - Platinum') {
          context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForLibraryPlatinum});
        } else if (categorySubName == 'CAD Library') {
          context.pushNamed(AppRoutes.cadLibraryListingPage);
        } else {
          context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForLibraryGrey});
        }
        break;

      default:
        // Handle the default case if needed
        break;
    }
  }
}
