import 'package:kgk/kgk.dart';

class NoInternetScreen extends StatelessWidget {
  final ThemeData theme;

  const NoInternetScreen({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("No Internet Connection")],
          ),
        ),
      ),
    );
  }
}
