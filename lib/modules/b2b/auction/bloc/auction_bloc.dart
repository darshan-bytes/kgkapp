import 'package:kgk/kgk.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  int current = 0;
  final CarouselController controller = CarouselController();
  bool isCompare = false;

  final List<String> imgList = [
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
  ];

  List<ProductDetails> suggestedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$ 3,000",
    ),
  );

  AuctionBloc() : super(AuctionInitial()) {
    on<AuctionDiamondImagePageChangeEvent>(_onAuctionDiamondImagePageChangeEvent);
    on<AuctionProductCompareToggleEvent>(_onAuctionProductCompareToggle);
  }

  void _onAuctionDiamondImagePageChangeEvent(AuctionDiamondImagePageChangeEvent event, Emitter<AuctionState> emit) {
    current = event.index;
    emit(AuctionDiamondImagePageChangeState());
  }

  void _onAuctionProductCompareToggle(AuctionProductCompareToggleEvent event, Emitter<AuctionState> emit) {
    emit(const AuctionReloadState());
    isCompare = !isCompare;
    emit(const AuctionProductCompareToggleState());
  }
}
