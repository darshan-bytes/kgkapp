import 'package:kgk/kgk.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.compareProductPage);
          },
          child: const Text('View All Compare Product')),
    );
  }
}
