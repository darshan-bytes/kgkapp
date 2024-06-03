import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SmartText(
          'View All Collection',
          onTap: () {
            context.pushNamed(AppRoutes.collectionPage);
          },
        ),
      ]),
    );
  }
}
