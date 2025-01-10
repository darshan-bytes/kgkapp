import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  Utils._();

  static ToastificationItem? _toast;

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
      // Dismisses the currently displayed toast message if it exists.
      if (_toast != null) {
        toastification.dismiss(_toast!);
      }

// Displays a new toast message with the specified properties.
      _toast = toastification.show(
        title: Text(message ?? '', style: TextStyle(color: AppThemes().appColor.white)),
        autoCloseDuration: const Duration(seconds: 3),
        backgroundColor: AppThemes().appColor.primary,
        borderRadius: BorderRadius.circular(10.r),
        margin: EdgeInsets.all(10.w),
        closeButtonShowType: CloseButtonShowType.none,
        showIcon: false,
        showProgressBar: false,
        alignment: Alignment.topCenter,
        callbacks: ToastificationCallbacks(
          onDismissed: (ToastificationItem item) {
            _toast = null;
          },
        ),
      );
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

  static Future<void> showPermissionDeniedDialog(
      {required BuildContext context,
      required void Function(BuildContext context) onOkPressed,
      required void Function(BuildContext context) onCancelPressed}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: SmartText(APPStrings.permissionDenied.tr),
          content: SmartText(APPStrings.pleaseEnableLocation.tr),
          actions: [
            SmartText(APPStrings.ok.tr, optionalPadding: EdgeInsets.all(10.w), onTap: () {
              onOkPressed(context);
            }),
            SmartText(
              APPStrings.cancel.tr,
              optionalPadding: EdgeInsets.all(10.w),
              onTap: () {
                onCancelPressed(context);
              },
            )
          ],
        ),
      ),
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
    String regex = r'^[A-Za-z](?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&.])[A-Za-z\d@$!%*?&.]{7,}$';
    RegExp regExp = RegExp(regex);
    return regExp.hasMatch(newPassword);
  }

  /// Validate ZipCode
  static bool isValidZipCode(String zipCode) {
    String regex = r'^[0-9]{5}(?:-[0-9]{4})?$';
    RegExp regExp = RegExp(regex);
    return regExp.hasMatch(zipCode);
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

  static String getGoogleMapUrl({required double latitude, required double longitude}) {
    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
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

  static Future<bool> launchUrlFromString(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
      return true;
    } else {
      return false;
    }
  }

  static PermissionData? getPermissionByModuleName({required ModuleKey moduleName}) {
    final userResponse = StorageManager().getUserResponse();
    if (userResponse?.userPermissions?.permissions != null) {
      Map<String, dynamic>? moduleData = userResponse?.userPermissions?.permissions?.toJson()[moduleName.value];
      if (moduleData is Map<String, dynamic>) {
        return PermissionData.fromJson(moduleData);
      }
    }
    return null;
  }

  static Future<String> downloadAndSaveImage(String imageUrl) async {
    try {
      // Get the device's local directory
      final directory = await getApplicationDocumentsDirectory();

      // Create a unique file name (using the last part of the URL)
      final fileName = imageUrl.split('/').last;
      final filePath = '${directory.path}/$fileName';

      // Send a GET request to the image URL
      final response = await http.get(Uri.parse(imageUrl));

      // Check if the request was successful (HTTP 200)
      if (response.statusCode == 200) {
        // Save the image to the file system
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return filePath; // Return the local file path
      } else {
        throw Exception("Failed to download image");
      }
    } catch (e) {
      debugPrint('Error downloading image: $e');
      return '';
    }
  }

  /// Returns the appropriate [ScreenIdentifier] based on the given [Commodity].
  /// This method maps each [Commodity] to a specific [ScreenIdentifier] used for navigation.
  static ScreenIdentifier getScreenIdentifierFromCommodity(Commodity commodity) {
    switch (commodity) {
      case Commodity.jewellery:
        return ScreenIdentifier.productForRing;
      case Commodity.diamond:
        return ScreenIdentifier.productForDiamonds;
      case Commodity.gemstone:
        return ScreenIdentifier.productForGemstones;
      default:
        return ScreenIdentifier.productForRing;
    }
  }

  static handleAuthSuccessResponse(BuildContext context, UserResponse r) async {
    await StorageManager().setAuthToken(r.accessToken ?? '');
    await StorageManager().setUserId(r.userId ?? '');
    await StorageManager().setUserResponse(r);
    if (r.customerOrganizationId.isNotNullNorEmpty) {
      await StorageManager().setCustomerOrgId(r.customerOrganizationId!.toString());
    }
    if (r.userIdDetails != null) {
      await StorageManager().setUserData(r.userIdDetails!);
    }
    if (r.bagId != null) {
      await StorageManager().setBagId(r.bagId!);
    }
    if (r.userIdDetails?.userTypeEnum != null) {
      await StorageManager().setIsSkipLogin(false);
      BlocProvider.of<AppBloc>(context).add(SetUserTypeEvent(r.userIdDetails!.userTypeEnum));
      await mergeCart(context);
      context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
    }
  }

  static Future<void> mergeCart(BuildContext context) async {
    MyBagDataModel? myBagDataModel = StorageManager().getBagData();
    if (myBagDataModel != null) {
      Map<String, dynamic> body = {
        ApiKey.id: myBagDataModel.sId ?? '',
      };
      await AppRepository(context).mergeBag(body: body).then((value) {
        value?.fold((l) {
          Utils.showMessage(l.message);
        }, (r) async {
          if (r.responseData != null) {
            await StorageManager().clearBagData();
          }
        });
      });
    }
  }
}
