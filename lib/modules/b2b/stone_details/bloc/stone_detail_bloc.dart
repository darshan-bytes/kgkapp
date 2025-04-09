import 'package:kgk/kgk.dart';

part 'stone_detail_event.dart';

part 'stone_detail_state.dart';

class StoneDetailBloc extends Bloc<StoneDetailEvent, StoneDetailState> {
  late AppBloc appBloc;

  UserType userType = UserType.b2cUser;

  List<String> imgList = [];
  List<ProductDetailsModel> suggestedProductList = [];
  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDefault;
  Map<dynamic, String?>? filterDataMap;

  bool isStoneDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> stoneDetailsKey = GlobalKey();

  DiamondDataModel? diamondData;
  String productName = '';
  ProductDetailsModel? productDetails;
  final CarouselSliderController controller = CarouselSliderController();

  StoneDetailBloc() : super(StoneDetailInitial()) {
    on<StoneDetailInitialEvent>(_stoneDetailInitialEvent);
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
    filterDataMap = data?[RoutesData.filterData] ?? {};
    String productId = data?[RoutesData.productId] ?? '';
    if (productId.isEmpty) return;
    await getDIYDetails(event.context, productId);
    if (productDetails != null) {
      emit(StoneDetailLoadedState());
    }
  }

  Future<void> _onStoneDetailSelectStoneForDIYEvent(StoneDetailSelectStoneForDIYEvent event, Emitter<StoneDetailState> emit) async {
    appBloc.diamondDataForDIY = diamondData;
    final route = screenIdentifier == ScreenIdentifier.diamondForDIY ? AppRoutes.settingListingPage : AppRoutes.completeProductPage;

    await event.context.pushNamed(route);
  }

  Future<void> getDIYDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondDataModel>? response = await AppRepository(context).diyDetails(id: productId);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        diamondData = data;
        if (diamondData != null) {
          productName = diamondData!.rmDescription ?? '';
          imgList = diamondData!.image.map((e) => e.url ?? '').toList();
          productDetails = Utils.convertDiamondDataModelToProductDetailsModel(diamond: diamondData!);
        }
      },
    );
  }
}
