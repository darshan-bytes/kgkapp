import 'package:kgk/kgk.dart';

part 'diamond_detail_event.dart';
part 'diamond_detail_state.dart';

class DiamondDetailBloc extends Bloc<DiamondDetailEvent, DiamondDetailState> {

  final List<String> imgList = [
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
  ];

  int current = 0;
  final CarouselController controller = CarouselController();

  DiamondDetailBloc() : super(DiamondDetailInitial()) {
    on<DiamondDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DiamondImagePageChangeEvent>((event, emit) {
      current = event.index;
      emit(DiamondImagePageChangeState());
      emit(DiamondDetailInitial());
    });
  }
}
