import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  String stoneListingAppbarTitle = "DIY";

  StoneListingBloc() : super(const StoneListingInitial()) {
    on<GetStoneProductListEvent>(_onGetStoneProductListEvent);
    on<StoneChangeTypeEvent>(_onStoneChangeTypeEvent);
    on<StoneChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<StoneProductChangePageNumberEvent>(_onPageNumberChanged);
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
  }

  Future<void> _onGetStoneProductListEvent(GetStoneProductListEvent event, Emitter<StoneListingState> emit) async {
    emit(const StoneLoadingState());
    getScreenIdentifier(event.context);
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      stoneListingAppbarTitle = APPStrings.diy.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                  originalPrice: "\$3,000.00",
                  discountPercentage: "Save UP TO 10%",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      stoneListingAppbarTitle = APPStrings.gemstone.tr;
      productList.clear();
      tabOneTitle = APPStrings.precious.tr;
      tabTwoTitle = APPStrings.semiPrecious.tr;
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl:
                      index % 2 == 0 ? "https://i.ibb.co/477f41r/Group-1410089379.png" : "https://i.ibb.co/sggT4PJ/Group-1410089378.png",
                  name: "0.35 Carat Super Premium Oval Moissanite",
                  originalPrice: "\$1,600 .00",
                ),
              ));
    } else {
      stoneListingAppbarTitle = APPStrings.diamond.tr;
      productList.clear();
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                    diamond: "2.5 crt",
                    gram: "1.5 grms",
                    imageUrl: "https://i.ibb.co/yBHp2KB/image-7.png",
                    name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                    originalPrice: "\$3,000.00"),
              ));
    }

    emit(const StoneListingInitial());
  }

  void _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) {
    isInitialToggle = event.isInitialToggle;
    emit(StoneChangeTypeState(isInitialToggle));
  }

  void _onChangeListingTypeEvent(StoneChangeListingTypeEvent event, Emitter<StoneListingState> emit) {
    isGrid = event.isGrid;
    emit(StoneChangeListingTypeState(event.isGrid));
  }

  void _onPageNumberChanged(StoneProductChangePageNumberEvent event, Emitter<StoneListingState> emit) {
    emit(StoneProductReloadState());
    selectedPageNumber = event.pageNumber;
    emit(StoneProductChangePageNumberState());
  }
}
