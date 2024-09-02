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
          return BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc()..add(SignUpInitialEvent(context)),
            child: const SignUpScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<SignUpBloc>(context).add(SignUpInitialEvent(context));
      //     return const SignUpScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );
      case categoriesPage:
        builder = (context) {
          return BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc()..add(CategoriesInitialEvent(context: context)),
            child: const CategoriesScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<CategoriesBloc>(context).add(CategoriesInitialEvent(context: context));
      //     return const CategoriesScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case landingPage:
        builder = (context) {
          return BlocProvider<LandingBloc>(
            create: (context) => LandingBloc()..add(LandingInitialEvent(context: context)),
            child: const LandingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<LandingBloc>(context).add(LandingInitialEvent(context: context));
      //     return const LandingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case forgotPasswordPage:
        builder = (context) {
          return BlocProvider<ForgotPasswordBloc>(
            create: (context) => ForgotPasswordBloc()..add(const ForgotPasswordInitialEvent()),
            child: const ForgotPasswordScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ForgotPasswordBloc>(context).add(const ForgotPasswordInitialEvent());
      //     return const ForgotPasswordScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case emailSentPage:
        builder = (context) => const ForgotEmailSentScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const ForgotEmailSentScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case notificationPage:
        builder = (context) => const NotificationScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const NotificationScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case collectionPage:
        builder = (context) => const CollectionScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const CollectionScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case productListGridPage:
        builder = (context) {
          return BlocProvider<ProductListBloc>(
            create: (context) => ProductListBloc()..add(InitialProductListEvent(context)),
            child: const ProductListScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     return BlocProvider<ProductListBloc>(
      //       create: (context) => ProductListBloc()..add(InitialProductListEvent(context)),
      //       child: const ProductListScreen(), 
      //     );
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case stoneDetailPage:
        builder = (context) {
          return BlocProvider<StoneDetailBloc>(
            create: (context) => StoneDetailBloc()..add(StoneDetailInitialEvent(context: context)),
            child: const StoneDetailScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     return BlocProvider<StoneDetailBloc>(
      //       create: (context) => StoneDetailBloc()..add(StoneDetailInitialEvent(context: context)),
      //       child: const StoneDetailScreen(),
      //     );
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case settingDetailPage:
        builder = (context) => const SettingDetailScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const SettingDetailScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case stoneListingPage:
        builder = (context) {
          return BlocProvider<StoneListingBloc>(
            create: (context) => StoneListingBloc()..add(GetStoneProductListEvent(context)),
            child: const StoneListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     return BlocProvider<StoneListingBloc>(
      //       create: (context) => StoneListingBloc()..add(GetStoneProductListEvent(context)),
      //       child: const StoneListingScreen(),
      //     );
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case settingListingPage:
        builder = (context) {
          return BlocProvider<SettingListingBloc>(
            create: (context) => SettingListingBloc()..add(GetSettingProductListEvent(context)),
            child: const SettingListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SettingListingBloc>(
      //     create: (context) => SettingListingBloc()..add(GetSettingProductListEvent(context)),
      //     child: const SettingListingScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case completeProductPage:
        builder = (context) => const CompleteProductScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const CompleteProductScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case addAddressPage:
        builder = (context) {
          return BlocProvider<AddAddressBloc>(
            create: (context) => AddAddressBloc()..add(AddAddressInitialEvent(context)),
            child: const AddAddressScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<AddAddressBloc>(context).add(AddAddressInitialEvent(context));
      //     return const AddAddressScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case addressListPage:
        builder = (context) {
          return BlocProvider<AddressListBloc>(
            create: (context) => AddressListBloc()..add(const LoadAddressListEvent()),
            child: const AddressListScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<AddressListBloc>(context).add(const LoadAddressListEvent());
      //     return const AddressListScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case wishListPage:
        builder = (context) {
          return BlocProvider<WishlistBloc>(
            create: (context) => WishlistBloc()..add(const InitialWishlistEvent()),
            child: const WishlistScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<WishlistBloc>(context).add(const InitialWishlistEvent());
      //     return const WishlistScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case compareProductPage:
        builder = (context) => const CompareProductScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const CompareProductScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case paymentPage:
        builder = (context) => const PaymentScreen();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const PaymentScreen(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case productDetailsPage:
        builder = (context) {
          return BlocProvider<ProductDetailsBloc>(
            create: (context) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
            child: const ProductDetailsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ProductDetailsBloc>(
      //     create: (_) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
      //     child: const ProductDetailsScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case diamondInfoPopupPage:
        builder = (context) {
          return BlocProvider<DiamondInfoPopupBloc>(
            create: (context) => DiamondInfoPopupBloc()..add(DiamondInfoPopupInitialEvent(context)),
            child: const DiamondInfoPopupScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     return BlocProvider<DiamondInfoPopupBloc>(
      //       create: (_) => DiamondInfoPopupBloc()..add(DiamondInfoPopupInitialEvent(context)),
      //       child: const DiamondInfoPopupScreen(),
      //     );
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case productMenuBottomSheet:
        builder = (context) => const ProductMenuBottomSheet();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const ProductMenuBottomSheet(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case auctionPage:
        builder = (context) {
          return BlocProvider<AuctionBloc>(
            create: (context) => AuctionBloc()..add(AuctionInitialEvent(context: context)),
            child: const AuctionScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<AuctionBloc>(context).add(AuctionInitialEvent(context: context));
      //     return const AuctionScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case writeReviewPage:
        builder = (context) {
          return BlocProvider<WriteReviewBloc>(
            create: (context) => WriteReviewBloc()..add(const WriteReviewInitialEvent()),
            child: const WriteReviewScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<WriteReviewBloc>(context).add(const WriteReviewInitialEvent());
      //     return const WriteReviewScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

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
          return BlocProvider<OrdersBloc>(
            create: (context) => OrdersBloc()..add(OrdersInitialEvent(context)),
            child: const OrderScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<OrdersBloc>(context).add(OrdersInitialEvent(context));
      //     return const OrderScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case orderDetailsPage:
        builder = (context) {
          return BlocProvider<OrderDetailBloc>(
            create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
            child: const OrderDetailScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrderDetailBloc>(
      //     create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
      //     child: const OrderDetailScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case auctionListingPage:
        builder = (context) {
          return BlocProvider<AuctionListingBloc>(
            create: (context) => AuctionListingBloc()..add(const InitialAuctionListingEvent()),
            child: const AuctionListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AuctionListingBloc>(
      //     create: (_) => AuctionListingBloc()..add(const InitialAuctionListingEvent()),
      //     child: const AuctionListingScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case orderTimelinePage:
        builder = (context) {
          return BlocProvider<OrderTimelineBloc>(
            create: (context) => OrderTimelineBloc()..add(InitialOrderTimelineEvent(context)),
            child: const OrderTimelineScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrderTimelineBloc>(
      //     create: (_) => OrderTimelineBloc()..add(InitialOrderTimelineEvent(context)),
      //     child: const OrderTimelineScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case makeInquiryPage:
        builder = (context) {
          return BlocProvider<MakeInquiryBloc>(
            create: (context) => MakeInquiryBloc()..add(MakeInquiryInitialEvent()),
            child: const MakeInquiryScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<MakeInquiryBloc>(context).add(MakeInquiryInitialEvent());
      //     return const MakeInquiryScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case searchPage:
        builder = (context) {
          return BlocProvider<SearchBloc>(
            create: (context) => SearchBloc()..add(InitialSearchEvent()),
            child: const SearchScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<SearchBloc>(context).add(InitialSearchEvent());
      //     return const SearchScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case qrScannerPage:
        builder = (context) {
          return BlocProvider<QrCodeScanLoginBloc>(
            create: (context) => QrCodeScanLoginBloc(),
            child: const QrScannerScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<QrCodeScanLoginBloc>(
      //     create: (context) => QrCodeScanLoginBloc(),
      //     child: const QrScannerScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case searchResultPage:
        builder = (context) {
          return BlocProvider<SearchResultBloc>(
            create: (context) => SearchResultBloc()..add(InitialSearchResultEvent(context: context)),
            child: const SearchResultScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SearchResultBloc>(
      //     create: (context) => SearchResultBloc()..add(InitialSearchResultEvent(context: context)),
      //     child: const SearchResultScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case notificationSettingsPage:
        builder = (context) {
          return BlocProvider<NotificationSettingsBloc>(
            create: (context) => NotificationSettingsBloc(),
            child: const NotificationSettingsView(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<NotificationSettingsBloc>(
      //     create: (context) => NotificationSettingsBloc(),
      //     child: const NotificationSettingsView(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case cmsWebViewPage:
        builder = (context) {
          return BlocProvider<CmsWebViewBloc>(
            create: (context) => CmsWebViewBloc()..add(CmsWebViewInitialEvent(context: context)),
            child: const CmsWebViewScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<CmsWebViewBloc>(
      //     create: (context) => CmsWebViewBloc()..add(CmsWebViewInitialEvent(context: context)),
      //     child: const CmsWebViewScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case faqPage:
        builder = (context) {
          return BlocProvider<FaqBloc>(
            create: (context) => FaqBloc()..add(const FaqInitialEvent()),
            child: const FaqScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<FaqBloc>(context).add(const FaqInitialEvent());
      //     return const FaqScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case preferencesPage:
        builder = (context) {
          return BlocProvider<PreferencesBloc>(
            create: (context) => PreferencesBloc()..add(PreferencesInitialEvent()),
            child: const PreferencesScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<PreferencesBloc>(context).add(PreferencesInitialEvent());
      //     return const PreferencesScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case userTypeSelection:
        builder = (context) => const UserTypeSelection();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const UserTypeSelection(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case contactUsPage:
        builder = (context) {
          return BlocProvider<ContactUsBloc>(
            create: (context) => ContactUsBloc()..add(ContactUsInitialEvent()),
            child: const ContactUsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ContactUsBloc>(context).add(ContactUsInitialEvent());
      //     return const ContactUsScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case dashboardPage:
        builder = (context) {
          return BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc()..add(const DashboardInitialEvent()),
            child: const DashboardScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DashboardBloc>(context).add(const DashboardInitialEvent());
      //     return const DashboardScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case pddListingPage:
        builder = (context) {
          return BlocProvider<PddListingBloc>(
            create: (context) => PddListingBloc()..add(InitialPddListingEvent(context: context)),
            child: const PddListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddListingBloc>(
      //     create: (context) => PddListingBloc()..add(InitialPddListingEvent(context: context)),
      //     child: const PddListingScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case conceptListPage:
        builder = (context) {
          return BlocProvider<ConceptListBloc>(
            create: (context) => ConceptListBloc()..add(const ConceptListInitialEvent()),
            child: const ConceptListScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ConceptListBloc>(
      //     create: (context) => ConceptListBloc()..add(const ConceptListInitialEvent()),
      //     child: const ConceptListScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case monitoringPage:
        builder = (context) {
          return BlocProvider<MonitoringBloc>(
            create: (context) => MonitoringBloc()..add(MonitoringInitialEvent()),
            child: const MonitoringScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<MonitoringBloc>(context).add(MonitoringInitialEvent());
      //     return const MonitoringScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case savedAddressPage:
        builder = (context) {
          return BlocProvider<SavedAddressBloc>(
            create: (context) => SavedAddressBloc()..add(const SavedAddressInitialEvent()),
            child: const SavedAddressScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<SavedAddressBloc>(context).add(const SavedAddressInitialEvent());
      //     return const SavedAddressScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case shippingAddressPage:
        builder = (context) {
          return BlocProvider<ShippingAddressBloc>(
            create: (context) => ShippingAddressBloc()..add(ShippingAddressInitialEvent(context)),
            child: const ShippingAddressScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ShippingAddressBloc>(context).add(ShippingAddressInitialEvent(context));
      //     return const ShippingAddressScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case projectListingPage:
        builder = (context) {
          return BlocProvider<ProjectListingBloc>(
            create: (context) => ProjectListingBloc()..add(InitialProjectListingEvent(context: context)),
            child: const ProjectListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ProjectListingBloc>(context).add(InitialProjectListingEvent(context: context));
      //     return const ProjectListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case designBriefsPage:
        builder = (context) {
          return BlocProvider<DesignBriefsBloc>(
            create: (context) => DesignBriefsBloc()..add(InitialDesignBriefsEvent(context: context)),
            child: const DesignBriefsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DesignBriefsBloc>(context).add(InitialDesignBriefsEvent(context: context));
      //     return const DesignBriefsScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case designListingPage:
        builder = (context) {
          return BlocProvider<DesignListingBloc>(
            create: (context) => DesignListingBloc()..add(InitialDesignListingEvent(context: context)),
            child: const DesignListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DesignListingBloc>(context).add(InitialDesignListingEvent(context: context));
      //     return const DesignListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case stylesListingPage:
        builder = (context) {
          return BlocProvider<StylesListingBloc>(
            create: (context) => StylesListingBloc()..add(const StylesListingInitialEvent()),
            child: const StylesListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<StylesListingBloc>(context).add(const StylesListingInitialEvent());
      //     return const StylesListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case digitalCataloguePage:
        builder = (context) {
          return BlocProvider<DigitalCatalogueBloc>(
            create: (context) => DigitalCatalogueBloc()..add(const DigitalCatalogueInitialEvent()),
            child: const DigitalCatalogueListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DigitalCatalogueBloc>(context).add(const DigitalCatalogueInitialEvent());
      //     return const DigitalCatalogueListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case presentationPreviewPage:
        builder = (context) {
          return BlocProvider<PddPreviewBloc>(
            create: (context) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddPreviewBloc>(
      //     create: (_) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
      //     child: const PddPreviewScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case findStorePage:
        builder = (context) {
          return BlocProvider<FindStoreBloc>(
            create: (context) => FindStoreBloc()..add(FindStoreInitialEvent()),
            child: const FindStoreScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<FindStoreBloc>(context).add(FindStoreInitialEvent());
      //     return const FindStoreScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case presentationPreviewHistory:
        builder = (context) {
          return BlocProvider<PddPreviewBloc>(
            create: (context) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewHistoryScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddPreviewBloc>(
      //     create: (_) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
      //     child: const PddPreviewHistoryScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case cadLibraryListingPage:
        builder = (context) {
          return BlocProvider<CadLibraryListingBloc>(
            create: (context) => CadLibraryListingBloc()..add(InitialCadListingEvent(context: context)),
            child: const CadLibraryListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<CadLibraryListingBloc>(context).add(InitialCadListingEvent(context: context));
      //     return const CadLibraryListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case designLibraryFeedbackPage:
        builder = (context) {
          return BlocProvider<DesignLibraryFeedbackBloc>(
            create: (context) => DesignLibraryFeedbackBloc()..add(InitialDesignLibraryFeedbackEvent()),
            child: const DesignLibraryFeedbackScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DesignLibraryFeedbackBloc>(context).add(InitialDesignLibraryFeedbackEvent());
      //     return const DesignLibraryFeedbackScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case watchListPage:
        builder = (context) {
          return BlocProvider<WatchlistBloc>(
            create: (context) => WatchlistBloc()..add(WatchlistInitialEvent(context)),
            child: const WatchlistScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<WatchlistBloc>(context).add(WatchlistInitialEvent(context));
      //     return const WatchlistScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case allReviewPage:
        builder = (context) {
          return BlocProvider<AllReviewBloc>(
            create: (context) => AllReviewBloc()..add(AllReviewInitialEvent(context)),
            child: const AllReviewScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<AllReviewBloc>(context).add(AllReviewInitialEvent(context));
      //     return const AllReviewScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case exhibitionListingPage:
        builder = (context) {
          return BlocProvider<ExhibitionListingBloc>(
            create: (context) => ExhibitionListingBloc()..add(InitialExhibitionListingEvent(context: context)),
            child: const ExhibitionListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ExhibitionListingBloc>(context).add(InitialExhibitionListingEvent(context: context));
      //     return const ExhibitionListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      // );

      case stonesLandingPage:
        builder = (context) {
          return BlocProvider<StonesLandingBloc>(
            create: (context) => StonesLandingBloc()..add(InitialStonesLandingEvent(context: context)),
            child: const StonesLandingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<StonesLandingBloc>(context).add(InitialStonesLandingEvent(context: context));
      //     return const StonesLandingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case previewCataloguePage:
        builder = (context) {
          return BlocProvider<PreviewCatalogueBloc>(
            create: (context) => PreviewCatalogueBloc()..add(InitialPreviewCatalogueEvent(context)),
            child: const PreviewCatalogueScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PreviewCatalogueBloc>(
      //     create: (context) => PreviewCatalogueBloc()..add(InitialPreviewCatalogueEvent(context)),
      //     child: const PreviewCatalogueScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case designLibraryScreen:
        builder = (context) {
          return BlocProvider<DesignLibraryBloc>(
            create: (context) => DesignLibraryBloc()..add(const DesignLibraryInitialEvent()),
            child: const DesignLibraryScreen(),
          );
        };
        break;

      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<DesignLibraryBloc>(context).add(const DesignLibraryInitialEvent());
      //     return const DesignLibraryScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case activityLogScreenPage:
        builder = (context) {
          return BlocProvider<ActivityLogBloc>(
            create: (context) => ActivityLogBloc()..add(ActivityLogInitialEvent()),
            child: const ActivityLogScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ActivityLogBloc>(context).add(ActivityLogInitialEvent());
      //     return const ActivityLogScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case watchlistDetailsPage:
        builder = (context) {
          return BlocProvider<WatchlistDetailsBloc>(
            create: (context) => WatchlistDetailsBloc()..add(WatchlistDetailsInitialEvent(context)),
            child: const WatchlistDetailsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<WatchlistDetailsBloc>(
      //     create: (context) => WatchlistDetailsBloc()..add(WatchlistDetailsInitialEvent(context)),
      //     child: const WatchlistDetailsScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case orionPage:
        builder = (context) {
          return BlocProvider<OrionBloc>(
            create: (context) => OrionBloc()..add(const OrionInitialEvent()),
            child: const OrionScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<OrionBloc>(context).add(const OrionInitialEvent());
      //     return const OrionScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case manufacturerOrderListingPage:
        builder = (context) {
          return BlocProvider<ManufacturerOrderListingBloc>(
            create: (context) => ManufacturerOrderListingBloc()..add(const InitialManufacturerOrderListingEvent()),
            child: const ManufacturerOrderListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<ManufacturerOrderListingBloc>(context).add(const InitialManufacturerOrderListingEvent());
      //     return const ManufacturerOrderListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case myOrderTypeSelectionPage:
        builder = (context) => const MyOrderTypeSelection();
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => const MyOrderTypeSelection(),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case retailerOrderListingPage:
        builder = (context) {
          return BlocProvider<RetailerOrderListingBloc>(
            create: (context) => RetailerOrderListingBloc()..add(RetailerOrderListingInitialEvent(context: context)),
            child: const RetailerOrderListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<RetailerOrderListingBloc>(context).add(RetailerOrderListingInitialEvent(context: context));
      //     return const RetailerOrderListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case manufacturerOrderDetailsPage:
        builder = (context) {
          return BlocProvider<ManufacturerOrderDetailsBloc>(
            create: (context) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
            child: const ManufacturerOrderDetailsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ManufacturerOrderDetailsBloc>(
      //     create: (_) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
      //     child: const ManufacturerOrderDetailsScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case newsletterPage:
        builder = (context) {
          return BlocProvider<NewsletterBloc>(
            create: (context) => NewsletterBloc()..add(NewsletterInitialEvent(context: context)),
            child: const NewsletterScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<NewsletterBloc>(context).add(NewsletterInitialEvent(context: context));
      //     return const NewsletterScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case userMasterListingPage:
        builder = (context) {
          return BlocProvider<UserMasterListingBloc>(
            create: (context) => UserMasterListingBloc()..add(const InitialUserMasterListingEvent()),
            child: const UserMasterListingScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<UserMasterListingBloc>(context).add(const InitialUserMasterListingEvent());
      //     return const UserMasterListingScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case messagesPage:
        builder = (context) {
          return BlocProvider<MessagesBloc>(
            create: (context) => MessagesBloc()..add(MessagesInitialEvent(context: context)),
            child: const MessagesScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MessagesBloc>(
      //     create: (_) => MessagesBloc()..add(MessagesInitialEvent(context: context)),
      //     child: const MessagesScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case calendarPage:
        builder = (context) {
          return BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc()..add(InitialCalendarEvent(context)),
            child: const CalendarScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<CalendarBloc>(
      //     create: (_) => CalendarBloc()..add(InitialCalendarEvent(context)),
      //     child: const CalendarScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case messagesDetailPage:
        builder = (context) {
          return BlocProvider<MessageDetailBloc>(
            create: (context) => MessageDetailBloc()..add(MessageDetailInitialEvent(context: context)),
            child: const MessageDetailScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MessageDetailBloc>(
      //     create: (_) => MessageDetailBloc()..add(MessageDetailInitialEvent(context: context)),
      //     child: const MessageDetailScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      //   settings: settings,
      // );

      case exhibitionDetailsPage:
        builder = (context) {
          return BlocProvider<ExhibitionDetailsBloc>(
            create: (context) => ExhibitionDetailsBloc()..add(const ExhibitionDetailsInitialEvent()),
            child: const ExhibitionDetailsScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ExhibitionDetailsBloc>(
      //     create: (_) => ExhibitionDetailsBloc()..add(const ExhibitionDetailsInitialEvent()),
      //     child: const ExhibitionDetailsScreen(),
      //   ),
      //   transitionsBuilder: commonTransitionBuilder,
      // );

      case presentationPage:
        builder = (context) {
          return BlocProvider<PresentationBloc>(
            create: (context) => PresentationBloc()..add(const InitialPresentationEvent()),
            child: const PresentationScreen(),
          );
        };
        break;
      // return PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) {
      //     BlocProvider.of<PresentationBloc>(context).add(const InitialPresentationEvent());
      //     return const PresentationScreen();
      //   },
      //   transitionsBuilder: commonTransitionBuilder,
      // );

      case imageSearchPage:
        builder = (context) {
          return BlocProvider<ImageSearchBloc>(
            create: (context) => ImageSearchBloc()..add(ImageSearchInitialEvent()),
            child: const ImageSearchScreen(),
          );
        };
        break;
      // return MaterialPageRoute(
      //   builder: (context) {
      //     return BlocProvider<ImageSearchBloc>(
      //       create: (_) => ImageSearchBloc()..add(ImageSearchInitialEvent()),
      //       child: const ImageSearchScreen(),
      //     );
      //   },
      //   settings: settings,
      // );

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
  addressId,
  isShippingAddress,
  isFromCheckout,
  presentationId,
  catalogueData,
  watchlistId,
  messageModel,
  conceptId,
  diamondInfo,
  isWatchlistCreated,
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
