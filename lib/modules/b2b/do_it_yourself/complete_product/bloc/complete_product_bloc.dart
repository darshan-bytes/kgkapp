import 'package:kgk/kgk.dart';

part 'complete_product_event.dart';

part 'complete_product_state.dart';

class CompleteProductBloc extends Bloc<CompleteProductEvent, CompleteProductState> {
  int current = 0;
  final CarouselController controller = CarouselController();
  final List<String> imgList = [
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
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
