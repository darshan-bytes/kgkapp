import 'package:kgk/kgk.dart';

part 'diamond_listing_event.dart';

part 'diamond_listing_state.dart';

class DiamondListingBloc extends Bloc<DiamondListingEvent, DiamondListingState> {
  bool isIndividual = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  String diamondListingAppbarTitle = "DIY";

  DiamondListingBloc() : super(const DiamondListingInitial()) {
    on<GetDiamondProductListEvent>(_onGetDiamondProductListEvent);
    on<DiamondChangeTypeEvent>(_onDiamondChangeTypeEvent);
    on<ChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<DiamondProductChangePageNumberEvent>(_onPageNumberChanged);
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
  }

  Future<void> _onGetDiamondProductListEvent(GetDiamondProductListEvent event, Emitter<DiamondListingState> emit) async {
    emit(const LoadingState());
    getScreenIdentifier(event.context);
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      diamondListingAppbarTitle = APPStrings.diy.tr;
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
    } else if (screenIdentifier == ScreenIdentifier.diamondForGemstones) {
      diamondListingAppbarTitle = APPStrings.gemstone.tr;
      productList.clear();
      tabOneTitle = APPStrings.precious.tr;
      tabTwoTitle = APPStrings.semi_precious.tr;
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
      diamondListingAppbarTitle = APPStrings.diamond.tr;
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

    emit(const DiamondListingInitial());
  }

  void _onDiamondChangeTypeEvent(DiamondChangeTypeEvent event, Emitter<DiamondListingState> emit) {
    isIndividual = event.isIndividual;
    emit(DiamondChangeTypeState(isIndividual));
  }

  void _onChangeListingTypeEvent(ChangeListingTypeEvent event, Emitter<DiamondListingState> emit) {
    isGrid = event.isGrid;
    emit(ChangeListingTypeState(event.isGrid));
  }

  void _onPageNumberChanged(DiamondProductChangePageNumberEvent event, Emitter<DiamondListingState> emit) {
    emit(DiamondProductReloadState());
    selectedPageNumber = event.pageNumber;
    emit(DiamondProductChangePageNumberState());
  }
}
