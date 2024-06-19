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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones});
                  },
                  child: const SmartText('GemStone')),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.faqPage);
                  },
                  child: const SmartText('FAQ')),
            ],
          ),
        ),
      ),
    );
  }
}
