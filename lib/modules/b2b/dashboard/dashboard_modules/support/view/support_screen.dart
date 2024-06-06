import 'package:kgk/kgk.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SmartText(
            //   'diamond filter',
            //   onTap: () {
            //     showModalBottomSheet(
            //       context: context,
            //       isScrollControlled: true,
            //       useSafeArea: true,
            //       builder: (context) => DiamondFilterScreen(
            //         onApply: () {},
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
