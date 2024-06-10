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

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDefault;

  bool isDiamondDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();

  int current = 0;
  final CarouselController controller = CarouselController();

  DiamondDetailBloc() : super(DiamondDetailInitial()) {
    on<DiamondDetailInitialEvent>(_diamondDetailInitialEvent);
    on<DiamondImagePageChangeEvent>(_diamondImagePageChange);
    on<DiamondDetailsToggleEvent>(_onDiamondDetailsToggleEvent);
  }

  void _diamondDetailInitialEvent(DiamondDetailInitialEvent event, Emitter<DiamondDetailState> emit) {
    Map<RoutesData, dynamic>? data = event.context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDefault;
    emit(DiamondDetailReloadedState());
  }

  void _diamondImagePageChange(DiamondImagePageChangeEvent event, Emitter<DiamondDetailState> emit) {
    current = event.index;
    emit(DiamondImagePageChangeState());
    emit(DiamondDetailInitial());
  }

  void _onDiamondDetailsToggleEvent(DiamondDetailsToggleEvent event, Emitter<DiamondDetailState> emit) {
    emit(DiamondDetailReloadState());
    isDiamondDetailsOpen = !isDiamondDetailsOpen;
    emit(DiamondDetailsToggleState(isDiamondDetailsOpen));
  }
}
