import 'package:kgk/kgk.dart';
import 'package:html/dom.dart' as dom;

class Utils {
  Utils._();

  /// Show common snack bar messages
  static Future<void> showMessage(String? message) async {
    if (message.isNullOrEmpty) return;

    try {
      /// Below 4 lines is used to hide toast message from home screen as we are releasing the build of the Auth Module
      /// and home screen is not yet completed and showing some error messages because of API issues.
      if (NavigatorKey.navigatorKey.currentContext == null) return;
      final context = NavigatorKey.navigatorKey.currentContext!;
      String routeName = ModalRoute.of(context)?.settings.name ?? '';
      if (routeName == AppRoutes.landingPage && BlocProvider.of<LandingBloc>(context).currentIndex == 0) return;

      await Flushbar(
        message: message,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        animationDuration: const Duration(milliseconds: 1300),
        backgroundColor: AppThemes().appColor.primary,
        margin: EdgeInsets.all(10.w),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ).show(NavigatorKey.navigatorKey.currentContext!);
    } catch (e) {
      printWrapped(e.toString());
    }
  }

  static void showCountryPickerModel({
    required BuildContext context,
    required CountryPickerStyle countryPickerStyle,
    required Function(Country) onSelect,
    bool showPhoneCode = false,
    List<String>? countryFilter,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: showPhoneCode,
      useRootNavigator: true,
      countryFilter: countryFilter,
      countryListTheme: CountryListThemeData(
        flagSize: 25.w,
        backgroundColor: countryPickerStyle.backgroundColor,
        bottomSheetHeight: (context.height * 0.8).h,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0.r),
          topRight: Radius.circular(10.0.r),
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

  /// Show common dialog box
  static void showDoubleActionDialog({
    String? title,
    String? content,
    String? cancelButtonText,
    String? okButtonText,
    VoidCallback? onOkPressed,
    VoidCallback? onCancelPressed,
  }) {
    showDialog(
      context: NavigatorKey.navigatorKey.currentContext!,
      builder: (context) {
        final style = AppTheme.of(context).showDoubleActionDialogStyle;
        return AlertDialog.adaptive(
          title: title != null
              ? SmartText(
                  title,
                  style: style.titleStyle,
                )
              : null,
          content: content != null
              ? SmartText(
                  content,
                  style: style.contentStyle,
                )
              : null,
          actions: [
            if (cancelButtonText != null)
              TextButton(
                  style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                  onPressed: () {
                    context.pop();
                    if (onCancelPressed != null) {
                      onCancelPressed();
                    }
                  },
                  child: SmartText(
                    cancelButtonText,
                    style: style.okButtonStyle,
                  )),
            if (okButtonText != null)
              TextButton(
                  style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                  onPressed: () {
                    context.pop();
                    if (onOkPressed != null) {
                      onOkPressed();
                    }
                  },
                  child: SmartText(
                    okButtonText,
                    style: style.okButtonStyle,
                  )),
          ],
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.only(bottom: 8.w, right: 16.w, left: 8.w, top: 0.w),
          contentPadding: EdgeInsets.only(bottom: 0.w, right: 20.w, left: 20.w, top: 16.w),
        );
      },
    );
  }

  static void showQrAuthLoadingDialog(BuildContext context) {
    final style = AppTheme.of(context).profilePageScreenStyle;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 70.h, // Set the specific height here
              width: context.width, // You can adjust the width as well
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: style.backgroundColor,
              ),
              child: Row(
                children: [const SmartCircularProgressIndicator(), SmartText(APPStrings.loggingIn.tr)],
              ),
            ),
          );
        });
  }

  static Future<T?> showSmartModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = true,
    double scrollControlDisabledMaxHeightRatio = AppConst.defaultScrollControlDisabledMaxHeightRatio,
    bool useRootNavigator = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      barrierLabel: barrierLabel,
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
          ),
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: sheetAnimationStyle,
    );
  }

  /// Check email validation
  static bool isValidEmail(String email) {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(regex);

    return regExp.hasMatch(email);
  }

  /// Check password validation
  static bool isValidPassword(String newPassword) {
    String regex = r'^[A-Za-z](?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$';
    RegExp regExp = RegExp(regex);
    return regExp.hasMatch(newPassword);
  }

  /// Parse HTML string to plain text
  static String parseHtmlString(String htmlString) {
    // Parse the HTML string
    dom.Document document = parse(htmlString);

    // Find the <a> tag with "Learn more" text and remove it
    document.querySelectorAll('a').forEach((element) {
      if (element.text.trim() == 'Learn more') {
        element.remove();
      }
    });

    final doc = parse(document.body?.innerHtml.trim());
    final String? parsedString = parse(doc.body?.text).documentElement?.text;

    return parsedString ?? "";
  }

  /// Calculates the total number of pages based on the total number of records and the limit per page.
  ///
  /// \param: totalRecords The total number of records. If null, it defaults to 0.
  /// \param: limit The number of records per page.
  /// \return: The total number of pages.
  static int calculateTotalPages(int? totalRecords, int limit) {
    totalRecords ??= 0;
    return (totalRecords % limit == 0) ? totalRecords ~/ limit : (totalRecords ~/ limit) + 1;
  }
}
