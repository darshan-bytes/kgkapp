import 'package:kgk/kgk.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<LoadSplashEvent>(navigateToSignInScreen);
  }

  void navigateToSignInScreen(LoadSplashEvent event, Emitter<SplashState> emit) async {
    BlocProvider.of<AppBloc>(event.context).add(const LanguageChangedEvent(''));
    await Future.delayed(const Duration(seconds: 3));
  }
}
