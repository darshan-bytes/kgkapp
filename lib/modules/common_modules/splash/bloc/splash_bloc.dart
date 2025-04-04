import 'package:kgk/kgk.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  late VideoPlayerController playerController;

  SplashBloc() : super(SplashInitial()) {
    on<LoadSplashEvent>(navigateToGetReadyScreen);
  }

  Future<void> navigateToGetReadyScreen(LoadSplashEvent event, Emitter<SplashState> emit) async {
    // Trigger a language change event
    BlocProvider.of<AppBloc>(event.context).add(LanguageChangedEvent(null, context: event.context));

    // Initialize and play the splash screen video
    try {
      playerController = VideoPlayerController.asset(AppConst.splashScreenVideoUrl);
      await playerController.initialize();
      await playerController.play();
    } catch (e) {
      debugPrint("Error initializing video player: $e");
    }

    await CachedNetworkImageProvider.defaultCacheManager.emptyCache();

    // Perform API calls for currency and language labels
    await _frontendLinkApiCall(event.context);
    await _currencyApiCall(event.context, emit);
    await _languageLabelApiCall(event.context, emit); // This is mainly use for get CMS Pages
    await BlocProvider.of<AppBloc>(event.context).sortOptionListApiCall(event.context);
    await navigateToNextScreen(event.context);
  }

  Future<void> _currencyApiCall(BuildContext context, Emitter<SplashState> emit) async {
    emit(const SplashVideoInitialized()); // Emit state indicating the video has been initialized

    // Fetch currencies from the user repository
    await UserRepository(context).getCurrencies().then((value) async {
      await value?.fold((l) {
        // Show error message if API call fails
      }, (r) async {
        // Store currency list in local storage if API call succeeds
        await StorageManager().setCurrencyList(r);
        CurrencyListModel? currency = StorageManager().getSelectedCurrency();
        if (currency == null) {
          CurrencyListModel? defaultCurrency = r.firstWhereOrNull((element) => element.isDefault == true) ?? r.firstOrNull;
          if (defaultCurrency != null) {
            await StorageManager().setSelectedCurrency(defaultCurrency);
            await StorageManager().setSelectedCurrencySymbol(defaultCurrency.symbol ?? '');
          }
        }
      });
    });
  }

  Future<void> _languageLabelApiCall(BuildContext context, Emitter<SplashState> emit) async {
    // Fetch language labels from the user repository
    final value = await UserRepository(context).getLanguageLabels(language: StorageManager().getLocale()?.code ?? APPStrings.languageEn);

    await value?.fold((l) {
      // Show error message if API call fails
    }, (r) async {
      // Store language labels in local storage if API call succeeds
      await StorageManager().setLanguageLabels(r.responseData);
      BlocProvider.of<AppBloc>(context).add(LanguageChangedEvent(null, context: context));
    });
  }

  //_frontendLinkApiCall
  Future<void> _frontendLinkApiCall(BuildContext context) async {
    await UserRepository(context).getFrontendLinks().then((value) async {
      await value?.fold((l) {
        // Show error message if API call fails
      }, (r) async {
        // Store language labels in local storage if API call succeeds
        if (r.containsKey(AppConst.link) && AppConst.frontendLink != r[AppConst.link]) {
          AppConst.frontendLink = r[AppConst.link];
        }
      });
    });
  }

  Future<void> _setPlaceholderImage() async {
    /// TODO :: CURRENTLY HARDCODED AS IT WILL BE IMPLEMENTED LATER
    Map<String, dynamic> placeholderImage = {
      "company_name": "KGK",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUZcwAnGzf6jqSF0KZ56DPv4-D5rmHk8g6dRJ4cJhx16gPZDtIntn9VbIotKcqkVQR9vI&usqp=CAU",
    };

    PlaceHolderData placeholderData = PlaceHolderData.fromJson(placeholderImage);
    _updatePlaceholderImage(placeholderData.companyName, placeholderData.imageUrl);
  }

  Future<void> _updatePlaceholderImage(String companyNameStr, String imageUrl) async {
    await StorageManager().setPlaceHolderImage(imageUrl);
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    // Determine the next route based on the presence of an auth token
    String? authToken = StorageManager().getAuthToken();
    UserIdDetails? userIdDetails = StorageManager().getUserData();
    if (authToken != null && userIdDetails != null) {
      BlocProvider.of<AppBloc>(context).add(SetUserTypeEvent(userIdDetails.userTypeEnum));
      await AppCrashlytics.instance.setUserId(userIdDetails.userAccountId ?? "----");
    }

    // Wait for the video to finish playing
    final Duration duration = playerController.value.duration;
    await Future.delayed(duration);

    String route = (authToken != null) ? AppRoutes.landingPage : AppRoutes.signInPage;
    context.pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Future<void> close() async {
    await playerController.dispose();
    return super.close();
  }
}
