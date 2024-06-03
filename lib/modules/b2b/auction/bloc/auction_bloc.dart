import 'package:kgk/kgk.dart';

part 'auction_event.dart';

part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  final List<String> imgList = [
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
  ];

  int current = 0;
  final CarouselController controller = CarouselController();

  AuctionBloc() : super(AuctionInitial()) {
    on<AuctionDiamondImagePageChangeEvent>((event, emit) {
      current = event.index;
      emit(AuctionDiamondImagePageChangeState());
      emit(AuctionInitial());
    });
  }
}
