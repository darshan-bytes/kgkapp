import 'package:kgk/kgk.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmartText(
        'My Bag',
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
      ),
    );
  }
}
