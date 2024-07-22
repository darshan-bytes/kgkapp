import 'package:kgk/kgk.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  late BuildContext context;
  late VideoPlayerController playerController;

  SplashBloc() : super(SplashInitial()) {
    on<LoadSplashEvent>(navigateToGetReadyScreen);
  }

  Future<void> navigateToGetReadyScreen(LoadSplashEvent event, Emitter<SplashState> emit) async {
    BlocProvider.of<AppBloc>(event.context).add(const LanguageChangedEvent(''));

    playerController = VideoPlayerController.asset(AppConst.splashScreenVideoUrl);
    await playerController.initialize();
    await playerController.play();
    final Duration duration = playerController.value.duration;
    emit(const SplashVideoInitialized());
    await Future.delayed(duration);
    emit(const SplashVideoCompleteState());
    //For navigation
    event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
  }

  @override
  Future<void> close() async {
    await playerController.dispose();
    return super.close();
  }
}
