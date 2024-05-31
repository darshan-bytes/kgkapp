import 'package:kgk/kgk.dart';

class Utils {
  Utils._();

  /// Show common snack bar messages
  static void showMessage(String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppThemes().appColor.primary,
      margin: const EdgeInsets.all(10),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ).show(NavigatorKey.navigatorKey.currentContext!);
  }

  static void showCountryPickerModel(
      {required BuildContext context, required CountryPickerStyle countryPickerStyle, required Function(Country) onSelect}) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      useSafeArea: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: countryPickerStyle.backgroundColor,
        bottomSheetHeight: context.height * 0.8,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        inputDecoration: InputDecoration(
          labelText: APPStrings.search.tr,
          hintText: APPStrings.startTypingToSearch.tr,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: countryPickerStyle.searchBorderColor,
            ),
          ),
        ),
      ),
      onSelect: onSelect,
    );
  }
}
