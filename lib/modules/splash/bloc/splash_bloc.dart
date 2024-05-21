import 'package:kgk/kgk.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<LoadSplashEvent>(navigateToSignInScreen);
  }

  void navigateToSignInScreen(LoadSplashEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
