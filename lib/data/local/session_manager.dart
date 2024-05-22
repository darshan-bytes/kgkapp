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
  final String _locale = 'locale';

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

  /// Set locale after login-signup
  Future<void> setLocale(String locale) async {
    await _box.put(_locale, locale);
  }

  String? getLocale() {
    return _box.get(_locale);
  }

  /// Set theme data
  Future<void> setThemeData(String theme) async {
    await _box.put('themeData', theme);
  }

  String getThemeData() {
    return _box.get('themeData') ?? 'light';
  }

  /// Clear all data stored
  Future<void> clearSession() async {
    await _box.clear();
  }

  Future<void> closeBox() async {
    await _box.close();
  }

  bool getSystemTheme() {
    //TODO: need to implement
    return true;
  }
}
