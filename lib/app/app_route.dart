import 'package:kgk/kgk.dart';

class AppRoutes {
  static const initialRoute = '/';
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
          pageBuilder: (context, animation, secondaryAnimation) => const SignUpScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case categoriesPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CategoriesScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case landingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LandingScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case forgotPasswordPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ForgotPasswordScreen(),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case resetPasswordPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ResetPasswordScreen(),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AddAddressBloc>(
            create: (context) => AddAddressBloc()..add(AddAddressInitialEvent(context)),
            child: const AddAddressScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case addressListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AddressListBloc>(
            create: (context) => AddressListBloc()..add(const LoadAddressListEvent()),
            child: const AddressListScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case wishListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<WishlistBloc>(
            create: (context) => WishlistBloc()..add(const InitialWishlistEvent()),
            child: const WishlistScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AuctionBloc>(
            create: (context) => AuctionBloc()..add(AuctionInitialEvent(context: context)),
            child: const AuctionScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case writeReviewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<WriteReviewBloc>(
            create: (context) => WriteReviewBloc()..add(const WriteReviewInitialEvent()),
            child: const WriteReviewScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrdersBloc>(
            create: (context) => OrdersBloc()..add(OrdersInitialEvent(context)),
            child: const OrderScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MakeInquiryBloc>(
            create: (context) => MakeInquiryBloc()..add(MakeInquiryInitialEvent()),
            child: const MakeInquiryScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case searchPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(),
            child: const SearchScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<FaqBloc>(
            create: (context) => FaqBloc()..add(const FaqInitialEvent()),
            child: const FaqScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case preferencesPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PreferencesBloc>(
            create: (context) => PreferencesBloc(),
            child: const PreferencesScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ContactUsBloc>(
            create: (context) => ContactUsBloc()..add(ContactUsInitialEvent()),
            child: const ContactUsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case dashboardPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc()..add(const DashboardInitialEvent()),
            child: const DashboardScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<MonitoringBloc>(
            create: (context) => MonitoringBloc()..add(MonitoringInitialEvent()),
            child: const MonitoringScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case savedAddressPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<SavedAddressBloc>(
            create: (context) => SavedAddressBloc()..add(const SavedAddressInitialEvent()),
            child: const SavedAddressScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case shippingAddressPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ShippingAddressBloc>(
            create: (context) => ShippingAddressBloc()..add(ShippingAddressInitialEvent(context)),
            child: const ShippingAddressScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case projectListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ProjectListingBloc>(
            create: (context) => ProjectListingBloc()..add(InitialProjectListingEvent(context: context)),
            child: const ProjectListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designBriefsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DesignBriefsBloc>(
            create: (context) => DesignBriefsBloc()..add(InitialDesignBriefsEvent(context: context)),
            child: const DesignBriefsScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DesignListingBloc>(
            create: (context) => DesignListingBloc()..add(InitialDesignListingEvent(context: context)),
            child: const DesignListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case stylesListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<StylesListingBloc>(
            create: (context) => StylesListingBloc()..add(const StylesListingInitialEvent()),
            child: const StylesListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case digitalCataloguePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DigitalCatalogueBloc>(
            create: (context) => DigitalCatalogueBloc()..add(const DigitalCatalogueInitialEvent()),
            child: const DigitalCatalogueListingScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<FindStoreBloc>(
            create: (_) => FindStoreBloc()..add(FindStoreInitialEvent()),
            child: const FindStoreScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<CadLibraryListingBloc>(
            create: (_) => CadLibraryListingBloc()..add(InitialCadListingEvent(context: context)),
            child: const CadLibraryListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case designLibraryFeedbackPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DesignLibraryFeedbackBloc>(
            create: (_) => DesignLibraryFeedbackBloc()..add(InitialDesignLibraryFeedbackEvent()),
            child: const DesignLibraryFeedbackScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case watchListPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<WatchlistBloc>(
            create: (_) => WatchlistBloc()..add(WatchlistInitialEvent()),
            child: const WatchlistScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case allReviewPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<AllReviewBloc>(
            create: (_) => AllReviewBloc()..add(AllReviewInitialEvent(context)),
            child: const AllReviewScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case exhibitionListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ExhibitionListingBloc>(
            create: (_) => ExhibitionListingBloc()..add(InitialExhibitionListingEvent(context: context)),
            child: const ExhibitionListingScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
        );

      case stonesLandingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<StonesLandingBloc>(
            create: (_) => StonesLandingBloc()..add(InitialStonesLandingEvent(context: context)),
            child: const StonesLandingScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<DesignLibraryBloc>(
            create: (_) => DesignLibraryBloc()..add(const DesignLibraryInitialEvent()),
            child: const DesignLibraryScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case activityLogScreenPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ActivityLogBloc>(
            create: (_) => ActivityLogBloc()..add(ActivityLogInitialEvent()),
            child: const ActivityLogScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<OrionBloc>(
            create: (_) => OrionBloc()..add(const OrionInitialEvent()),
            child: const OrionScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case manufacturerOrderListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<ManufacturerOrderListingBloc>(
            create: (_) => ManufacturerOrderListingBloc()..add(const InitialManufacturerOrderListingEvent()),
            child: const ManufacturerOrderListingScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<RetailerOrderListingBloc>(
            create: (_) => RetailerOrderListingBloc()..add(RetailerOrderListingInitialEvent(context: context)),
            child: const RetailerOrderListingScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<NewsletterBloc>(
            create: (_) => NewsletterBloc()..add(NewsletterInitialEvent(context: context)),
            child: const NewsletterScreen(),
          ),
          transitionsBuilder: commonTransitionBuilder,
          settings: settings,
        );

      case userMasterListingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<UserMasterListingBloc>(
            create: (_) => UserMasterListingBloc()..add(const InitialUserMasterListingEvent()),
            child: const UserMasterListingScreen(),
          ),
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
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<PresentationBloc>(
            create: (_) => PresentationBloc()..add(const InitialPresentationEvent()),
            child: const PresentationScreen(),
          ),
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
