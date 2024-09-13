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
    // Trigger a language change event
    BlocProvider.of<AppBloc>(event.context).add(LanguageChangedEvent('', context: event.context));

    // Initialize and play the splash screen video
    playerController = VideoPlayerController.asset(AppConst.splashScreenVideoUrl);
    await playerController.initialize();
    await playerController.play();

    // Perform API calls for currency and language labels
    await _currencyApiCall(event.context, emit);
    await _languageLabelApiCall(event.context, emit);
  }

  Future<void> _currencyApiCall(BuildContext context, Emitter<SplashState> emit) async {
    emit(const SplashVideoInitialized()); // Emit state indicating the video has been initialized

    // Fetch currencies from the user repository
    await UserRepository(context).getCurrencies().then((value) async {
      await value?.fold((l) {
        // Show error message if API call fails
        Utils.showMessage(l.message ?? '');
      }, (r) async {
        // Store currency list in local storage if API call succeeds
        await StorageManager().setCurrencyList(r);
      });
    });
  }

  Future<void> _languageLabelApiCall(BuildContext context, Emitter<SplashState> emit) async {
    // Fetch language labels from the user repository
    await UserRepository(context).getLanguageLabels().then((value) async {
      await value?.fold((l) {
        // Show error message if API call fails
        Utils.showMessage(l.message ?? '');
      }, (r) async {
        // Store language labels in local storage if API call succeeds
        await StorageManager().setLanguageLabels(r.responseData);
        BlocProvider.of<AppBloc>(context).add(LanguageChangedEvent('', context: context));
      });
    });

    // Wait for the video to finish playing
    final Duration duration = playerController.value.duration;
    await Future.delayed(duration);

    // Determine the next route based on the presence of an auth token
    String? authToken = StorageManager().getAuthToken();
    UserIdDetails? userIdDetails = StorageManager().getUserData();
    if (authToken != null && userIdDetails != null) {
      BlocProvider.of<AppBloc>(context).add(SetUserTypeEvent(userIdDetails.userTypeEnum));
    }
    String route = (authToken != null) ? AppRoutes.landingPage : AppRoutes.signInPage;
    context.pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Future<void> close() async {
    await playerController.dispose();
    return super.close();
  }
}
