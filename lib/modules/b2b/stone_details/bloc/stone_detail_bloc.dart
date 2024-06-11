import 'package:kgk/kgk.dart';

part 'stone_detail_event.dart';

part 'stone_detail_state.dart';

class StoneDetailBloc extends Bloc<StoneDetailEvent, StoneDetailState> {
  final List<String> imgList = [
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
    "https://i.ibb.co/8s6hWz2/image-414.png",
  ];

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDefault;

  bool isStoneDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> stoneDetailsKey = GlobalKey();

  int current = 0;
  final CarouselController controller = CarouselController();

  StoneDetailBloc() : super(StoneDetailInitial()) {
    on<StoneDetailInitialEvent>(_stoneDetailInitialEvent);
    on<StoneDetailsToggleEvent>(_onStoneDetailsToggleEvent);
  }

  void _stoneDetailInitialEvent(StoneDetailInitialEvent event, Emitter<StoneDetailState> emit) {
    Map<RoutesData, dynamic>? data = event.context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDefault;
    emit(StoneDetailReloadedState());
  }

  void _onStoneDetailsToggleEvent(StoneDetailsToggleEvent event, Emitter<StoneDetailState> emit) {
    emit(StoneDetailReloadState());
    isStoneDetailsOpen = !isStoneDetailsOpen;
    emit(StoneDetailsToggleState(isStoneDetailsOpen));
  }
}
