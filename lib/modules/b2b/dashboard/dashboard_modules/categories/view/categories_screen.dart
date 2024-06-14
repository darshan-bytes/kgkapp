import 'package:kgk/kgk.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones});
                },
                child: const SmartText('GemStone')),
          ),
        ),
      ),
    );
  }
}
