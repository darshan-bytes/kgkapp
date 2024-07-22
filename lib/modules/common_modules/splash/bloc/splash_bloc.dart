import 'package:kgk/kgk.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  late BuildContext context;
  late VideoPlayerController playerController;
  bool isVideoInitialized = false;

  SplashBloc() : super(SplashInitial()) {
    on<LoadSplashEvent>(navigateToGetReadyScreen);
  }

  Future<void> navigateToGetReadyScreen(LoadSplashEvent event, Emitter<SplashState> emit) async {
    BlocProvider.of<AppBloc>(event.context).add(const LanguageChangedEvent(''));
    playerController = VideoPlayerController.asset(AppConst.splashScreenVideoUrl)..addListener(_videoListener);

    await playerController.initialize();
    await playerController.play();
    emit(SplashVideoInitialized(playerController: playerController));
    await Future.delayed(
      playerController.value.duration,
      () {
        event.context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
      },
    );
  }

  void _videoListener() {
    if (playerController.value.isInitialized) {
      isVideoInitialized = true;
      playerController.removeListener(_videoListener);
    }
  }

  @override
  Future<void> close() {
    playerController.dispose();
    playerController.removeListener(_videoListener);
    return super.close();
  }
}
