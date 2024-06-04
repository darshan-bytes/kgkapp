import 'package:kgk/kgk.dart';

part 'diamond_detail_event.dart';

part 'diamond_detail_state.dart';

class DiamondDetailBloc extends Bloc<DiamondDetailEvent, DiamondDetailState> {
  final List<String> imgList = [
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
  ];

  bool isDiamondDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();

  int current = 0;
  final CarouselController controller = CarouselController();

  DiamondDetailBloc() : super(DiamondDetailInitial()) {
    on<DiamondImagePageChangeEvent>((event, emit) {
      current = event.index;
      emit(DiamondImagePageChangeState());
      emit(DiamondDetailInitial());
    });
    on<DiamondDetailsToggleEvent>(_onDiamondDetailsToggleEvent);
  }

  void _onDiamondDetailsToggleEvent(DiamondDetailsToggleEvent event, Emitter<DiamondDetailState> emit) {
    emit(DiamondDetailReloadState());
    isDiamondDetailsOpen = !isDiamondDetailsOpen;
    emit(DiamondDetailsToggleState(isDiamondDetailsOpen));
  }
}
