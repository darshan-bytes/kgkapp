import 'package:kgk/kgk.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const getReadyPage = '/getReadyPage';
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const categoriesPage = '/categoriesPage';
  static const landingPage = '/landingPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const resetPasswordPage = '/resetPasswordPage';
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
  static const presentationPreviewPage = '/presentationPreviewPage';
  static const findStorePage = '/findStorePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);

      case getReadyPage:
        return MaterialPageRoute(
          builder: (_) => const GetReadyScreen(),
          settings: settings,
        );

      case signInPage:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case signUpPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<SignUpBloc>(context).add(const SignUpResetEvent());
            return const SignUpScreen();
          },
          settings: settings,
        );
      case categoriesPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<CategoriesBloc>(context).add(CategoriesInitialEvent(context: context));
            return const CategoriesScreen();
          },
          settings: settings,
        );

      case landingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<LandingBloc>(context).add(LandingInitialEvent(context: context));
            return const LandingScreen();
          },
          settings: settings,
        );

      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case resetPasswordPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<ResetPasswordBloc>(context).add(const ResetPasswordInitialEvent());
            return const ResetPasswordScreen();
          },
          settings: settings,
        );

      case emailSentPage:
        return MaterialPageRoute(
          builder: (_) => const ForgotEmailSentScreen(),
          settings: settings,
        );

      case notificationPage:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
          settings: settings,
        );

      case collectionPage:
        return MaterialPageRoute(
          builder: (_) => const CollectionScreen(),
          settings: settings,
        );

      case productListGridPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<ProductListBloc>(
              create: (context) => ProductListBloc()..add(InitialProductListEvent(context)),
              child: const ProductListScreen(),
            );
          },
          settings: settings,
        );

      case stoneDetailPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<StoneDetailBloc>(
              create: (context) => StoneDetailBloc()..add(StoneDetailInitialEvent(context: context)),
              child: const StoneDetailScreen(),
            );
          },
          settings: settings,
        );

      case settingDetailPage:
        return MaterialPageRoute(
          builder: (_) => const SettingDetailScreen(),
          settings: settings,
        );

      case stoneListingPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<StoneListingBloc>(
              create: (context) => StoneListingBloc()..add(GetStoneProductListEvent(context)),
              child: const StoneListingScreen(),
            );
          },
          settings: settings,
        );

      case settingListingPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SettingListingBloc>(
              create: (context) => SettingListingBloc()..add(GetSettingProductListEvent(context)),
              child: const SettingListingScreen(),
            );
          },
          settings: settings,
        );

      case completeProductPage:
        return MaterialPageRoute(
          builder: (_) => const CompleteProductScreen(),
          settings: settings,
        );

      case addAddressPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<AddAddressBloc>(context).add(AddAddressInitialEvent(context));
            return const AddAddressScreen();
          },
          settings: settings,
        );

      case addressListPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<AddressListBloc>(context).add(const LoadAddressListEvent());
            return const AddressListScreen();
          },
          settings: settings,
        );

      case wishListPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<WishlistBloc>(context).add(const InitialWishlistEvent());
            return const WishlistScreen();
          },
          settings: settings,
        );

      case compareProductPage:
        return MaterialPageRoute(
          builder: (_) => const CompareProductScreen(),
          settings: settings,
        );

      case paymentPage:
        return MaterialPageRoute(
          builder: (_) => const PaymentScreen(),
          settings: settings,
        );

      case productDetailsPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProductDetailsBloc>(
            create: (_) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
            child: const ProductDetailsScreen(),
          ),
          settings: settings,
        );

      case diamondInfoPopupPage:
        return MaterialPageRoute(
          builder: (_) => const DiamondInfoPopupScreen(),
          settings: settings,
        );

      case productMenuBottomSheet:
        return MaterialPageRoute(
          builder: (_) => const ProductMenuBottomSheet(),
          settings: settings,
        );

      case auctionPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<AuctionBloc>(context).add(const AuctionInitialEvent());
            return const AuctionScreen();
          },
          settings: settings,
        );

      case writeReviewPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<WriteReviewBloc>(context).add(const WriteReviewInitialEvent());
            return const WriteReviewScreen();
          },
          settings: settings,
        );

      case orderConfirmationPage:
        return MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(
            orderNumber: context.routesData?[RoutesData.orderNumber] ?? '',
          ),
          settings: settings,
        );

      case orderPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<OrdersBloc>(context).add(OrdersInitialEvent(context));
            return const OrderScreen();
          },
          settings: settings,
        );

      case orderDetailsPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<OrderDetailBloc>(
              create: (_) => OrderDetailBloc()..add(InitialOrderDetailEvent()),
              child: const OrderDetailScreen(),
            );
          },
          settings: settings,
        );

      case auctionListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<AuctionListingBloc>(context).add(const InitialAuctionListingEvent());
            return const AuctionListingScreen();
          },
          settings: settings,
        );

      case orderTimelinePage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<OrderTimelineBloc>(
              create: (context) => OrderTimelineBloc()..add(InitialOrderTimelineEvent(context)),
              child: const OrderTimelineScreen(),
            );
          },
          settings: settings,
        );

      case makeInquiryPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<MakeInquiryBloc>(context).add(MakeInquiryInitialEvent());
            return const MakeInquiryScreen();
          },
          settings: settings,
        );

      case searchPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<SearchBloc>(context).add(InitialSearchEvent());
            return const SearchScreen();
          },
          settings: settings,
        );

      case qrScannerPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<QrCodeScanLoginBloc>(
              create: (context) => QrCodeScanLoginBloc(),
              child: const QrScannerScreen(),
            );
          },
          settings: settings,
        );

      case searchResultPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SearchResultBloc>(
              create: (context) => SearchResultBloc()..add(InitialSearchResultEvent(context: context)),
              child: const SearchResultScreen(),
            );
          },
          settings: settings,
        );

      case notificationSettingsPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<NotificationSettingsBloc>(
              create: (context) => NotificationSettingsBloc(),
              child: const NotificationSettingsView(),
            );
          },
          settings: settings,
        );

      case cmsWebViewPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<CmsWebViewBloc>(
              create: (context) => CmsWebViewBloc()..add(CmsWebViewInitialEvent(context: context)),
              child: const CmsWebViewScreen(),
            );
          },
          settings: settings,
        );

      case faqPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<FaqBloc>(context).add(const FaqInitialEvent());
            return const FaqScreen();
          },
          settings: settings,
        );

      case preferencesPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<PreferencesBloc>(context).add(PreferencesInitialEvent());
            return const PreferencesScreen();
          },
          settings: settings,
        );

      case userTypeSelection:
        return MaterialPageRoute(
          builder: (_) => const UserTypeSelection(),
          settings: settings,
        );

      case contactUsPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<ContactUsBloc>(context).add(ContactUsInitialEvent());
            return const ContactUsScreen();
          },
          settings: settings,
        );

      case dashboardPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<DashboardBloc>(context).add(const DashboardInitialEvent());
            return const DashboardScreen();
          },
          settings: settings,
        );

      case pddListingPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<PddListingBloc>(
              create: (context) => PddListingBloc(),
              child: const PddListingScreen(),
            );
          },
          settings: settings,
        );

      case conceptListPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<ConceptListBloc>(context).add(const ConceptListInitialEvent());
            return const ConceptListScreen();
          },
          settings: settings,
        );

      case monitoringPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<MonitoringBloc>(context).add(MonitoringInitialEvent());
            return const MonitoringScreen();
          },
          settings: settings,
        );

      case savedAddressPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<SavedAddressBloc>(context).add(const SavedAddressInitialEvent());
            return const SavedAddressScreen();
          },
          settings: settings,
        );

      case shippingAddressPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<ShippingAddressBloc>(context).add(ShippingAddressInitialEvent(context));
            return const ShippingAddressScreen();
          },
          settings: settings,
        );

      case projectListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<ProjectListingBloc>(context).add(InitialProjectListingEvent(context: context));
            return const ProjectListingScreen();
          },
          settings: settings,
        );

      case designBriefsPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<DesignBriefsBloc>(context).add(InitialDesignBriefsEvent(context: context));
            return const DesignBriefsScreen();
          },
          settings: settings,
        );

      case designListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<DesignListingBloc>(context).add(InitialDesignListingEvent(context: context));
            return const DesignListingScreen();
          },
          settings: settings,
        );

      case stylesListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<StylesListingBloc>(context).add(const StylesListingInitialEvent());
            return const StylesListingScreen();
          },
          settings: settings,
        );

      case presentationPreviewPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PddPreviewBloc>(
            create: (_) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewScreen(),
          ),
          settings: settings,
        );

      case findStorePage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<FindStoreBloc>(context).add(FindStoreInitialEvent());
            return const FindStoreScreen();
          },
          settings: settings,
        );

      default:
        return _errorRoute();
    }
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
  addressId,
  isShippingAddress,
  isFromCheckout,
  presentationId
}

enum ScreenIdentifier {
  diamondForDIY,
  diamondForDefault,
  productForGemstones,
  productForDiamonds,
  productForRing,
  productForLibraryGrey,
  productForLibraryPlatinum
}

extension RoutesDataExtension on BuildContext {
  Map<RoutesData, dynamic>? get routesData => ModalRoute.of(this)?.settings.arguments as Map<RoutesData, dynamic>?;

  Future<dynamic> pushNamed(String routeName, {Map<RoutesData, dynamic>? arguments}) async {
    return await Navigator.pushNamed(this, routeName, arguments: arguments);
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

  dynamic popUntil(RoutePredicate predicate) async {
    return Navigator.popUntil(this, predicate);
  }

  dynamic popUntilOfContext(RoutePredicate predicate) async {
    return Navigator.of(this).popUntil(predicate);
  }

  Future<dynamic> pop({Map<RoutesData, dynamic>? arguments}) async {
    return Navigator.pop(this, arguments);
  }
}
