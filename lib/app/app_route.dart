import 'package:kgk/kgk.dart';
import 'package:kgk/modules/forgot_password/view/forgot_password_screen.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const signInPage = '/signInPage';
  static const categoriesPage = '/categoriesPage';
  static const dashboardPage = '/tabBarPage';
  static const forgotPasswordPage = '/forgotPasswordPage';

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
