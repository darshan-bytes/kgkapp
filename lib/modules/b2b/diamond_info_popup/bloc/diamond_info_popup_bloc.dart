import 'package:kgk/kgk.dart';

part 'diamond_info_popup_event.dart';

part 'diamond_info_popup_state.dart';

class DiamondInfoPopupBloc extends Bloc<DiamondInfoPopupEvent, DiamondInfoPopupState> {
  final List<String> imgList = [
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
  ];

  final CarouselSliderController controller = CarouselSliderController();

  final ProductInfoModel productInfoModel = ProductInfoModel(
    productName: "1.00 Carat Round Diamond",
    offerPrice: "\$10,000",
    originalPrice: "\$11,000",
    lotNumber: "MBFG716306",
    certificateNumber: "230000066395",
    size: "30 Down",
    shape: "Round",
    carat: "1.00",
    color: "H",
    clarity: "VVS2",
    cut: "Excellent",
    lab: "GIA",
    polish: "Excellent",
    symmetry: "Excellent",
    fluorescence: "Faint",
    location: "India",
    tablePercentage: "50",
    depthPercentage: "46",
    length: "10.18",
    width: "8.34",
    depth: "6.14",
    crownAngle: "1.0 to 1.5",
    crownHeight: "1.0 to 1.5",
    pavilionAngle: "1.0 to 1.5",
    pavilionDepth: "1.0 to 1.5",
    girdle: "VTN-THN",
    culetSize: "H",
    girdleCondition: "Polished",
    laserInclusion: "No",
    lowerHalf: "43%",
    starLength: "17%",
    girdlePercentage: "3.3",
    colorGrading: "H",
    clarityGrading: "VVS2",
    blackTable: "Yes",
    blackCrown: "No",
    crownOpen: "Yes",
    tableOpen: "No",
    pavOpen: "Yes",
    milkey: "No",
    heartAndArrow: "Yes",
    noBGM: "Yes",
    girdleInclusion: "No",
    whiteInCenter: "No",
    whiteInCrown: "Yes",
    countryOfOrigin: "South Africa",
    keyToSymbol: "Crystal surface",
    reportComments: "NA",
    rap: "\$35,500.00",
    discount: "-30.00%",
    pricePerCrt: "\$24,850.00",
    amount: "\$1,24,995.50",
  );

  DiamondInfoPopupBloc() : super(DiamondInfoPopupInitial()) {
    on<DiamondInfoPopupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
