import 'package:kgk/kgk.dart';

part 'ring_detail_event.dart';
part 'ring_detail_state.dart';

class RingDetailBloc extends Bloc<RingDetailEvent, RingDetailState> {
  bool isSettingOpen = false;
  late BuildContext context;

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

  RingDetailBloc() : super(RingDetailInitial()) {
    on<RingSettingEvent>(onOpenCloseRingSetting);
    on<RingImagePageChangeEvent>((event, emit) {
      current = event.index;
      emit(RingImagePageChangeState());
      emit(RingDetailInitial());
    });
  }

  Future onOpenCloseRingSetting(RingSettingEvent event, emit) async {
    isSettingOpen = event.isSettingOpen;
    emit(RingSettingState());
  }
}
