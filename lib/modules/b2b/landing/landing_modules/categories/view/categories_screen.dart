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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => const ConceptInfoPopupScreen(
                      imageList: [
                        "https://i.ibb.co/Bq1jYmy/Rectangle-1862.png",
                        "https://i.ibb.co/MV2wMVZ/Rectangle-1863.png",
                        "https://i.ibb.co/Z8KQJqp/Rectangle-1864.png",
                        "https://i.ibb.co/Bq1jYmy/Rectangle-1862.png",
                        "https://i.ibb.co/MV2wMVZ/Rectangle-1863.png",
                        "https://i.ibb.co/Z8KQJqp/Rectangle-1864.png",
                      ],
                      conceptNo: '14567',
                      conceptDesc:
                          'A jewellery collection inspired by the moon\'s allure. Rings, necklaces, and earrings that capture its luminous beauty.',
                    ),
                  );
                },
                child: const SmartText('Concept info popup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
