import 'package:kgk/kgk.dart';

part 'complete_product_event.dart';

part 'complete_product_state.dart';

class CompleteProductBloc extends Bloc<CompleteProductEvent, CompleteProductState> {
  late AppBloc appBloc;
  DiamondDataModel? diamondDataForDIY;
  DiyStyleListModel? diyStyleForDIY;
  final CarouselSliderController controller = CarouselSliderController();
  final List<String> imgList = [];

  ProductDetailsModel? productDetails;
  ProductDetailsModel? diamondDetails;
  DiyFinalDetailsModel? diyFinalDetailsModel;
  String displaySpecification = '';
  String productName = '';
  String? settingId;
  String? diamondId;

  DIYPrice? dIYPrice;
  ScreenIdentifier? screenIdentifier;

  CompleteProductBloc() : super(CompleteProductInitial()) {
    on<CompleteProductInitialEvent>(_onCompleteProductInitialEvent);
    on<CompleteProductAddToBagEvent>(_onCompleteProductAddToBagEvent);
  }

  Future<void> _onCompleteProductInitialEvent(CompleteProductInitialEvent event, Emitter<CompleteProductState> emit) async {
    getScreenIdentifier(event.context);
    imgList.clear();
    await getSettingDetails(event.context, settingId);
    emit(const CompleteProductLoadedState());
  }

  void getScreenIdentifier(BuildContext context) {
    appBloc = BlocProvider.of<AppBloc>(context);
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor];
    }

    diamondDataForDIY = appBloc.diamondDataForDIY;
    diyStyleForDIY = appBloc.diyStyleForDIY;
    settingId = diyStyleForDIY?.suid;
  }

  Future<void> getSettingDetails(BuildContext context, String? settingId) async {
    final Map<String, String> query = {
      ApiKey.diamondSuid: diamondDataForDIY?.suid ?? '',
    };
    Either<ErrorResponse, DiyFinalDetailsModel>? response =
        await AppRepository(context).getDiySettingDetails(settingId ?? '', query: query);
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        diyFinalDetailsModel = r;
        if (r.product != null) {
          DiyStyleListModel item = r.product!;
          if (item.imageSketch.isNotNullNorEmpty) {
            imgList.clear();
            imgList.add(item.imageSketch ?? '');
          }
          productName = item.longDescription ?? '';

          productDetails = ProductDetailsModel(
            suid: r.sku,
            productId: r.sku,
            imageUrl: item.imageSketch,
            subTitle: item.autoDescription,
            originalPrice: item.finalPrice?.toString().setCurrency,
            offerPrice: item.discountPrice?.toString().setCurrency,
            finalPrice: item.discountPrice?.toString().setCurrency,
            commodity: Commodity.diy,
            businessCategoryName: item.businessCategoryName ?? "",
            colorsCode: [item.metalColor1HexCode ?? ""],
            components: item.components,
            productSku: r.sku,
            isAddedToCart: item.isAddedToCart,
          );
        }
        if (r.diamondDetailed != null) {
          DiamondDataModel diamondData = r.diamondDetailed!;
          diamondDetails = ProductDetailsModel(
            productId: diamondData.suid,
            suid: diamondData.suid,
            name: diamondData.rmDescription,
            offerPrice: diamondData.discountPrice?.setCurrency,
            originalPrice: diamondData.finalPrice?.setCurrency,
            productSku: diamondData.lotCode,
            reviewCount: diamondData.reviewCount,
            rating: diamondData.rating,
            commodity: Commodity.diy,
            stoneElements: diamondData.components,
            cut: diamondData.cut,
            clarity: diamondData.clarity,
            color: diamondData.color,
            ctsOrGms: diamondData.ctsOrGms,
            isAddedToCart: diamondData.isAddedToCart,
          );

          if (diamondData.cut.isNotNullNorEmpty) {
            displaySpecification += diamondData.cut ?? '';
          }
          if (diamondData.color.isNotNullNorEmpty) {
            if (displaySpecification.isNotNullNorEmpty) {
              displaySpecification += ' | ';
            }
            displaySpecification += diamondData.color!;
          }
          if (diamondData.clarity.isNotNullNorEmpty) {
            if (displaySpecification.isNotNullNorEmpty) {
              displaySpecification += ' | ';
            }
            displaySpecification += diamondData.clarity!;
          }
        }
        dIYPrice = r.dIYPrice;
      },
    );
  }

  Future<void> _onCompleteProductAddToBagEvent(CompleteProductAddToBagEvent event, Emitter<CompleteProductState> emit) async {
    if (productDetails != null) {
      if (productDetails!.isAddedToCart) {
        BlocProvider.of<LandingBloc>(event.context)
            .add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: event.context, isForce: true));
        event.context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
      } else {
        appBloc.add(ProductAddToBagEvent(productDetails!, event.context));
      }
    }
  }
}
