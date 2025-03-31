import 'package:kgk/kgk.dart';

part 'diamond_info_popup_event.dart';

part 'diamond_info_popup_state.dart';

class DiamondInfoPopupBloc extends Bloc<DiamondInfoPopupEvent, DiamondInfoPopupState> {
  List<String> imgList = [];

  final CarouselSliderController controller = CarouselSliderController();

  ProductInfoModel productInfoModel = ProductInfoModel();
  DiamondDataModel? diamondDatum;

  ProductDetailsModel get productDetailsModel => ProductDetailsModel(
        suid: diamondDatum?.suid,
        commodity: Commodity.diamond,
        productId: diamondDatum?.suid,
        wishlistId: diamondDatum?.wishlistID,
        isFavourite: diamondDatum?.wishlistID.isNotNullNorEmpty == true,
        isAddedToCart: productInfoModel.isAddedToCart,
      );

  DiamondInfoPopupBloc() : super(const DiamondInfoPopupInitial()) {
    on<DiamondInfoPopupInitialEvent>(_onDiamondInfoPopupInitial);
  }

  void _onDiamondInfoPopupInitial(DiamondInfoPopupInitialEvent event, Emitter<DiamondInfoPopupState> emit) {
    emit(const DiamondInfoPopupLoading());
    diamondDatum = (event.context.routesData?[RoutesData.diamondInfo]) ?? DiamondDataModel.fromJson({});
    if (diamondDatum != null) {
      bool isDiscount = diamondDatum!.discountPercentage != null && diamondDatum!.discountPercentage! > 0;
      imgList = diamondDatum!.image.map((e) => e.url ?? '').toList();
      productInfoModel = ProductInfoModel(
        productId: diamondDatum!.suid,
        isAddedToCart: diamondDatum!.isAddedToCart,
        productName: diamondDatum!.rmDescription,
        offerPrice: diamondDatum!.discountPrice?.setCurrency,
        originalPrice: diamondDatum!.finalPrice?.setCurrency,
        lotNumber: diamondDatum!.lotCode,
        certificateNumber: diamondDatum!.certificate,
        size: diamondDatum!.size,
        shape: diamondDatum!.shape,
        carat: diamondDatum!.ctsOrGms?.toString(),
        color: diamondDatum!.color,
        clarity: diamondDatum!.clarity,
        cut: diamondDatum!.cut,
        lab: diamondDatum!.labs,
        polish: diamondDatum!.polish,
        symmetry: diamondDatum!.symmetry,
        fluorescence: diamondDatum!.fluorescence,
        location: diamondDatum!.location,
        tablePercentage: diamondDatum!.table,
        depthPercentage: diamondDatum!.depth,
        //TODO: Need to discuss with backend team for measurements
        length: "-",
        width: "-",
        depth: "-",
        crownAngle: diamondDatum!.crownAngle?.toString(),
        crownHeight: diamondDatum!.crownHeight?.toString(),
        pavilionAngle: diamondDatum!.pavilionAngle?.toString(),
        pavilionDepth: diamondDatum!.pavilionDepth?.toString(),
        girdle: diamondDatum!.girdle,
        culetSize: diamondDatum!.culetSize,
        girdleCondition: diamondDatum!.girdleCond,
        laserInclusion: diamondDatum!.laserInscription,
        lowerHalf: diamondDatum!.lowerHalf,
        starLength: diamondDatum!.starLength?.toString(),
        girdlePercentage: diamondDatum!.girdlePer,
        colorGrading: diamondDatum!.colorGrading,
        clarityGrading: diamondDatum!.clarityGrading,
        blackTable: diamondDatum!.blackTable,
        blackCrown: diamondDatum!.blackCrown,
        crownOpen: diamondDatum!.crownOpen,
        tableOpen: diamondDatum!.tableOpen,
        pavOpen: diamondDatum!.pavOpen,
        milkey: diamondDatum!.milky,
        //TODO: Need to discuss with backend team for heart and arrow
        heartAndArrow: "-",
        noBGM: diamondDatum!.noBgm,
        girdleInclusion: diamondDatum!.girdleInclusion,
        whiteInCenter: diamondDatum!.whiteInCenter,
        whiteInCrown: diamondDatum!.whiteInCrown,
        countryOfOrigin: diamondDatum!.origin,
        keyToSymbol: diamondDatum!.keyToSymbol,
        reportComments: diamondDatum!.comment,
        rap: diamondDatum!.rappaportPrice,
        discount: diamondDatum!.discountPercentage?.toString(),
        pricePerCrt: diamondDatum!.priceCts,
        amount: isDiscount ? diamondDatum!.discountPrice : diamondDatum!.finalPrice,
      );
    }
    emit(const DiamondInfoPopupLoaded());
  }
}
