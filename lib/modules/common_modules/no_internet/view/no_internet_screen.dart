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
          height: context.height,
          width: context.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("No Internet Connection")],
          ),
        ),
      ),
    );
  }
}
