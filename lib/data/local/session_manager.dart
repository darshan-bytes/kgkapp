import 'package:kgk/kgk.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class StorageManager {
  static final StorageManager instance = StorageManager._internal();

  factory StorageManager() {
    return instance;
  }

  StorageManager._internal();

  late Box _box;
  final String _authTokenBoxName = 'auth_token';
  final String _userId = 'userId';
  final String _userData = 'userData';
  final String _userResponse = 'userResponse';
  final String _locale = 'locale';
  final String _currency = 'currency';
  final String _languageLabels = 'languageLabels';
  final String _selectedCurrency = 'selectedCurrency';
  final String _selectedCurrencySymbol = 'selectedCurrencySymbol';
  final String _bagData = 'bagData';
  final String _isSkipLogin = 'isSkipLogin';
  final String _bagId = 'bagId';
  final String _selectedCsc = 'selectedCsc';
  final String _customerOrganizationId = 'customerOrganizationId';
  final String _sortingData = 'sortingData';
  final String _recentlyViewedJewellery = 'recentlyViewedJewellery';
  final String _recentlyViewedDiamonds = 'recentlyViewedDiamonds';
  final String _recentlyViewedGemstones = 'recentlyViewedGemstones';
  final String _placeHolderImage = 'placeHolderImage';
  final String _frontendLinks = 'frontendLinks';

  Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _box = await Hive.openBox(_authTokenBoxName);
  }

  /// Set auth token after login-signup
  Future<void> setAuthToken(String token) async {
    await _box.put(_authTokenBoxName, token);
  }

  String? getAuthToken() {
    return _box.get(_authTokenBoxName);
  }

  /// Set userId after login-signup
  Future<void> setUserId(String userId) async {
    await _box.put(_userId, userId);
  }

  String? getUserId() {
    return _box.get(_userId);
  }

  /// Set user data after login-signup

  Future<void> setUserResponse(UserResponse userResponse) async {
    await _box.put(_userResponse, jsonEncode(userResponse.toJson()));
  }

  UserResponse? getUserResponse() {
    String? userResponse = _box.get(_userResponse);
    return userResponse.isNotNullNorEmpty ? UserResponse.fromJson(jsonDecode(userResponse!)) : null;
  }

  Future<void> setUserData(UserIdDetails userIdDetails) async {
    await _box.put(_userData, jsonEncode(userIdDetails.toJson()));
  }

  UserIdDetails? getUserData() {
    String? userData = _box.get(_userData);
    return userData.isNotNullNorEmpty ? UserIdDetails.fromJson(jsonDecode(userData!)) : null;
  }

  Future<void> setCustomerOrgId(String customerOrganizationId) async {
    await _box.put(_customerOrganizationId, customerOrganizationId);
  }

  String? getCustomerOrgId() {
    return _box.get(_customerOrganizationId);
  }

  /// Set locale after login-signup
  Future<void> setLocale(LanguageDatum locale) async {
    await _box.put(_locale, jsonEncode(locale.toJson()));
  }

  LanguageDatum? getLocale() {
    String? locale = _box.get(_locale);
    if (locale.isNotNullNorEmpty) {
      return LanguageDatum.fromJson(jsonDecode(locale!));
    } else {
      return null;
    }
  }

  /// Set selected currency
  Future<void> setSelectedCurrencySymbol(String symbol) async {
    await _box.put(_selectedCurrencySymbol, symbol);
  }

  String? getSelectedCurrencySymbol() {
    return _box.get(_selectedCurrencySymbol);
  }

  /// Set selected currency
  Future<void> setSelectedCurrency(CurrencyListModel currency) async {
    await _box.put(_selectedCurrency, jsonEncode(currency.toJson()));
  }

  /// Get selected currency
  CurrencyListModel? getSelectedCurrency() {
    String? selectedCurrency = _box.get(_selectedCurrency);
    return selectedCurrency.isNotNullNorEmpty ? CurrencyListModel.fromJson(jsonDecode(_box.get(_selectedCurrency))) : null;
  }

  /// Set currency list
  Future<void> setCurrencyList(List<CurrencyListModel> currency) async {
    await _box.put(_currency, currency.map((e) => e.toJson()).toList());
  }

  List<CurrencyListModel> getCurrencyList() {
    List<CurrencyListModel> currencyList = [];
    _box.get(_currency)?.forEach((element) {
      currencyList.add(CurrencyListModel.fromJson(element));
    });
    return currencyList;
  }

  /// Store sorting data in local storage
  Future<void> setSortingData(Map<String, List<SortOptions>> data) async {
    final serializedData = data.map(
      (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
    );
    await _box.put(_sortingData, serializedData);
  }

  /// Fetch sorting list for a specific type
  Future<List<SortOptions>> getSortingList(String type) async {
    final storedData = _box.get(_sortingData, defaultValue: {});
    if (storedData is Map<String, dynamic> && storedData.containsKey(type)) {
      return (storedData[type] as List).map((e) => SortOptions.fromJson(e)).toList();
    }
    return [];
  }

  /// Set theme data
  Future<void> setThemeData(String theme) async {
    await _box.put('themeData', theme);
  }

  String getThemeData() {
    return _box.get('themeData') ?? 'light';
  }

  /// Set bag id for cart
  Future<void> setBagId(String? bagId) async {
    await _box.put(_bagId, bagId);
  }

  String? getBagId() {
    return _box.get(_bagId);
  }

  /// Set bag id for cart
  Future<void> storeBagData(MyBagDataModel badgeId) async {
    await _box.put(_bagData, jsonEncode(badgeId.toJson()));
  }

  MyBagDataModel? getBagData() {
    String? bagData = _box.get(_bagData);
    return bagData.isNotNullNorEmpty ? MyBagDataModel.fromJson(jsonDecode(bagData!)) : null;
  }

  /// Set selected csc
  Future<void> setSelectedCsc(CscDetails cscDetails) async {
    await _box.put(_selectedCsc, jsonEncode(cscDetails.toJson()));
  }

  CscDetails? getSelectedCsc() {
    String? selectedCsc = _box.get(_selectedCsc);
    return selectedCsc.isNotNullNorEmpty ? CscDetails.fromJson(jsonDecode(selectedCsc!)) : null;
  }

  Future<void> clearBagData() async {
    await _box.delete(_bagData);
  }

  Future<void> clearSortingData() async {
    await _box.delete(_sortingData);
  }

  /// Clear all data stored except _locale
  Future<void> clearSession() async {
    LanguageDatum? locale = getLocale();
    List<CurrencyListModel>? currencyList = getCurrencyList();
    bool isSkipLogin = getIsSkipLogin();
    String guestBagId = getBagId() ?? '';
    MyBagDataModel? guestBagData = getBagData();
    CurrencyListModel? selectedCurrency = getSelectedCurrency();
    String? selectedCurrencySymbol = getSelectedCurrencySymbol();
    final storedData = _box.get(_sortingData, defaultValue: {});
    await _box.clear();
    if (storedData != null) {
      await _box.put(_sortingData, storedData);
    }
    if (locale != null) {
      await setLocale(locale);
    }
    if (currencyList.isNotNullNorEmpty) {
      await setCurrencyList(currencyList);
    }
    if (selectedCurrency != null && selectedCurrencySymbol.isNotNullNorEmpty) {
      await setSelectedCurrency(selectedCurrency);
      await setSelectedCurrencySymbol(selectedCurrencySymbol!);
    }
    if (getNavigatorKeyContext.mounted) {
      BlocProvider.of<LandingBloc>(getNavigatorKeyContext).add(const LandingLogoutEvent());
      BlocProvider.of<LandingBloc>(getNavigatorKeyContext)
          .add(LandingChangeTabEvent(LandingBloc.homeIndex, context: getNavigatorKeyContext));
    }
    if (isSkipLogin) {
      await setIsSkipLogin(isSkipLogin);
      if (guestBagId.isNotEmpty) {
        await setBagId(guestBagId);
      }
      if (guestBagData != null) {
        await storeBagData(guestBagData);
      }
    }
  }

  // setLanguageLabels
  Future<void> setLanguageLabels(Map<String, dynamic> languageLabels) async {
    await _box.put(_languageLabels, jsonEncode(languageLabels));
  }

  // getLanguageLabels
  Map<String, dynamic> getLanguageLabels() {
    return jsonDecode(_box.get(_languageLabels) ?? '{}');
  }

  // setIsSkipLogin
  Future<void> setIsSkipLogin(bool isSkipLogin) async {
    await _box.put(_isSkipLogin, isSkipLogin);
  }

  // getIsSkipLogin
  bool getIsSkipLogin() {
    return _box.get(_isSkipLogin) ?? false;
  }

  Future<List<String>> setRecentlyViewedJewellery(String productId) async {
    List<String> list = _box.get(_recentlyViewedJewellery) ?? [];
    if (list.contains(productId)) {
      list.remove(productId);
    }
    list.insert(0, productId);
    await _box.put(_recentlyViewedJewellery, list);
    return list;
  }

  Future<List<String>> setRecentlyViewedDiamonds(String productId) async {
    List<String> list = _box.get(_recentlyViewedDiamonds) ?? [];
    if (list.contains(productId)) {
      list.remove(productId);
    }
    list.insert(0, productId);

    await _box.put(_recentlyViewedDiamonds, list);
    return list;
  }

  Future<List<String>> setRecentlyViewedGemstones(String productId) async {
    List<String> list = _box.get(_recentlyViewedGemstones) ?? [];
    if (list.contains(productId)) {
      list.remove(productId);
    }
    list.insert(0, productId);

    await _box.put(_recentlyViewedGemstones, list);
    return list;
  }

  String getRecentlyViewedJewellery() {
    // convert to list to String with comma separated
    List<String> list = _box.get(_recentlyViewedJewellery) ?? [];
    return list.join(',');
  }

  String getRecentlyViewedDiamond() {
    // convert to list to String with comma separated
    List<String> list = _box.get(_recentlyViewedDiamonds) ?? [];
    return list.join(',');
  }

  String getRecentlyViewedGemstone() {
    // convert to list to String with comma separated
    List<String> list = _box.get(_recentlyViewedGemstones) ?? [];
    return list.join(',');
  }

  /// Set placeholder image
  Future<void> setPlaceHolderImage(String placeholderImage) async {
    String downloadedImage = await Utils.downloadAndSaveImage(placeholderImage);
    await _box.put(_placeHolderImage, downloadedImage);
  }

  /// get placeholder image
  String getPlaceHolderImage() {
    return _box.get(_placeHolderImage) ?? '';
  }

  Future<void> closeBox() async {
    await _box.close();
  }

  bool getSystemTheme() {
    //TODO: need to implement
    return true;
  }
}
