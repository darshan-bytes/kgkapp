import 'package:kgk/kgk.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const signInPage = '/signInPage';
  static const categoriesPage = '/categoriesPage';
  static const dashboardPage = '/tabBarPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const resetPasswordPage = '/resetPasswordPage';
  static const emailSentPage = '/emailSentPage';
  static const notificationPage = '/notificationPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    printWrapped('\x1B[32m${'Navigating to ----> ${settings.name}'}\x1B[0m');
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: initialRoute),
        );

      case signInPage:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: const RouteSettings(name: signInPage),
        );

      case categoriesPage:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen(), settings: const RouteSettings(name: categoriesPage));

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
        return MaterialPageRoute(builder: (_) => const NotificationScreen(), settings: const RouteSettings(name: notificationPage));

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
