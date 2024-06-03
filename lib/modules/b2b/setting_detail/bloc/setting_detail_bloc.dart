import 'package:kgk/kgk.dart';

part 'setting_detail_event.dart';

part 'setting_detail_state.dart';

class SettingDetailBloc extends Bloc<SettingDetailEvent, SettingDetailState> {
  bool isSettingOpen = false;
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

  SettingDetailBloc() : super(SettingDetailInitial()) {
    on<SettingToggleEvent>(onOpenCloseSetting);
    on<SettingImagePageChangeEvent>(_onRingImagePageChangeEvent);
  }

  Future onOpenCloseSetting(SettingToggleEvent event, emit) async {
    isSettingOpen = event.isSettingOpen;
    emit(SettingToggleState());
  }

  void _onRingImagePageChangeEvent(SettingImagePageChangeEvent event, Emitter<SettingDetailState> emit) {
    current = event.index;
    emit(SettingImagePageChangeState());
    emit(SettingDetailInitial());
  }
}
