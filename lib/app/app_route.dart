import 'package:kgk/kgk.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const categoriesPage = '/categoriesPage';
  static const landingPage = '/landingPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const emailSentPage = '/emailSentPage';
  static const notificationPage = '/notificationPage';
  static const collectionPage = '/collectionPage';
  static const productListGridPage = '/productListGridPage';
  static const stoneDetailPage = '/stoneDetailPage';
  static const settingDetailPage = '/settingDetailPage';
  static const stoneListingPage = '/stoneListingPage';
  static const settingListingPage = '/settingListingPage';
  static const completeProductPage = '/completeProductPage';
  static const productDetailsPage = '/productDetailsPage';
  static const addAddressPage = '/addAddressPage';
  static const addressListPage = '/addressListPage';
  static const wishListPage = '/wishListPage';
  static const compareProductPage = '/compareProductPage';
  static const orderConfirmationPage = '/orderConfirmationPage';
  static const paymentPage = '/paymentPage';
  static const writeReviewPage = '/writeReviewPage';
  static const diamondInfoPopupPage = '/diamondInfoPopupPage';
  static const productMenuBottomSheet = '/productMenuBottomSheet';
  static const auctionPage = '/auctionPage';
  static const orderPage = '/orderPage';
  static const orderDetailsPage = '/orderDetailsPage';
  static const auctionListingPage = '/auctionListingPage';
  static const orderTimelinePage = '/orderTimelinePage';
  static const makeInquiryPage = '/makeInquiryPage';
  static const qrScannerPage = '/qrScannerPage';
  static const searchPage = '/searchPage';
  static const searchResultPage = '/searchResultPage';
  static const notificationSettingsPage = '/notificationSettingsPage';
  static const cmsWebViewPage = '/cmsWebViewPage';
  static const faqPage = '/faqPage';
  static const preferencesPage = '/preferencesPage';
  static const userTypeSelection = '/userTypeSelection';
  static const contactUsPage = '/contactUsPage';
  static const dashboardPage = '/dashboardPage';
  static const pddListingPage = '/pddListingPage';
  static const conceptListPage = '/conceptListPage';
  static const monitoringPage = '/monitoringPage';
  static const savedAddressPage = '/savedAddressPage';
  static const shippingAddressPage = '/shippingAddressPage';
  static const projectListingPage = '/projectListingPage';
  static const designBriefsPage = '/designBriefsPage';
  static const designListingPage = '/designListingPage';
  static const stylesListingPage = '/stylesListingPage';
  static const digitalCataloguePage = '/digitalCataloguePage';
  static const presentationPreviewPage = '/presentationPreviewPage';
  static const presentationPreviewHistory = '/presentationPreviewHistory';
  static const findStorePage = '/findStorePage';
  static const cadLibraryListingPage = '/cadLibraryListingPage';
  static const designLibraryFeedbackPage = '/designLibraryFeedbackPage';
  static const exhibitionListingPage = '/exhibitionListingPage';
  static const allReviewPage = '/allReviewPage';
  static const stonesLandingPage = '/stonesLandingPage';
  static const watchListPage = '/watchListPage';
  static const previewCataloguePage = '/previewCataloguePage';
  static const designLibraryScreen = '/designLibraryScreen';
  static const activityLogScreenPage = '/activityLogScreenPage';
  static const watchlistDetailsPage = '/watchlistDetailsPage';
  static const manufacturerOrderListingPage = '/manufacturerOrderListingPage';
  static const myOrderTypeSelectionPage = '/myOrderTypeSelectionPage';
  static const retailerOrderListingPage = '/retailerOrderListingPage';
  static const manufacturerOrderDetailsPage = '/manufacturerOrderDetailsPage';
  static const userMasterListingPage = '/userMasterListingPage';
  static const orionPage = '/orionPage';
  static const messagesPage = '/messagesPage';
  static const messagesDetailPage = '/messagesDetailPage';
  static const exhibitionDetailsPage = '/exhibitionDetailsPage';
  static const calendarPage = '/calendarPage';
  static const presentationPage = '/presentationPage';
  static const newsletterPage = '/newsletterPage';
  static const imageSearchPage = '/imageSearchPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');

    WidgetBuilder builder;
    switch (settings.name) {
      case initialRoute:
        builder = (context) => const SplashScreen();
        break;

      case signInPage:
        builder = (context) => const SignInScreen();
        break;

      case signUpPage:
        builder = (context) {
          BlocProvider.of<SignUpBloc>(context).add(SignUpInitialEvent(context));
          return const SignUpScreen();
        };
        break;

      case categoriesPage:
        builder = (context) {
          BlocProvider.of<CategoriesBloc>(context).add(CategoriesInitialEvent(context: context));
          return const CategoriesScreen();
        };
        break;

      case landingPage:
        builder = (context) {
          BlocProvider.of<LandingBloc>(context).add(LandingInitialEvent(context: context));
          return const LandingScreen();
        };
        break;

      case forgotPasswordPage:
        builder = (context) {
          BlocProvider.of<ForgotPasswordBloc>(context).add(const ForgotPasswordInitialEvent());
          return const ForgotPasswordScreen();
        };
        break;

      case emailSentPage:
        builder = (context) => const ForgotEmailSentScreen();
        break;

      case notificationPage:
        builder = (context) => const NotificationScreen();
        break;

      case collectionPage:
        builder = (context) {
          return BlocProvider<CollectionBloc>(
            lazy: false,
            create: (context) => CollectionBloc()..add(CollectionInitialEvent(context: context)),
            child: const CollectionScreen(),
          );
        };
        break;

      case productListGridPage:
        builder = (context) {
          return BlocProvider<ProductListBloc>(
            create: (context) => ProductListBloc()..add(InitialProductListEvent(context)),
            child: const ProductListScreen(),
          );
        };
        break;

      case stoneDetailPage:
        builder = (context) {
          return BlocProvider<StoneDetailBloc>(
            create: (context) => StoneDetailBloc()..add(StoneDetailInitialEvent(context: context)),
            child: const StoneDetailScreen(),
          );
        };
        break;

      case settingDetailPage:
        builder = (context) => const SettingDetailScreen();
        break;

      case stoneListingPage:
        builder = (context) {
          return BlocProvider<StoneListingBloc>(
            create: (context) => StoneListingBloc()..add(GetStoneProductListEvent(context)),
            child: const StoneListingScreen(),
          );
        };
        break;

      case settingListingPage:
        builder = (context) {
          return BlocProvider<SettingListingBloc>(
            create: (context) => SettingListingBloc()..add(GetSettingProductListEvent(context)),
            child: const SettingListingScreen(),
          );
        };
        break;

      case completeProductPage:
        builder = (context) => const CompleteProductScreen();
        break;

      case addAddressPage:
        builder = (context) {
          return BlocProvider<AddAddressBloc>(
            create: (context) => AddAddressBloc()..add(AddAddressInitialEvent(context)),
            child: const AddAddressScreen(),
          );
        };
        break;

      case addressListPage:
        builder = (context) {
          return BlocProvider<AddressListBloc>(
            create: (context) => AddressListBloc()..add(LoadAddressListEvent(context)),
            child: const AddressListScreen(),
          );
        };
        break;

      case wishListPage:
        builder = (context) {
          BlocProvider.of<WishlistBloc>(context).add(InitialWishlistEvent(context));
          return const WishlistScreen();
        };
        break;

      case compareProductPage:
        builder = (context) => const CompareProductScreen();
        break;

      case paymentPage:
        builder = (context) => const PaymentScreen();
        break;

      case productDetailsPage:
        builder = (context) {
          return BlocProvider<ProductDetailsBloc>(
            create: (context) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
            child: const ProductDetailsScreen(),
          );
        };
        break;

      case diamondInfoPopupPage:
        builder = (context) {
          return BlocProvider<DiamondInfoPopupBloc>(
            create: (context) => DiamondInfoPopupBloc()..add(DiamondInfoPopupInitialEvent(context)),
            child: const DiamondInfoPopupScreen(),
          );
        };
        break;

      case productMenuBottomSheet:
        builder = (context) => const ProductMenuBottomSheet();
        break;

      case auctionPage:
        builder = (context) {
          BlocProvider.of<AuctionBloc>(context).add(AuctionInitialEvent(context: context));
          return const AuctionScreen();
        };
        break;

      case writeReviewPage:
        builder = (context) {
          return BlocProvider<WriteReviewBloc>(
            create: (context) => WriteReviewBloc()..add(WriteReviewInitialEvent(context)),
            child: const WriteReviewScreen(),
          );
        };
        break;

      case orderConfirmationPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OrderConfirmationScreen(
            orderNumber: context.routesData?[RoutesData.orderNumber] ?? '',
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orderPage:
        builder = (context) {
          BlocProvider.of<OrdersBloc>(context).add(OrdersInitialEvent(context));
          return const OrderScreen();
        };
        break;

      case orderDetailsPage:
        builder = (context) {
          return BlocProvider<OrderDetailBloc>(
            create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
            child: const OrderDetailScreen(),
          );
        };
        break;

      case auctionListingPage:
        builder = (context) {
          return BlocProvider<AuctionListingBloc>(
            create: (context) => AuctionListingBloc()..add(InitialAuctionListingEvent(context)),
            child: const AuctionListingScreen(),
          );
        };
        break;

      case orderTimelinePage:
        builder = (context) {
          return BlocProvider<OrderTimelineBloc>(
            create: (context) => OrderTimelineBloc()..add(InitialOrderTimelineEvent(context)),
            child: const OrderTimelineScreen(),
          );
        };
        break;

      case makeInquiryPage:
        builder = (context) {
          BlocProvider.of<MakeInquiryBloc>(context).add(MakeInquiryInitialEvent());
          return const MakeInquiryScreen();
        };
        break;

      case searchPage:
        builder = (context) {
          return BlocProvider<SearchBloc>(
            create: (context) => SearchBloc()..add(InitialSearchEvent()),
            child: const SearchScreen(),
          );
        };
        break;

      case qrScannerPage:
        builder = (context) {
          return BlocProvider<QrCodeScanLoginBloc>(
            create: (context) => QrCodeScanLoginBloc(),
            child: const QrScannerScreen(),
          );
        };
        break;

      case searchResultPage:
        builder = (context) {
          return BlocProvider<SearchResultBloc>(
            create: (context) => SearchResultBloc()..add(InitialSearchResultEvent(context: context)),
            child: const SearchResultScreen(),
          );
        };
        break;

      case notificationSettingsPage:
        builder = (context) {
          return BlocProvider<NotificationSettingsBloc>(
            create: (context) => NotificationSettingsBloc(),
            child: const NotificationSettingsView(),
          );
        };
        break;

      case cmsWebViewPage:
        builder = (context) {
          return BlocProvider<CmsWebViewBloc>(
            create: (context) => CmsWebViewBloc()..add(CmsWebViewInitialEvent(context: context)),
            child: const CmsWebViewScreen(),
          );
        };
        break;

      case faqPage:
        builder = (context) {
          BlocProvider.of<FaqBloc>(context).add(const FaqInitialEvent());
          return const FaqScreen();
        };
        break;

      case preferencesPage:
        builder = (context) {
          BlocProvider.of<PreferencesBloc>(context).add(PreferencesInitialEvent(context));
          return const PreferencesScreen();
        };
        break;

      case userTypeSelection:
        builder = (context) => const UserTypeSelection();
        break;

      case contactUsPage:
        builder = (context) {
          BlocProvider.of<ContactUsBloc>(context).add(ContactUsInitialEvent());
          return const ContactUsScreen();
        };
        break;

      case dashboardPage:
        builder = (context) {
          BlocProvider.of<DashboardBloc>(context).add(const DashboardInitialEvent());
          return const DashboardScreen();
        };
        break;

      case pddListingPage:
        builder = (context) {
          return BlocProvider<PddListingBloc>(
            create: (context) => PddListingBloc()..add(InitialPddListingEvent(context: context)),
            child: const PddListingScreen(),
          );
        };
        break;

      case conceptListPage:
        builder = (context) {
          return BlocProvider<ConceptListBloc>(
            create: (context) => ConceptListBloc()..add(const ConceptListInitialEvent()),
            child: const ConceptListScreen(),
          );
        };
        break;

      case monitoringPage:
        builder = (context) {
          BlocProvider.of<MonitoringBloc>(context).add(MonitoringInitialEvent());
          return const MonitoringScreen();
        };
        break;

      case savedAddressPage:
        builder = (context) {
          return BlocProvider<SavedAddressBloc>(
            create: (context) => SavedAddressBloc()..add(SavedAddressInitialEvent(context)),
            child: const SavedAddressScreen(),
          );
        };
        break;

      case shippingAddressPage:
        builder = (context) {
          return BlocProvider<ShippingAddressBloc>(
            create: (context) => ShippingAddressBloc()..add(ShippingAddressInitialEvent(context)),
            child: const ShippingAddressScreen(),
          );
        };
        break;

      case projectListingPage:
        builder = (context) {
          BlocProvider.of<ProjectListingBloc>(context).add(InitialProjectListingEvent(context: context));
          return const ProjectListingScreen();
        };
        break;

      case designBriefsPage:
        builder = (context) {
          BlocProvider.of<DesignBriefsBloc>(context).add(InitialDesignBriefsEvent(context: context));
          return const DesignBriefsScreen();
        };
        break;

      case designListingPage:
        builder = (context) {
          BlocProvider.of<DesignListingBloc>(context).add(InitialDesignListingEvent(context: context));
          return const DesignListingScreen();
        };
        break;

      case stylesListingPage:
        builder = (context) {
          BlocProvider.of<StylesListingBloc>(context).add(const StylesListingInitialEvent());
          return const StylesListingScreen();
        };
        break;

      case digitalCataloguePage:
        builder = (context) {
          BlocProvider.of<DigitalCatalogueBloc>(context).add(DigitalCatalogueInitialEvent(context: context));
          return const DigitalCatalogueListingScreen();
        };
        break;

      case presentationPreviewPage:
        builder = (context) {
          return BlocProvider<PddPreviewBloc>(
            create: (context) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewScreen(),
          );
        };
        break;

      case findStorePage:
        builder = (context) {
          BlocProvider.of<FindStoreBloc>(context).add(FindStoreInitialEvent());
          return const FindStoreScreen();
        };
        break;

      case presentationPreviewHistory:
        builder = (context) {
          return BlocProvider<PddPreviewBloc>(
            create: (context) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewHistoryScreen(),
          );
        };
        break;

      case cadLibraryListingPage:
        builder = (context) {
          BlocProvider.of<CadLibraryListingBloc>(context).add(InitialCadListingEvent(context: context));
          return const CadLibraryListingScreen();
        };
        break;

      case designLibraryFeedbackPage:
        builder = (context) {
          BlocProvider.of<DesignLibraryFeedbackBloc>(context).add(InitialDesignLibraryFeedbackEvent());
          return const DesignLibraryFeedbackScreen();
        };
        break;

      case watchListPage:
        builder = (context) {
          BlocProvider.of<WatchlistBloc>(context).add(WatchlistInitialEvent(context));
          return const WatchlistScreen();
        };
        break;

      case allReviewPage:
        builder = (context) {
          return BlocProvider<AllReviewBloc>(
            create: (context) => AllReviewBloc()..add(AllReviewInitialEvent(context)),
            child: const AllReviewScreen(),
          );
        };
        break;

      case exhibitionListingPage:
        builder = (context) {
          BlocProvider.of<ExhibitionListingBloc>(context).add(InitialExhibitionListingEvent(context: context));
          return const ExhibitionListingScreen();
        };
        break;

      case stonesLandingPage:
        builder = (context) {
          BlocProvider.of<StonesLandingBloc>(context).add(InitialStonesLandingEvent(context: context));
          return const StonesLandingScreen();
        };
        break;

      case previewCataloguePage:
        builder = (context) {
          return BlocProvider<PreviewCatalogueBloc>(
            create: (context) => PreviewCatalogueBloc()..add(InitialPreviewCatalogueEvent(context)),
            child: const PreviewCatalogueScreen(),
          );
        };
        break;

      case designLibraryScreen:
        builder = (context) {
          BlocProvider.of<DesignLibraryBloc>(context).add(const DesignLibraryInitialEvent());
          return const DesignLibraryScreen();
        };
        break;

      case activityLogScreenPage:
        builder = (context) {
          BlocProvider.of<ActivityLogBloc>(context).add(ActivityLogInitialEvent());
          return const ActivityLogScreen();
        };
        break;

      case watchlistDetailsPage:
        builder = (context) {
          return BlocProvider<WatchlistDetailsBloc>(
            create: (context) => WatchlistDetailsBloc()..add(WatchlistDetailsInitialEvent(context)),
            child: const WatchlistDetailsScreen(),
          );
        };
        break;

      case orionPage:
        builder = (context) {
          BlocProvider.of<OrionBloc>(context).add(const OrionInitialEvent());
          return const OrionScreen();
        };
        break;

      case manufacturerOrderListingPage:
        builder = (context) {
          BlocProvider.of<ManufacturerOrderListingBloc>(context).add(const InitialManufacturerOrderListingEvent());
          return const ManufacturerOrderListingScreen();
        };
        break;

      case myOrderTypeSelectionPage:
        builder = (context) => const MyOrderTypeSelection();
        break;

      case retailerOrderListingPage:
        builder = (context) {
          BlocProvider.of<RetailerOrderListingBloc>(context).add(RetailerOrderListingInitialEvent(context: context));
          return const RetailerOrderListingScreen();
        };
        break;

      case manufacturerOrderDetailsPage:
        builder = (context) {
          return BlocProvider<ManufacturerOrderDetailsBloc>(
            create: (context) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
            child: const ManufacturerOrderDetailsScreen(),
          );
        };
        break;

      case newsletterPage:
        builder = (context) {
          BlocProvider.of<NewsletterBloc>(context).add(NewsletterInitialEvent(context: context));
          return const NewsletterScreen();
        };
        break;

      case userMasterListingPage:
        builder = (context) {
          BlocProvider.of<UserMasterListingBloc>(context).add(const InitialUserMasterListingEvent());
          return const UserMasterListingScreen();
        };
        break;

      case messagesPage:
        builder = (context) {
          return BlocProvider<MessagesBloc>(
            create: (context) => MessagesBloc()..add(MessagesInitialEvent(context: context)),
            child: const MessagesScreen(),
          );
        };
        break;

      case calendarPage:
        builder = (context) {
          return BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc()..add(InitialCalendarEvent(context)),
            child: const CalendarScreen(),
          );
        };
        break;

      case messagesDetailPage:
        builder = (context) {
          return BlocProvider<MessageDetailBloc>(
            create: (context) => MessageDetailBloc()..add(MessageDetailInitialEvent(context: context)),
            child: const MessageDetailScreen(),
          );
        };
        break;

      case exhibitionDetailsPage:
        builder = (context) {
          return BlocProvider<ExhibitionDetailsBloc>(
            create: (context) => ExhibitionDetailsBloc()..add(const ExhibitionDetailsInitialEvent()),
            child: const ExhibitionDetailsScreen(),
          );
        };
        break;

      case presentationPage:
        builder = (context) {
          BlocProvider.of<PresentationBloc>(context).add(const InitialPresentationEvent());
          return const PresentationScreen();
        };
        break;

      case imageSearchPage:
        builder = (context) {
          return BlocProvider<ImageSearchBloc>(
            create: (context) => ImageSearchBloc()..add(ImageSearchInitialEvent()),
            child: const ImageSearchScreen(),
          );
        };
        break;

      default:
        return _errorRoute();
    }

    return _buildRoute(settings, builder);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Page not found'),
        ),
      );
    });
  }

  static Route<dynamic> _buildRoute(RouteSettings settings, WidgetBuilder builder) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: settings,
        fullscreenDialog: false,
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => builder(context),
        transitionsBuilder: commonTransitionBuilder,
        settings: settings,
      );
    }
  }

  // make commomn transition builder
  static Widget commonTransitionBuilder(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

enum RoutesData {
  productListData,
  productId,
  orderNumber,
  isCustomisationPage,
  addressDetails,
  isPageFor,
  searchResultData,
  cmsPageData,
  isNoDataFound,
  isShippingAddress,
  isFromCheckout,
  presentationId,
  catalogueData,
  watchlistId,
  messageModel,
  conceptId,
  diamondInfo,
  isWatchlistCreated,
  isWatchlistUpdated,
  commodity,
  collectionName,
  productNavigation,
  sortData,
  auctionModelData
}

enum ScreenIdentifier {
  diamondForDIY,
  diamondForDefault,
  productForGemstones,
  productForDiamonds,
  productForRing,
  productForLibraryGrey,
  productForLibraryPlatinum,
  landingForDiamonds,
  landingForJewellery,
  landingForGemstones,
  orderDetailsForMyOrder,
  orderDetailsForRetailer,
  orderDetailsForManufacturer,
  cancelOrderForRetailer,
  cancelOrderForManufacturer,
}

extension RoutesDataExtension on BuildContext {
  Map<RoutesData, dynamic>? get routesData => ModalRoute.of(this)?.settings.arguments as Map<RoutesData, dynamic>?;

  Future<dynamic> pushNamed(String routeName, {Map<RoutesData, dynamic>? arguments}) async {
    if (mounted) {
      return await Navigator.pushNamed(this, routeName, arguments: arguments);
    }
    return null;
  }

  Future<dynamic> pushNamedOfContext(String routeName, {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushNamed(String routeName, {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.popAndPushNamed(this, routeName, arguments: arguments);
  }

  Future<dynamic> popAndPushNamedOfContext(String routeName, {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.of(this).popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate, {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.pushNamedAndRemoveUntil(this, routeName, predicate, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntilOfContext(String routeName, RoutePredicate predicate,
      {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.of(this).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void popUntil(RoutePredicate predicate) async {
    return Navigator.popUntil(this, predicate);
  }

  void popUntilOfContext(RoutePredicate predicate) async {
    return Navigator.of(this).popUntil(predicate);
  }

  Future<dynamic> pop({Map<RoutesData, dynamic>? arguments}) async {
    return Navigator.pop(this, arguments);
  }

  Future<dynamic> popOfContext({Map<RoutesData, dynamic>? arguments}) async {
    return Navigator.of(this).pop(arguments);
  }
}
