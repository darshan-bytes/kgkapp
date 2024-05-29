import 'package:kgk/kgk.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const getReadyPage = '/getReadyPage';
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const categoriesPage = '/categoriesPage';
  static const dashboardPage = '/tabBarPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const resetPasswordPage = '/resetPasswordPage';
  static const emailSentPage = '/emailSentPage';
  static const notificationPage = '/notificationPage';
  static const collectionPage = '/collectionPage';
  static const productListGridPage = '/productListGridPage';
  static const diamondDetailPage = '/diamondDetailPage';
  static const settingDetailPage = '/settingDetailPage';
  static const diamondListingPage = '/diamondListingPage';
  static const settingListingPage = '/settingListingPage';
  static const completeProductPage = '/completeProductPage';
  static const productDetailsPage = '/productDetailsPage';
  static const addAccountPage = '/addAccountPage';
  static const wishListPage = '/wishListPage';
  static const compareProductPage = '/compareProductPage';

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
          builder: (_) => const CategoriesScreen(),
          settings: const RouteSettings(name: categoriesPage),
        );

      case dashboardPage:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );

      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
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
            BlocProvider.of<ProductListBloc>(context).add(InitialProductListEvent(context));
            return const ProductListScreen();
          },
          settings: settings,
        );

      case diamondDetailPage:
        return MaterialPageRoute(
          builder: (_) => const DiamondDetailScreen(),
          settings: settings,
        );

      case settingDetailPage:
        return MaterialPageRoute(
          builder: (_) => const SettingDetailScreen(),
          settings: settings,
        );

      case diamondListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<DiamondListingBloc>(context).add(const GetDiamondProductListEvent());
            return const DiamondListingScreen();
          },
          settings: settings,
        );

      case settingListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<SettingListingBloc>(context).add(const GetSettingProductListEvent());
            return const SettingListingScreen();
          },
          settings: settings,
        );

      case completeProductPage:
        return MaterialPageRoute(
          builder: (_) => const CompleteProductScreen(),
          settings: settings,
        );

      case addAccountPage:
        return MaterialPageRoute(
          builder: (_) => const AddAccountScreen(),
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

      case productDetailsPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProductDetailsBloc>(
            create: (_) => ProductDetailsBloc()..add(LoadProductDetailsEvent(context)),
            lazy: false,
            child: const ProductDetailsScreen(),
          ),
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

  Future<dynamic> pop({Map<RoutesData, dynamic>? arguments}) async {
    return Navigator.pop(this, arguments);
  }
}
