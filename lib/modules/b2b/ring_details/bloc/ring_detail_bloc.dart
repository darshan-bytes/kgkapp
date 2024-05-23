import 'package:kgk/kgk.dart';

part 'ring_detail_event.dart';
part 'ring_detail_state.dart';

class RingDetailBloc extends Bloc<RingDetailEvent, RingDetailState> {
  bool isSettingOpen = false;
  late BuildContext context;

  RingDetailBloc() : super(RingDetailInitial()) {
    on<RingSettingEvent>(onOpenCloseRingSetting);
  }

  Future onOpenCloseRingSetting(RingSettingEvent event, emit) async {
    isSettingOpen = event.isSettingOpen;
    emit(RingSettingState());
  }
}
