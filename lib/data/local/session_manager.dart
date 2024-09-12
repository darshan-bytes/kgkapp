import 'package:kgk/kgk.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  late Box _box;
  final String _authTokenBoxName = 'auth_token';
  final String _userId = 'userId';
  final String _userData = 'userData';
  final String _locale = 'locale';
  final String _currency = 'currency';
  final String _languageLabels = 'languageLabels';
  final String _selectedCurrency = 'selectedCurrency';
  final String _selectedCurrencySymbol = 'selectedCurrencySymbol';
  final String _bagData = 'bagData';

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

  Future<void> setUserData(UserIdDetails userIdDetails) async {
    await _box.put(_userData, jsonEncode(userIdDetails.toJson()));
  }

  UserIdDetails? getUserData() {
    String? userData = _box.get(_userData);
    return userData.isNotNullNorEmpty ? UserIdDetails.fromJson(jsonDecode(userData!)) : null;
  }

  /// Set locale after login-signup
  Future<void> setLocale(String locale) async {
    await _box.put(_locale, locale);
  }

  String? getLocale() {
    return _box.get(_locale);
  }

  /// Set selected currency
  Future<void> setSelectedCurrencySymbol(String symbol) async {
    await _box.put(_selectedCurrencySymbol, symbol);
  }

  String? getSelectedCurrencySymbol() {
    return _box.get(_selectedCurrencySymbol);
  }

  /// Set selected currency
  Future<void> setSelectedCurrency(String currency) async {
    await _box.put(_selectedCurrency, currency);
  }

  /// Get selected currency
  String? getSelectedCurrency() {
    return _box.get(_selectedCurrency);
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

  /// Set theme data
  Future<void> setThemeData(String theme) async {
    await _box.put('themeData', theme);
  }

  String getThemeData() {
    return _box.get('themeData') ?? 'light';
  }

  /// Set bag id for cart
  Future<void> storeBagData(MyBagDataModel badgeId) async {
    await _box.put(_bagData, jsonEncode(badgeId.toJson()));
  }

  MyBagDataModel? getBagData() {
    String? bagData = _box.get(_bagData);
    return bagData.isNotNullNorEmpty ? MyBagDataModel.fromJson(jsonDecode(bagData!)) : null;
  }

  Future<void> clearBagData() async {
    await _box.delete(_bagData);
  }

  /// Clear all data stored except _locale
  Future<void> clearSession() async {
    String? locale = getLocale();
    List<CurrencyListModel>? currencyList = getCurrencyList();
    await _box.clear();

    if (locale != null) {
      await setLocale(locale);
    }
    if (currencyList.isNotNullNorEmpty) {
      await setCurrencyList(currencyList);
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

  Future<void> closeBox() async {
    await _box.close();
  }

  bool getSystemTheme() {
    //TODO: need to implement
    return true;
  }
}
