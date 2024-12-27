import 'package:kgk/kgk.dart';

part 'stone_detail_event.dart';

part 'stone_detail_state.dart';

class StoneDetailBloc extends Bloc<StoneDetailEvent, StoneDetailState> {
  late AppBloc appBloc;

  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  List<String> imgList = [];
  List<ProductDetailsModel> suggestedProductList = [];
  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDefault;

  bool isStoneDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> stoneDetailsKey = GlobalKey();

  DiyDiamondDataModel? diamondData;
  String productName = '';
  ProductDetailsModel? productDetails;
  final CarouselSliderController controller = CarouselSliderController();

  StoneDetailBloc() : super(StoneDetailInitial()) {
    on<StoneDetailInitialEvent>(_stoneDetailInitialEvent);
    on<StoneDetailsToggleEvent>(_onStoneDetailsToggleEvent);
    on<StoneDetailSelectStoneForDIYEvent>(_onStoneDetailSelectStoneForDIYEvent);
  }

  @override
  Future<void> close() {
    appBloc.diamondDataForDIY = null;
    return super.close();
  }

  Future<void> _stoneDetailInitialEvent(StoneDetailInitialEvent event, Emitter<StoneDetailState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(event.context);
    // assigning current userType
    userType = appBloc.userType;
    Map<RoutesData, dynamic>? data = event.context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDefault;
    String productId = data?[RoutesData.productId] ?? '';
    if (productId.isEmpty) return;
    await getDIYDetails(event.context, productId);
    if (productDetails != null) {
      emit(StoneDetailLoadedState());
    }
  }

  void _onStoneDetailsToggleEvent(StoneDetailsToggleEvent event, Emitter<StoneDetailState> emit) {
    emit(StoneDetailReloadState());
    isStoneDetailsOpen = !isStoneDetailsOpen;
    emit(StoneDetailsToggleState(isStoneDetailsOpen));
  }

  Future<void> _onStoneDetailSelectStoneForDIYEvent(StoneDetailSelectStoneForDIYEvent event, Emitter<StoneDetailState> emit) async {
    appBloc.diamondDataForDIY = diamondData;
    await event.context.pushNamed(AppRoutes.settingListingPage);
  }

  Future<void> getDIYDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, DiyDiamondDataModel>? response = await AppRepository(context).diyDetails(id: productId);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        diamondData = data;
        if (diamondData != null) {
          bool isDiscounted =
              diamondData!.discountPercentage != null && (diamondData!.discountPercentage is num) && diamondData!.discountPercentage > 0;
          productName = diamondData!.rmDescription ?? '';
          imgList = diamondData!.image.map((e) => e.url ?? '').toList();
          productDetails = ProductDetailsModel(
            productId: productId,
            name: productName,
            lotCode: diamondData!.lotCode,
            offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
            originalPrice: diamondData!.finalPrice?.setCurrency,
            discountPercentageString:
                isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamondData!.discountPercentage]) : null,
            productSku: diamondData!.lotCode,
            commodity: Commodity.diamond,
          );
        }
      },
    );
  }
}
