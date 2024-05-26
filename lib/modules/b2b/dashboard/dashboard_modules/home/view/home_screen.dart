import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.collectionPage);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartButton(
                  onTap: () {
                    context.pushNamed(AppRoutes.addAccountPage);
                  },
                  title: "Add Account"),
              const Text('View All Collection'),
            ],
          )),
    );
  }
}
