import 'package:kgk/kgk.dart';

part 'setting_detail_event.dart';

part 'setting_detail_state.dart';

class SettingDetailBloc extends Bloc<SettingDetailEvent, SettingDetailState> {
  bool isSettingOpen = false;
  bool isDiamondDetailsOpen = false;

  GlobalKey<SmartExpansionTileState> settingDetailsKey = GlobalKey();
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();
  late BuildContext context;

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

  ProductCustomizationOptions metalCustomisation = ProductCustomizationOptions(
    id: '2',
    name: APPStrings.metal.tr,
    type: ProductCustomizationType.metal.value,
    selectedValue: ProductCustomizationOptionValues(id: '1', value: 'White Gold', image: 'https://i.ibb.co/Zzd66J6/Ellipse-117.png'),
    values: [
      ProductCustomizationOptionValues(id: '1', value: 'White Gold', image: 'https://i.ibb.co/Zzd66J6/Ellipse-117.png'),
      ProductCustomizationOptionValues(id: '2', value: 'Rose Gold', image: 'https://i.ibb.co/DYMS4xm/Ellipse-117-1.png'),
      ProductCustomizationOptionValues(id: '3', value: 'Yellow Gold', image: 'https://i.ibb.co/XsKxFtz/Ellipse-117-2.png'),
      ProductCustomizationOptionValues(id: '4', value: 'Silver', image: 'https://i.ibb.co/wJmc5Vq/Ellipse-117-3.png'),
      ProductCustomizationOptionValues(id: '5', value: 'Platinum', image: 'https://i.ibb.co/QbPWvNs/Ellipse-117-4.png'),
    ],
  );

  SettingDetailBloc() : super(SettingDetailInitial()) {
    on<SettingToggleEvent>(onOpenCloseSetting);
    on<SettingDiamondDetailsToggleEvent>(_onSettingDiamondDetailsToggleEvent);
    on<SettingImagePageChangeEvent>(_onRingImagePageChangeEvent);
    on<MetalCustomizationChangeEvent>(_onMetalCustomizationChangeEvent);
  }

  void onOpenCloseSetting(SettingToggleEvent event, emit) async {
    isSettingOpen = !isSettingOpen;
    emit(SettingToggleState(isSettingOpen));
  }

  void _onRingImagePageChangeEvent(SettingImagePageChangeEvent event, Emitter<SettingDetailState> emit) {
    current = event.index;
    emit(SettingImagePageChangeState());
    emit(SettingDetailInitial());
  }

  void _onMetalCustomizationChangeEvent(MetalCustomizationChangeEvent event, Emitter<SettingDetailState> emit) {
    int currentIndex = metalCustomisation.values!.indexWhere((element) => element == metalCustomisation.selectedValue);
    metalCustomisation.selectedValue = metalCustomisation.values![event.index];
    emit(MetalCustomizationChangeState(event.index, currentIndex));
  }

  void _onSettingDiamondDetailsToggleEvent(SettingDiamondDetailsToggleEvent event, Emitter<SettingDetailState> emit) {
    isDiamondDetailsOpen = !isDiamondDetailsOpen;
    emit(SettingDiamondToggleState(isDiamondDetailsOpen));
  }
}
