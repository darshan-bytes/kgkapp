import 'package:kgk/kgk.dart';

part 'complete_product_event.dart';

part 'complete_product_state.dart';

class CompleteProductBloc extends Bloc<CompleteProductEvent, CompleteProductState> {
  int current = 0;
  final CarouselController controller = CarouselController();
  final List<String> imgList = [
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
  ];

  bool isCompare = false;
  bool isRingDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> ringDetailsKey = GlobalKey();
  bool isDiamondDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();

  CompleteProductBloc() : super(CompleteProductInitial()) {
    on<CompleteProductImageChangeEvent>(_onCompleteProductImageChangeEvent);
    on<CompleteProductCompareToggle>(_onCompleteProductCompareToggle);
    on<ProductRingDetailsToggleEvent>(_onProductRingDetailsToggleEvent);
    on<ProductDiamondDetailsToggleEvent>(_onProductDiamondDetailsToggleEvent);
  }

  void _onCompleteProductImageChangeEvent(CompleteProductImageChangeEvent event, Emitter<CompleteProductState> emit) {
    current = event.index;
    emit(CompleteProductImagePageChangeState(current));
  }

  void _onCompleteProductCompareToggle(CompleteProductCompareToggle event, Emitter<CompleteProductState> emit) {
    isCompare = event.isCompare;
    emit(CompleteProductCompareToggleState(isCompare));
  }

  void _onProductRingDetailsToggleEvent(ProductRingDetailsToggleEvent event, Emitter<CompleteProductState> emit) {
    isRingDetailsOpen = event.isRingDetailsOpen;
    emit(CompleteProductRingDetailsToggleState(isRingDetailsOpen));
  }

  void _onProductDiamondDetailsToggleEvent(ProductDiamondDetailsToggleEvent event, Emitter<CompleteProductState> emit) {
    isDiamondDetailsOpen = event.isDiamondDetailsOpen;
    emit(CompleteProductDiamondDetailsToggleState(isDiamondDetailsOpen));
  }
}
