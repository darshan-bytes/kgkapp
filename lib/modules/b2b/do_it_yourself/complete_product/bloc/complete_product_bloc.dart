import 'package:kgk/kgk.dart';

part 'complete_product_event.dart';

part 'complete_product_state.dart';

class CompleteProductBloc extends Bloc<CompleteProductEvent, CompleteProductState> {
  late AppBloc appBloc;
  DiamondDataModel? diamondDataForDIY;
  final CarouselSliderController controller = CarouselSliderController();
  final List<String> imgList = [];

  bool isCompare = false;

  ProductDetailsModel? productDetails;
  ProductDetailsModel? diamondDetails;
  String displaySpecification = '';
  String productName = '';
  String? settingId;
  String? diamondId;

  DIYPrice? dIYPrice;

  CompleteProductBloc() : super(CompleteProductInitial()) {
    on<CompleteProductInitialEvent>(_onCompleteProductInitialEvent);
    on<CompleteProductCompareToggle>(_onCompleteProductCompareToggle);
  }

  Future<void> _onCompleteProductInitialEvent(CompleteProductInitialEvent event, Emitter<CompleteProductState> emit) async {
    getScreenIdentifier(event.context);
    imgList.clear();
    await getSettingDetails(event.context, settingId);
    emit(const CompleteProductLoadedState());
  }

  void _onCompleteProductCompareToggle(CompleteProductCompareToggle event, Emitter<CompleteProductState> emit) {
    isCompare = event.isCompare;
    emit(CompleteProductCompareToggleState(isCompare));
  }

  void getScreenIdentifier(BuildContext context) {
    appBloc = BlocProvider.of<AppBloc>(context);
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      settingId = data[RoutesData.settingId];
    }

    diamondDataForDIY = appBloc.diamondDataForDIY;
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
        if (r.product != null) {
          DiyStyleListModel item = r.product!;
          if (item.imageSketch.isNotNullNorEmpty) {
            imgList.clear();
            imgList.add(item.imageSketch ?? '');
          }
          productName = item.longDescription ?? '';

          productDetails = ProductDetailsModel(
            suid: item.suid,
            productId: item.suid,
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
}
