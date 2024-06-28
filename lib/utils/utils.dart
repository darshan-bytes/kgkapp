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

  static void showCountryPickerModel({
    required BuildContext context,
    required CountryPickerStyle countryPickerStyle,
    required Function(Country) onSelect,
    bool showPhoneCode = false,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: showPhoneCode,
      useRootNavigator: true,
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
}
