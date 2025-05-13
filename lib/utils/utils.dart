import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  Utils._();

  static ToastificationItem? _toast;

  /// Show common snack bar messages
  static Future<void> showMessage(String? message, {Duration? autoCloseDuration}) async {
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
        description: Text(message ?? '', style: TextStyle(color: AppThemes().appColor.white)),
        autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
        backgroundColor: AppThemes().appColor.primary,
        borderRadius: BorderRadius.circular(10.r),
        margin: EdgeInsetsDirectional.all(10.w),
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
        showIcon: false,
        showProgressBar: false,
        alignment: AlignmentDirectional.topCenter,
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        inputDecoration: InputDecoration(
          labelText: APPStrings.search.tr,
          hintText: APPStrings.startTypingToSearch.tr,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderSide: BorderSide(color: countryPickerStyle.searchBorderColor)),
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
          title: title != null ? SmartText(title, style: style.titleStyle) : null,
          content: content != null ? SmartText(content, style: style.contentStyle) : null,
          actions: [
            if (cancelButtonText != null)
              TextButton(
                style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsetsDirectional.zero)),
                onPressed: () {
                  context.pop();
                  if (onCancelPressed != null) {
                    onCancelPressed();
                  }
                },
                child: SmartText(cancelButtonText, style: style.okButtonStyle),
              ),
            if (okButtonText != null)
              TextButton(
                style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsetsDirectional.zero)),
                onPressed: () {
                  context.pop();
                  if (onOkPressed != null) {
                    onOkPressed();
                  }
                },
                child: SmartText(okButtonText, style: style.okButtonStyle),
              ),
          ],
          buttonPadding: EdgeInsetsDirectional.zero,
          actionsPadding: EdgeInsetsDirectional.only(bottom: 8.w, end: 16.w, start: 8.w, top: 0.w),
          contentPadding: EdgeInsetsDirectional.only(bottom: 0.w, end: 20.w, start: 20.w, top: 16.w),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.r), color: style.backgroundColor),
            child: Row(children: [const SmartCircularProgressIndicator(), SmartText(APPStrings.loggingIn.tr)]),
          ),
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
      shape:
          shape ??
          RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(6.r), topEnd: Radius.circular(6.r))),
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

  static Future<void> showPermissionDeniedDialog({
    required BuildContext context,
    required void Function(BuildContext context) onOkPressed,
    required void Function(BuildContext context) onCancelPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: SmartText(APPStrings.permissionDenied.tr),
              content: SmartText(APPStrings.pleaseEnableLocation.tr),
              actions: [
                SmartText(
                  APPStrings.ok.tr,
                  optionalPadding: EdgeInsetsDirectional.all(10.w),
                  onTap: () {
                    onOkPressed(context);
                  },
                ),
                SmartText(
                  APPStrings.cancel.tr,
                  optionalPadding: EdgeInsetsDirectional.all(10.w),
                  onTap: () {
                    onCancelPressed(context);
                  },
                ),
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
    String regex = r'^[0-9]{6}(?:-[0-9]{6})?$';
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
      case Commodity.designLibrary:
        return ScreenIdentifier.productForLibraryDesign;
      case Commodity.skuLibrary:
        return ScreenIdentifier.productForLibrarySKU;
      case Commodity.styleLibrary:
        return ScreenIdentifier.productForLibraryStyle;
      case Commodity.cadLibrary:
        return ScreenIdentifier.productForLibraryCAD;
      default:
        return ScreenIdentifier.productForRing;
    }
  }

  static handleAuthSuccessResponse(BuildContext context, UserResponse r, bool isFromLoginRequired) async {
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
      await AppCrashlytics.instance.setUserId(r.userIdDetails?.userAccountId ?? "----");
      await StorageManager.instance.setIsSkipLogin(false);

      BlocProvider.of<AppBloc>(context).add(SetUserTypeEvent(r.userIdDetails!.userTypeEnum));
      await mergeCart(context);
      BlocProvider.of<LandingBloc>(context).add(LandingLogoutEvent());

      if (!isFromLoginRequired) {
        context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
      } else {
        context.pop();
      }
    }
  }

  static Future<void> mergeCart(BuildContext context, {bool isRetry = false}) async {
    MyBagDataModel? myBagDataModel = StorageManager().getBagData();
    if (myBagDataModel != null) {
      Map<String, dynamic> body = {ApiKey.id: myBagDataModel.sId ?? ''};
      await AppRepository(context).mergeBag(body: body).then((value) async {
        await value?.fold(
          (l) async {
            Map<String, dynamic> body = {ApiKey.id: myBagDataModel.sId ?? '', ApiKey.suid: ""};

            await AppRepository(context).deleteBag(body: body);
            await StorageManager().clearBagData();
            if (!isRetry) {
              await mergeCart(context, isRetry: true);
            }
          },
          (r) async {
            if (r.responseData != null) {
              await StorageManager().clearBagData();
            }
          },
        );
      });
    }
  }

  /// Pre-caches a list of images by downloading them and storing them in the cache.
  static Future<void> precacheImageList(List<String> imageUrlList) async {
    await Future.forEach(imageUrlList, (String imageUrl) async {
      try {
        await DefaultCacheManager().downloadFile(imageUrl, force: true);
      } catch (e) {
        printWrapped(e.toString());
      }
    });
  }

  static Future<void> showLoginRequiredDialog(BuildContext context, {VoidCallback? onDenied, VoidCallback? onApproved}) async {
    await Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder:
          (context) => ConfirmationDialog(
            title: APPStrings.loginRequired.tr,
            message: APPStrings.loginToUseThisFeature.tr,
            onApproved: () async {
              if (onApproved != null) {
                await context.pushNamed(AppRoutes.signInPage, arguments: {RoutesData.isFromLoginRequired: true});
                if (!StorageManager().getIsSkipLogin()) {
                  onApproved.call();
                  context.pop();
                }
              }
            },
            onDenied: () {
              context.pop();
              onDenied?.call();
            },
            onApprovedText: APPStrings.login.tr,
            onDeniedText: APPStrings.cancel.tr,
          ),
    );
  }

  static String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    List<String> parts = [];

    if (days > 0) {
      parts.add("$days${"d"}");
    }
    if (hours > 0) {
      parts.add("$hours${"hrs".tr}");
    }
    if (minutes > 0) {
      parts.add("$minutes${"mins".tr}");
    }
    if (seconds > 0 || parts.isEmpty) {
      parts.add("$seconds${"secs".tr}");
    }
    return parts.join(" : ");
  }

  static ProductDetailsModel convertJewelleryDataModelToProductDetailsModel({required JewelleryDataModel jewellery}) {
    return ProductDetailsModel(
      suid: jewellery.suid ?? "",
      imageUrl:
          jewellery.multipleFinishedViewImage.isNotNullNorEmpty
              ? jewellery.multipleFinishedViewImage[0].imageUrl
              : jewellery.kgkCoutureImage,
      name: jewellery.productDescription ?? "",
      originalPrice: jewellery.finalPrice?.toString().setCurrency,
      finalPrice: jewellery.discountPrice?.toString().setCurrency,
      discountPercentageString: jewellery.discountEXT,
      productId: jewellery.suid ?? "",
      commodity: Commodity.jewellery,
      isFavourite: jewellery.isFavorite,
      wishlistId: jewellery.wishlistID,
      productSku: jewellery.contractNoSkuNo,
      title: jewellery.contractNoSkuNo ?? '',
      subTitle: jewellery.productDescription ?? '',
      kgkCollectionName: jewellery.kgkCollection ?? "\n",
      businessCategoryName: jewellery.businessCategoryName ?? "\n",
      cts: jewellery.crtEXT,
      gms: jewellery.gms,
      brandName: jewellery.brandName,
      isAddedToCart: jewellery.isAddedToCart,
      colorsCode: [jewellery.metalColor1HexCode ?? "", jewellery.metalColor2HexCode ?? "", jewellery.metalColor3HexCode ?? ""],
      reviewCount: jewellery.reviewCount,
      rating: jewellery.rating?.toDouble(),
      components: jewellery.components,
    );
  }

  static ProductDetailsModel convertDiamondDataModelToProductDetailsModel({required DiamondDataModel diamond}) {
    bool isDiscounted = diamond.discountPercentage != null && diamond.discountPercentage! > 0;
    return ProductDetailsModel(
      suid: diamond.suid,
      productId: diamond.suid,
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      originalPrice: diamond.finalPrice?.toString().setCurrency,
      finalPrice: diamond.discountPrice?.toString().setCurrency,
      lotCode: diamond.lotCode,
      productSku: diamond.lotCode,
      shape: diamond.shape,
      fluorescence: diamond.fluorescence,
      labs: diamond.labs,
      lsp: diamond.lsp,
      color: diamond.color,
      clarity: diamond.clarity,
      cut: diamond.cut,
      certificateFile: diamond.certificateFile,
      openDnaUrl: diamond.openDnaUrl,
      commodity: Commodity.diamond,
      company: diamond.id,
      isFavourite: diamond.isFavorite,
      wishlistId: diamond.wishlistID,
      title: diamond.lotCode ?? "",
      subTitle: diamond.rmDescription ?? "",
      isForAuction: diamond.isAuction,
      isAddedToCart: diamond.isAddedToCart,
      rating: diamond.rating,
      reviewCount: diamond.reviewCount,
      discountPercentageString: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamond.discountPercentage]) : null,
      stoneElements: diamond.components,
      auctionId: diamond.auctionId,
      video: diamond.video,
      location: diamond.location,
    );
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  static ProductDetailsModel convertGemstoneDatumToProductDetailsModel({required GemstoneDatum gemstone}) {
    return ProductDetailsModel(
      suid: gemstone.suid,
      productId: gemstone.suid,
      imageUrl: gemstone.image.isNotNullNorEmpty ? gemstone.image.first.url : null,
      productSku: gemstone.lotCode,
      name: gemstone.rmDescription ?? "",
      ctsOrGms: gemstone.ctsOrGms,
      rappaportPrice: gemstone.rappaportPrice,
      priceCts: gemstone.priceCts,
      originalPrice: gemstone.finalPrice?.toString().setCurrency,
      finalPrice: gemstone.discountPrice?.toString().setCurrency,
      lotCode: gemstone.lotCode,
      shape: gemstone.shape,
      fluorescence: gemstone.fluorescence,
      labs: gemstone.labs,
      lsp: gemstone.lsp?.toString(),
      color: gemstone.color,
      clarity: gemstone.clarity,
      cut: gemstone.cut,
      certificateFile: gemstone.certificateFile,
      openDnaUrl: gemstone.openDnaUrl,
      commodity: Commodity.gemstone,
      isFavourite: gemstone.isFavorite,
      wishlistId: gemstone.wishlistID,
      isForAuction: false,
      title: gemstone.lotCode ?? "",
      subTitle: gemstone.rmDescription ?? "",
      isAddedToCart: gemstone.isAddedToCart,
      rating: gemstone.rating,
      reviewCount: gemstone.reviewCount,
      discountPercentageString:
          (gemstone.discountPercentage != null && gemstone.discountPercentage! > 0)
              ? APPStrings.percentageOffInterpolating.tr.interpolate([gemstone.discountPercentage])
              : null,
      stoneElements: gemstone.components,
      productQuality: CartProductQuality(name: gemstone.quality),
      location: gemstone.location,
    );
  }

  /// Make getter for is rtl
  static bool get isRtl => StorageManager.instance.getLocale()?.mobileSymbol == 'ar';

  /// This is used to get category display name in category tabs
  static String getCategoryDisplayName(String? categoryName) {
    switch (categoryName) {
      case 'Natural \nDiamonds':
        return APPStrings.naturalDiamond.tr;
      case 'Lab-grown \nDiamonds':
        return APPStrings.labCreatedDiamonds.tr;
      case 'Gemstone':
        return APPStrings.gemstone.tr;
      case 'Jewellery':
        return APPStrings.jewellery.tr;
      case 'Do It \nYourself':
        return APPStrings.doItYourself.tr;
      case 'About Us':
        return APPStrings.aboutUs.tr;
      case 'Education':
        return APPStrings.education.tr;
      case 'Orion':
        return APPStrings.orion.tr;
      case 'PDD':
        return APPStrings.pdd.tr;
      case 'Diamond':
        return APPStrings.diamond.tr;
      case 'Libraries':
        return APPStrings.libraries.tr;
      case 'Digital \nCatalogue':
        return APPStrings.digitalCatalogue.tr;
      case 'Exhibition':
        return APPStrings.exhibition.tr;
      case 'Diamonds':
        return APPStrings.diamonds.tr;
      case 'Lab created diamonds':
        return APPStrings.labCreatedDiamonds.tr;
      case 'Metals':
        return APPStrings.metals.tr;
      case 'Ring sizer':
        return APPStrings.ringSizer.tr;
      case 'Monitoring':
        return APPStrings.monitoring.tr;
      case 'Styles Listing':
        return APPStrings.styleLibrary.tr;
      case 'Design Listing':
        return APPStrings.designLibrary.tr;
      case 'Project Listing':
        return APPStrings.projectListing.tr;
      case 'Presentation Listing':
        return APPStrings.presentationListing.tr;
      case 'Concept Listing':
        return APPStrings.conceptListing.tr;
      case 'Collection':
        return APPStrings.collection.tr;
      case 'Landing':
        return APPStrings.landingListing.tr;
      case 'CAD Library':
        return APPStrings.cadLibrary.tr;
      case 'Style Library':
        return APPStrings.styleLibrary.tr;
      case 'Design Library':
        return APPStrings.designLibrary.tr;
      case 'SKU Library':
        return APPStrings.skuLibrary.tr;
      default:
        return categoryName ?? "Unknown";
    }
  }

  /// Converts a country code to its corresponding emoji flag.
  /// The country code should be a two-letter ISO 3166-1 alpha-2 code.
  /// Each letter is converted to a regional indicator symbol.
  /// Example:
  /// ```dart
  /// String emoji = countryCodeToEmoji("US"); // 🇺🇸
  /// ```
  static String countryCodeToEmoji(String countryCode) {
    if (countryCode.length != 2) {
      return countryCode;
    }
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static void handleContactAction(BuildContext context, String value, String url) async {
    if (url.startsWith("tel:")) {
      await Utils.launchUrlFromString("tel:$value");
    } else if (url.contains("find-a-store")) {
      context.pushNamed(AppRoutes.findStorePage);
    } else if (url.startsWith("mailto:")) {
      await Utils.launchUrlFromString(url);
    }
  }

  static Future showQrCodeDialog({required BuildContext context, required String data}) {
    final QRCodeDialogStyle style = AppTheme.of(context).qrCodeDialogStyle;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.all(24.w),
                  decoration: BoxDecoration(
                    color: style.whiteColor,
                    boxShadow: [BoxShadow(color: style.shadowColor, blurRadius: 15.0, spreadRadius: 5.0)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(border: Border.all(color: style.borderColor), borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(Icons.qr_code_2_outlined, size: 42.w, color: style.primaryColor),
                      ),
                      SizedBox(height: 16.h),
                      SmartText(APPStrings.scanThisQRCode.tr, style: style.titleStyle),
                      SizedBox(height: 8.h),
                      SmartText(APPStrings.scanThisQRCodeDetails.tr, style: style.subTitleStyle, textAlign: TextAlign.center),
                      SizedBox(height: 20.h),
                      QrImageView(data: data, version: QrVersions.auto, size: 245.w, backgroundColor: style.whiteColor),
                    ],
                  ),
                ),
                PositionedDirectional(
                  end: 20.w,
                  top: 20.h,
                  child: SmartImage(
                    path: AppImages.icCross,
                    height: 24.w,
                    width: 24.w,
                    color: style.primaryColor,
                    onTap: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Share link
  static Future<void> onTapShareLink({required BuildContext context, required String link, String? title, String? imageUrl}) async {
    context.pop();
    await SharePlus.instance.share(
      ShareParams(uri: Uri.tryParse(link), title: title, previewThumbnail: imageUrl.isNotNullNorEmpty ? XFile(imageUrl!) : null),
    );
  }

  static Future<List<String>> listSvgAssetsInImagesDirS() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    return manifestMap.keys.where((String key) => key.startsWith('assets/images/') && key.endsWith('.svg')).toList();
  }

  static Future<void> replaceAllSvgColorsS(Color newColor) async {
    final svgAssetPaths = await listSvgAssetsInImagesDirS();
    debugPrint("svgFiles::  ${newColor.toHex()}");

    final String oldColorHex = AppColor.kgkTheme().primary.toHex();
    final String newColorHex = newColor.toHex();

    final Directory outputDir = await getApplicationDocumentsDirectory();
    AppBloc.outputDirPath = "${outputDir.path}/modified_svgs";

    final Directory modifiedSvgsDir = Directory('${outputDir.path}/modified_svgs');
    if (!await modifiedSvgsDir.exists()) {
      await modifiedSvgsDir.create(recursive: true);
    }

    await Future.forEach(svgAssetPaths, (String assetPath) async {
      final String svgContent = await rootBundle.loadString(assetPath);
      final String updatedSvg = svgContent.replaceAll(oldColorHex, newColorHex);

      final String fileName = assetPath.split('/').last;
      final File outputFile = File('${modifiedSvgsDir.path}/$fileName');
      await outputFile.writeAsString(updatedSvg);
      debugPrint("outputFile::  ${outputFile.path}");
    });
    /* for (String assetPath in svgAssetPaths) {
      final String svgContent = await rootBundle.loadString(assetPath);
      final String updatedSvg = svgContent.replaceAll(oldColorHex, newColorHex);

      final String fileName = assetPath.split('/').last;
      final File outputFile = File('${modifiedSvgsDir.path}/$fileName');
      await outputFile.writeAsString(updatedSvg);
      print("outputFile::  ${outputFile.path}");
    }*/

    debugPrint('SVG color replacement complete. Files saved to: ${modifiedSvgsDir.path}');
  }
}
