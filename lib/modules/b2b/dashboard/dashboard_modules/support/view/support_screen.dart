import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/dashboard/dashboard_modules/diamond_filter/view/diamond_filter_screen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmartText(
              'diamond filter',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => DiamondFilterScreen(
                    onApply: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
