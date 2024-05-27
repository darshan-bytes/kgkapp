import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.compareProductPage);
          },
          child: const Text('View All Collection')),
    );
  }
}
