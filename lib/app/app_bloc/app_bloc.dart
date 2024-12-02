import 'package:kgk/kgk.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppThemes appThemes = AppThemes();
  final Connectivity _connectivity = Connectivity();
  late Stream<List<ConnectivityResult>> _connectivityStream;
  List<Locale> supportedLocales = const [
    Locale(APPStrings.languageEn, ''), // English
    Locale(APPStrings.languageAr, ''),
    Locale(APPStrings.languageHi, ''),
    Locale(APPStrings.languageJa, ''),
    // Locale(APPStrings.languageTh, ''),
    Locale(APPStrings.languageZh, ''),
  ];
  List<LocalizationsDelegate<Object>> localizationsDelegates = const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalizations.delegate,
    CountryLocalizations.delegate,
  ];
  ThemeData? themeData;
  Locale locale = const Locale(APPStrings.languageEn);

  bool isLoading = false;

  UserType userType = UserType.b2cUser;

  int notificationCount = 1;

  ///For wishlist
  Timer? _debounce;

  List<CountryStateModel> countryList = [];

  Map<String, List<CountryStateModel>> countryStateMap = {};

  List<AddressDetails> savedAddressList = [];

  AppBloc() : super(AppInitial()) {
    on<LoadAppEvent>(_onLoadAppEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
    on<ConnectivityChangedEvent>(_onConnectivityChangedEvent);
    on<LanguageChangedEvent>(_onLanguageChangedEvent);
    on<SetAppLoadingEvent>(_onSetLoadingEvent);
    on<SetUserTypeEvent>(_onSetUserTypeEvent);
    on<ProductAddToFavoriteEvent>(_onProductAddToFavoriteEvent);
    on<ProductRemoveFromFavoriteEvent>(_onProductRemoveFromWishlist);
    on<ProductAddToBagEvent>(_onProductAddToBagEvent);
    on<ProductRemoveFromBagEvent>(_onProductRemoveFromBagEvent);
  }

  void _onLoadAppEvent(LoadAppEvent event, Emitter<AppState> emit) async {
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen((result) {
      bool isConnected = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet);
      add(ConnectivityChangedEvent(isConnected));
    });

    final String theme = StorageManager().getThemeData();
    debugPrint("theme $theme");
    if (theme == 'dark') {
      themeData = appThemes.dark();
      emit(ThemeDataState(appThemes.dark()));
    } else if (theme == 'light') {
      themeData = appThemes.light();
      emit(ThemeDataState(appThemes.light()));
    } else if (theme == 'system') {
      //TODO: Need to change based on system theme
    }
  }

  void _onChangeThemeEvent(ChangeThemeEvent event, Emitter<AppState> emit) async {
    String theme = event.theme;
    if (theme == 'dark') {
      await setThemeDataDark(emit);
    } else if (theme == 'light') {
      await setThemeDataLight(emit);
    } else if (theme == 'system') {
      bool systemTheme = StorageManager().getSystemTheme();
      //TODO: Need to change based on system theme
      if (systemTheme) {
        await setThemeDataDark(emit);
      } else {
        await setThemeDataLight(emit);
      }
    }
  }

  Future<void> setThemeDataDark(Emitter<AppState> emit) async {
    themeData = appThemes.dark();
    await StorageManager().setThemeData('dark');
    emit(ThemeDataState(appThemes.dark()));
  }

  Future<void> setThemeDataLight(Emitter<AppState> emit) async {
    themeData = appThemes.light();
    await StorageManager().setThemeData('light');
    emit(ThemeDataState(appThemes.light()));
  }

  void _onConnectivityChangedEvent(ConnectivityChangedEvent event, Emitter<AppState> emit) {
    emit(ConnectivityState(event.connectivityResult));
  }

  Future<void> _onLanguageChangedEvent(LanguageChangedEvent event, Emitter<AppState> emit) async {
    if (event.languageCode.isNotEmpty) {
      await StorageManager().setLocale(event.languageCode);
      await _languageLabelApiCall(event.context);
    }
    await AppLocalizations.of(getNavigatorKeyContext)?.changeLocale();
    locale = AppLocalizations.of(getNavigatorKeyContext)?.locale ?? const Locale(APPStrings.languageEn);
    emit(LanguageState(locale));
  }

  void _onSetLoadingEvent(SetAppLoadingEvent event, Emitter<AppState> emit) {
    isLoading = event.isLoading;
    emit(AppLoadingState(isLoading));
  }

  void _onSetUserTypeEvent(SetUserTypeEvent event, Emitter<AppState> emit) {
    userType = event.userType;
    emit(UserTypeState(userType));
  }

  Future<void> _languageLabelApiCall(BuildContext context) async {
    await UserRepository(context)
        .getLanguageLabels(showLoader: true, language: StorageManager().getLocale() ?? APPStrings.languageEn)
        .then((value) async {
      await value?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) async {
        StorageManager().setLanguageLabels(r.responseData);
      });
    });
  }

  void onTapFavorite(context, {required ProductDetailsModel productDetails}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (productDetails.isFavourite && productDetails.wishlistId.isNotNullNorEmpty) {
        BlocProvider.of<AppBloc>(context).add(ProductRemoveFromFavoriteEvent(productDetails, context));
      } else {
        BlocProvider.of<AppBloc>(context).add(ProductAddToFavoriteEvent(productDetails, context));
      }
    });
  }

  void onTapBag(context, {required ProductDetailsModel productDetails}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(productDetails, context));
    });
  }

  ///for add product to wishlist
  Future<void> _onProductAddToFavoriteEvent(ProductAddToFavoriteEvent event, Emitter<AppState> emit) async {
    emit(AppReloadState());
    Map<String, dynamic> body = {
      ApiKey.productId_: event.productDetails.productId,
      ApiKey.commodity: event.productDetails.commodity?.value
    };
    await AppRepository(event.context).createWishList(body: body).then(
      (response) {
        response?.fold(
          (l) {
            Utils.showMessage(l.message);
          },
          (data) {
            Utils.showMessage(data.message);
            WishlistResponseModel model = data.responseData.first as WishlistResponseModel;
            event.productDetails.wishlistId = model.id;
            event.productDetails.isFavourite = true;
            if (event.context.mounted) {
              BlocProvider.of<WishlistUpdaterServiceBloc>(event.context)
                  .add(WishListUpdateProductEvent(event.productDetails.productId ?? '', wishlistId: model.id ?? ''));
            }
            emit(const ProductAddToFavoriteState());
          },
        );
      },
    );
  }

  ///for remove product from wishlist
  Future<void> _onProductRemoveFromWishlist(ProductRemoveFromFavoriteEvent event, Emitter<AppState> emit) async {
    emit(AppReloadState());
    await AppRepository(event.context).deleteWishList(event.productDetails.wishlistId ?? '').then(
      (response) {
        response?.fold(
          (l) {
            Utils.showMessage(l.message);
          },
          (data) {
            Utils.showMessage(data.message);
            event.productDetails.isFavourite = false;
            event.productDetails.wishlistId = "";
            if (event.context.mounted) {
              BlocProvider.of<WishlistUpdaterServiceBloc>(event.context)
                  .add(WishListUpdateProductEvent(event.productDetails.productId ?? '', wishlistId: ''));
            }
            emit(const ProductRemoveFromFavoriteState());
          },
        );
      },
    );
  }

  // Add to bag event
  Future<void> _onProductAddToBagEvent(ProductAddToBagEvent event, Emitter<AppState> emit) async {
    MyBagDataModel? myBagDataModel = StorageManager().getBagData();
    String userId = StorageManager().getUserId() ?? '';

    if (myBagDataModel != null && myBagDataModel.commodity != event.productDetails.commodity?.value) {
      await _deleteAndRetryBag(event, emit, myBagDataModel.sId ?? '');
    }
    await _addToBag(event, userId);
  }

  // Add to bag
  Future<void> _addToBag(ProductAddToBagEvent event, String userId) async {
    Map<String, dynamic> body = {
      ApiKey.commodity: event.productDetails.commodity?.value,
      ApiKey.quantity: 1,
      ApiKey.suid: event.productDetails.productId,
      ApiKey.userId: userId,
    };

    MyBagDataModel? myBagDataModel = StorageManager().getBagData();
    if (myBagDataModel != null) {
      String id = myBagDataModel.sId ?? '';
      body[ApiKey.id] = id;
    }

    await AppRepository(event.context).addToBag(body: body).then((response) {
      response?.fold(
        (l) => Utils.showMessage(l.message),
        (data) async {
          MyBagDataModel myBagDataModel = data.responseData;
          await StorageManager().storeBagData(myBagDataModel);
          Utils.showMessage(data.message);
        },
      );
    });
  }

  // Delete and retry bag
  Future<void> _deleteAndRetryBag(ProductAddToBagEvent event, Emitter<AppState> emit, String bagId, {String suid = ''}) async {
    if (bagId.isNullOrEmpty) {
      return;
    }
    Map<String, dynamic> body = {ApiKey.id: bagId, ApiKey.suid: suid};

    await AppRepository(event.context).deleteBag(body: body).then((response) {
      response?.fold(
        (l) => Utils.showMessage(l.message),
        (data) async {
          await StorageManager().clearBagData();
          Utils.showMessage(data.message);
        },
      );
    });
  }

  Future<void> _onProductRemoveFromBagEvent(event, Emitter<AppState> emit) async {
    /// Implementing it later

    if (event.productDetails.productId.isNullOrEmpty) {
      return;
    }

    /// TODO :: Temporary added static bag id here
    await _deleteAndRetryBag(event, emit, "674982171e6515593f727ec6", suid: "DIS268");
  }

  // Get gemstone filter option list
  Future<List<FilterOptionModel>> getFilterOptionList(BuildContext context, String type) async {
    List<FilterOptionModel> filterList = [];
    Either<ErrorResponse, List<FilterOptionModel>>? response;
    response = await AppRepository(context).fetchFilterOptionList(type: type);
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) {
      filterList = r;
    });
    return filterList;
  }

  Future<List<CountryStateModel>> getCountries(BuildContext context, {bool isShowLoader = true}) async {
    if (countryList.isEmpty) {
      Either<ErrorResponse, List<CountryStateModel>>? response;
      response = await AppRepository(context).fetchCountryList();
      response?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        countryList = r;
      });
    }
    return countryList;
  }

  Future<List<CountryStateModel>> getStateByCountryCode(BuildContext context, String countryCode, {bool isShowLoader = true}) async {
    List<CountryStateModel> stateList = [];
    if (countryStateMap.containsKey(countryCode) && countryStateMap[countryCode].isNotNullNorEmpty) {
      stateList = countryStateMap[countryCode]!;
      return stateList;
    }
    Either<ErrorResponse, List<CountryStateModel>>? response;
    response = await AppRepository(context).fetchStateByCountry(countryCode: countryCode, isShowLoader: isShowLoader);
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) {
      stateList = r;
      countryStateMap[countryCode] = r;
    });
    return stateList;
  }

  Future<List<AddressDetails>> fetchAddressList(BuildContext context, {bool isShowLoader = true, bool isForceFetch = false}) async {
    if (savedAddressList.isEmpty || isForceFetch) {
      Either<ErrorResponse, List<AddressDetails>>? response = await AppRepository(context).fetchAddressList();
      response?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        savedAddressList = r;
      });
    }
    return savedAddressList;
  }

  Future<List<ShapeMasterDetails>> fetchShapeMasterFilters(BuildContext context,
      {bool isShowLoader = true, bool isForceFetch = false}) async {
    List<ShapeMasterDetails> shapeMasterDetails = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.filters: {ApiKey.dynamicObject: {}},
        ApiKey.pagination: {ApiKey.limit: 10, ApiKey.page: 1},
        ApiKey.search: "",
        ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc}
      };
      Either<ErrorResponse, PaginationData<ShapeMasterDetails>>? response = await AppRepository(context).shapeMasterFilters(body: body);
      response?.fold((l) {
        Utils.showMessage(l.message);
      }, (PaginationData<ShapeMasterDetails> r) {
        shapeMasterDetails = (r.dataList as List<ShapeMasterDetails>?) ?? [];
      });
    } catch (e) {
      printWrapped(e.toString());
    }
    return shapeMasterDetails;
  }

  Future<List<CommodityMasterDetails>> fetchCommodityMasterFilters(BuildContext context,
      {bool isShowLoader = true, bool isForceFetch = false}) async {
    List<CommodityMasterDetails> commodityMasterDetails = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.filters: {ApiKey.dynamicObject: {}},
        ApiKey.pagination: {ApiKey.limit: 10, ApiKey.page: 1},
        ApiKey.search: "",
        ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc}
      };
      Either<ErrorResponse, PaginationData<CommodityMasterDetails>>? response =
          await AppRepository(context).commodityMasterFilters(body: body);
      response?.fold((l) {
        Utils.showMessage(l.message);
      }, (PaginationData<CommodityMasterDetails> r) {
        commodityMasterDetails = (r.dataList as List<CommodityMasterDetails>?) ?? [];
      });
    } catch (e) {
      printWrapped(e.toString());
    }
    return commodityMasterDetails;
  }
}

extension LoadingExtension on BuildContext {
  void setAppLoading(bool isLoading) {
    BlocProvider.of<AppBloc>(this).add(SetAppLoadingEvent(isLoading));
  }
}
