import 'package:kgk/kgk.dart';

part 'diamond_info_popup_event.dart';

part 'diamond_info_popup_state.dart';

class DiamondInfoPopupBloc extends Bloc<DiamondInfoPopupEvent, DiamondInfoPopupState> {
  DiamondInfoPopupBloc() : super(DiamondInfoPopupInitial()) {
    on<DiamondInfoPopupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
