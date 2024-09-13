import 'package:kgk/kgk.dart';

/// It loads the JSON file for the current locale and provides a method to translate a key into the
/// localized string
class AppLocalizations {
  late Locale? locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedStrings;

  /// > Load the language JSON file from the "lang" folder and return true if successful
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder

    // Map<String, dynamic> languageLabels = StorageManager().getLanguageLabels();
    //
    // if (languageLabels.isNotEmpty) {
    //   _localizedStrings = languageLabels.map((key, value) => MapEntry(key, value.toString()));
    //   return true;
    // }

    String jsonString = await rootBundle.loadString('assets/locales/${locale!.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  /// If the localized strings map is not null, return the value of the key in the map
  ///
  /// Args:
  ///   key (String): The key of the string we want to translate.
  ///
  /// Returns:
  ///   The value of the key in the map.
  String? translate(String key) {
    return _localizedStrings![key];
  }

  /// Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<void> changeLocale() async {
    locale = Locale(StorageManager().getLocale() ?? APPStrings.languageEn);
    await load();
  }
}

/// LocalizationsDelegate is a factory for a set of localized resources
/// In this case, the localized strings will be gotten in an AppLocalizations object
/// It's a delegate that loads
/// AppLocalizations, and it's used by the Flutter framework to load the
/// localizations
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  /// This delegate instance will never change (it doesn't even have fields!)
  /// It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    /// Include all of your supported language codes here
    return [
      APPStrings.languageEn,
      APPStrings.languageFr,
      APPStrings.languageHi,
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    /// AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
