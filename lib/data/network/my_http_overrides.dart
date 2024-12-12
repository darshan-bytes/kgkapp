import 'package:kgk/kgk.dart';

///[MyHttpOverrides] is used to handle image loading error in the android platform because of the certificate issue.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
