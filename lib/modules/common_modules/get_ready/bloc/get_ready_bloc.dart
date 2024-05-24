import 'package:kgk/kgk.dart';

part 'get_ready_event.dart';

part 'get_ready_state.dart';

class GetReadyBloc extends Bloc<GetReadyEvent, GetReadyState> {
  GetReadyBloc() : super(GetReadyInitialState()) {
    on<LoadGetReadyEvent>(navigateToSignInScreen);
  }

  void navigateToSignInScreen(LoadGetReadyEvent event, Emitter<GetReadyState> emit) async {}
}
