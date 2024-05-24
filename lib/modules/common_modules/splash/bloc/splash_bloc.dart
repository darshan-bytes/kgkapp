import 'package:kgk/kgk.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadSplashEvent>(navigateToGetReadyScreen);
  }

  void navigateToGetReadyScreen(LoadSplashEvent event, Emitter<SplashState> emit) {
    BlocProvider.of<AppBloc>(event.context).add(const LanguageChangedEvent(''));
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(event.context, AppRoutes.getReadyPage, (route) => false);
    });
  }
}
