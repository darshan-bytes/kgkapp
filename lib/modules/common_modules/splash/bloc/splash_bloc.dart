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
    BlocProvider.of<AppBloc>(event.context).add(LanguageChangedEvent('', context: event.context));

    playerController = VideoPlayerController.asset(AppConst.splashScreenVideoUrl);
    await playerController.initialize();
    await playerController.play();
    await _currencyApiCall(event.context, emit);
    await _languageLabelApiCall(event.context, emit);
  }

  Future<void> _currencyApiCall(BuildContext context, Emitter<SplashState> emit) async {
    emit(const SplashVideoInitialized());
    await UserRepository(context).getCurrencies().then((value) async {
      await value?.fold((l) {
        Utils.showMessage(l.message ?? '');
      }, (r) async {
        await StorageManager().setCurrencyList(r);
      });
    });
  }

  Future<void> _languageLabelApiCall(BuildContext context, Emitter<SplashState> emit) async {
    await UserRepository(context).getLanguageLabels().then((value) async {
      await value?.fold((l) {
        Utils.showMessage(l.message ?? '');
      }, (r) async {
        await StorageManager().setLanguageLabels(r.responseData);
        String languageCode = StorageManager().getLocale() ?? '';
        BlocProvider.of<AppBloc>(context).add(LanguageChangedEvent(languageCode, context: context));
      });
    });
    final Duration duration = playerController.value.duration;
    await Future.delayed(duration);
    context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
  }

  @override
  Future<void> close() async {
    await playerController.dispose();
    return super.close();
  }
}
