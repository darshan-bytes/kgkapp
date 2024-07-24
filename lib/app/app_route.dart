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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case initialRoute:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
            transitionsBuilder: commonTransitionBuilder,
            settings: settings);

      case signInPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
          transitionsBuilder: commonTransitionBuilder,
        );

      case signUpPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<SignUpBloc>(context).add(SignUpInitialEvent(context));
            return const SignUpScreen();
          },
          settings: settings,
        );
      case categoriesPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<CategoriesBloc>(context).add(CategoriesInitialEvent(context: context));
            return const CategoriesScreen();
          },
          settings: settings,
        );

      case landingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<LandingBloc>(context).add(LandingInitialEvent(context: context));
            return const LandingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case forgotPasswordPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ForgotPasswordScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case emailSentPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ForgotEmailSentScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case notificationPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const NotificationScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case collectionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CollectionScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case productListGridPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider<ProductListBloc>(
              create: (context) => ProductListBloc()..add(InitialProductListEvent(context)),
              child: const ProductListScreen(),
            );
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case stoneDetailPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider<StoneDetailBloc>(
              create: (context) => StoneDetailBloc()..add(StoneDetailInitialEvent(context: context)),
              child: const StoneDetailScreen(),
            );
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case settingDetailPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SettingDetailScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case stoneListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider<StoneListingBloc>(
              create: (context) => StoneListingBloc()..add(GetStoneProductListEvent(context)),
              child: const StoneListingScreen(),
            );
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case settingListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SettingListingBloc>(
            create: (context) => SettingListingBloc()..add(GetSettingProductListEvent(context)),
            child: const SettingListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case completeProductPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CompleteProductScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case addAddressPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<AddAddressBloc>(context).add(AddAddressInitialEvent(context));
            return const AddAddressScreen();
          },
          settings: settings,
        );

      case addressListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<AddressListBloc>(context).add(const LoadAddressListEvent());
            return const AddressListScreen();
          },
          settings: settings,
        );

      case wishListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<WishlistBloc>(context).add(const InitialWishlistEvent());
            return const WishlistScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case compareProductPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CompareProductScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case paymentPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const PaymentScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case productDetailsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ProductDetailsBloc>(
            create: (_) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
            child: const ProductDetailsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case diamondInfoPopupPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DiamondInfoPopupScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case productMenuBottomSheet:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ProductMenuBottomSheet(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case auctionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<AuctionBloc>(context).add(AuctionInitialEvent(context: context));
            return const AuctionScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case writeReviewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<WriteReviewBloc>(context).add(const WriteReviewInitialEvent());
            return const WriteReviewScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orderConfirmationPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OrderConfirmationScreen(
            orderNumber: context.routesData?[RoutesData.orderNumber] ?? '',
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orderPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<OrdersBloc>(context).add(OrdersInitialEvent(context));
            return const OrderScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orderDetailsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrderDetailBloc>(
            create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
            child: const OrderDetailScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case auctionListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AuctionListingBloc>(
            create: (_) => AuctionListingBloc()..add(const InitialAuctionListingEvent()),
            child: const AuctionListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orderTimelinePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrderTimelineBloc>(
            create: (_) => OrderTimelineBloc()..add(InitialOrderTimelineEvent(context)),
            child: const OrderTimelineScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case makeInquiryPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<MakeInquiryBloc>(context).add(MakeInquiryInitialEvent());
            return const MakeInquiryScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case searchPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<SearchBloc>(context).add(InitialSearchEvent());
            return const SearchScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case qrScannerPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<QrCodeScanLoginBloc>(
            create: (context) => QrCodeScanLoginBloc(),
            child: const QrScannerScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case searchResultPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SearchResultBloc>(
            create: (context) => SearchResultBloc()..add(InitialSearchResultEvent(context: context)),
            child: const SearchResultScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case notificationSettingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<NotificationSettingsBloc>(
            create: (context) => NotificationSettingsBloc(),
            child: const NotificationSettingsView(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case cmsWebViewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<CmsWebViewBloc>(
            create: (context) => CmsWebViewBloc()..add(CmsWebViewInitialEvent(context: context)),
            child: const CmsWebViewScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case faqPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<FaqBloc>(context).add(const FaqInitialEvent());
            return const FaqScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case preferencesPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<PreferencesBloc>(context).add(PreferencesInitialEvent());
            return const PreferencesScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case userTypeSelection:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const UserTypeSelection(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case contactUsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ContactUsBloc>(context).add(ContactUsInitialEvent());
            return const ContactUsScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case dashboardPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DashboardBloc>(context).add(const DashboardInitialEvent());
            return const DashboardScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case pddListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddListingBloc>(
            create: (context) => PddListingBloc()..add(InitialPddListingEvent(context: context)),
            child: const PddListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case conceptListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ConceptListBloc>(
            create: (context) => ConceptListBloc()..add(const ConceptListInitialEvent()),
            child: const ConceptListScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case monitoringPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<MonitoringBloc>(context).add(MonitoringInitialEvent());
            return const MonitoringScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case savedAddressPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<SavedAddressBloc>(context).add(const SavedAddressInitialEvent());
            return const SavedAddressScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case shippingAddressPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ShippingAddressBloc>(context).add(ShippingAddressInitialEvent(context));
            return const ShippingAddressScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case projectListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ProjectListingBloc>(context).add(InitialProjectListingEvent(context: context));
            return const ProjectListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designBriefsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DesignBriefsBloc>(context).add(InitialDesignBriefsEvent(context: context));
            return const DesignBriefsScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DesignListingBloc>(context).add(InitialDesignListingEvent(context: context));
            return const DesignListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case stylesListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<StylesListingBloc>(context).add(const StylesListingInitialEvent());
            return const StylesListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case digitalCataloguePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DigitalCatalogueBloc>(context).add(const DigitalCatalogueInitialEvent());
            return const DigitalCatalogueListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case presentationPreviewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddPreviewBloc>(
            create: (_) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case findStorePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<FindStoreBloc>(context).add(FindStoreInitialEvent());
            return const FindStoreScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case presentationPreviewHistory:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PddPreviewBloc>(
            create: (_) => PddPreviewBloc()..add(InitialPddPreviewEvent(context: context)),
            child: const PddPreviewHistoryScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case cadLibraryListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<CadLibraryListingBloc>(context).add(InitialCadListingEvent(context: context));
            return const CadLibraryListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designLibraryFeedbackPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DesignLibraryFeedbackBloc>(context).add(InitialDesignLibraryFeedbackEvent());
            return const DesignLibraryFeedbackScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case watchListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<WatchlistBloc>(context).add(WatchlistInitialEvent());
            return const WatchlistScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case allReviewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<AllReviewBloc>(context).add(AllReviewInitialEvent(context));
            return const AllReviewScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case exhibitionListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ExhibitionListingBloc>(context).add(InitialExhibitionListingEvent(context: context));
            return const ExhibitionListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
        );

      case stonesLandingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<StonesLandingBloc>(context).add(InitialStonesLandingEvent(context: context));
            return const StonesLandingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case previewCataloguePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PreviewCatalogueBloc>(
            create: (context) => PreviewCatalogueBloc()..add(InitialPreviewCatalogueEvent(context)),
            child: const PreviewCatalogueScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designLibraryScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<DesignLibraryBloc>(context).add(const DesignLibraryInitialEvent());
            return const DesignLibraryScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case activityLogScreenPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ActivityLogBloc>(context).add(ActivityLogInitialEvent());
            return const ActivityLogScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case watchlistDetailsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<WatchlistDetailsBloc>(
            create: (context) => WatchlistDetailsBloc()..add(WatchlistDetailsInitialEvent(context)),
            child: const WatchlistDetailsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case orionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<OrionBloc>(context).add(const OrionInitialEvent());
            return const OrionScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case manufacturerOrderListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<ManufacturerOrderListingBloc>(context).add(const InitialManufacturerOrderListingEvent());
            return const ManufacturerOrderListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case myOrderTypeSelectionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MyOrderTypeSelection(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case retailerOrderListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<RetailerOrderListingBloc>(context).add(RetailerOrderListingInitialEvent(context: context));
            return const RetailerOrderListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case manufacturerOrderDetailsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ManufacturerOrderDetailsBloc>(
            create: (_) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
            child: const ManufacturerOrderDetailsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case newsletterPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<NewsletterBloc>(context).add(NewsletterInitialEvent(context: context));
            return const NewsletterScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case userMasterListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<UserMasterListingBloc>(context).add(const InitialUserMasterListingEvent());
            return const UserMasterListingScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case messagesPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MessagesBloc>(
            create: (_) => MessagesBloc()..add(MessagesInitialEvent(context: context)),
            child: const MessagesScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case calendarPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<CalendarBloc>(
            create: (_) => CalendarBloc()..add(InitialCalendarEvent(context)),
            child: const CalendarScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case messagesDetailPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MessageDetailBloc>(
            create: (_) => MessageDetailBloc()..add(MessageDetailInitialEvent(context: context)),
            child: const MessageDetailScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case exhibitionDetailsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ExhibitionDetailsBloc>(
            create: (_) => ExhibitionDetailsBloc()..add(const ExhibitionDetailsInitialEvent()),
            child: const ExhibitionDetailsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
        );

      case presentationPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            BlocProvider.of<PresentationBloc>(context).add(const InitialPresentationEvent());
            return const PresentationScreen();
          },
          transitionsBuilder: commonTransitionBuilder,
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
  conceptId
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
