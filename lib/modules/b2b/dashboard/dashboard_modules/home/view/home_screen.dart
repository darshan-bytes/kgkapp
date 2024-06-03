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
        SmartText(
          'Diamond info popup screen',
          onTap: () {
            context.pushNamed(AppRoutes.diamondInfoPopupPage);
          },
        ),
        SmartText(
          'Product Menu Bottom Sheet',
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => const ProductMenuBottomSheet(),
            );
          },
        ),
      ]),
    );
  }
}
