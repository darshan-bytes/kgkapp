import 'package:kgk/kgk.dart';

part 'ring_detail_event.dart';
part 'ring_detail_state.dart';

class RingDetailBloc extends Bloc<RingDetailEvent, RingDetailState> {
  bool isSettingOpen = false;
  late BuildContext context;

  int current = 0;
  final CarouselController controller = CarouselController();

  final List<String> imgList = [
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
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
