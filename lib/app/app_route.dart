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
  static const ringDetailPage = '/ringDetailPage';
  static const diamondListingPage = '/diamondListingPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: initialRoute),
        );

      case getReadyPage:
        return MaterialPageRoute(
          builder: (_) => const GetReadyScreen(),
          settings: const RouteSettings(name: getReadyPage),
        );

      case signInPage:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: const RouteSettings(name: signInPage),
        );

      case signUpPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<SignUpBloc>(context).add(const SignUpResetEvent());
            return const SignUpScreen();
          },
          settings: const RouteSettings(name: signUpPage),
        );
      case categoriesPage:
        return MaterialPageRoute(
          builder: (_) => const CategoriesScreen(),
          settings: const RouteSettings(name: categoriesPage),
        );

      case dashboardPage:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: const RouteSettings(name: dashboardPage),
        );

      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: const RouteSettings(name: forgotPasswordPage),
        );

      case resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
          settings: const RouteSettings(name: resetPasswordPage),
        );

      case emailSentPage:
        return MaterialPageRoute(
          builder: (_) => const ForgotEmailSentScreen(),
          settings: const RouteSettings(name: emailSentPage),
        );

      case notificationPage:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
          settings: const RouteSettings(name: notificationPage),
        );

      case collectionPage:
        return MaterialPageRoute(
          builder: (_) => const CollectionScreen(),
          settings: const RouteSettings(name: collectionPage),
        );

      case productListGridPage:
        return MaterialPageRoute(
          builder: (_) => const ProductListGridScreen(),
          settings: const RouteSettings(name: productListGridPage),
        );

      case diamondDetailPage:
        return MaterialPageRoute(builder: (_) => const DiamondDetailScreen(), settings: const RouteSettings(name: diamondDetailPage));

      case ringDetailPage:
        return MaterialPageRoute(builder: (_) => const RingDetailScreen(), settings: const RouteSettings(name: ringDetailPage));

      case diamondListingPage:
        return MaterialPageRoute(
          builder: (context) {
            BlocProvider.of<DiamondListingBloc>(context).add(const GetDiamondProductListEvent());
            return const DiamondListingScreen();
          },
          settings: const RouteSettings(name: diamondListingPage),
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
