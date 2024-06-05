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
          'Order Confirmation',
          onTap: () {
            context.pushNamed(AppRoutes.orderConfirmationPage,
                arguments: {RoutesData.orderNumber: "3000000049"});
          },
        ),
        SmartText(
          'Diamond info popup screen',
          onTap: () {
            context.pushNamed(AppRoutes.diamondInfoPopupPage);
          },
        ),
        SmartText(
          'Write a review screen',
          onTap: () {
            context.pushNamed(AppRoutes.writeReviewPage);
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
        SmartText(
          'auction',
          onTap: () async {
            context.pushNamed(AppRoutes.auctionPage);
          },
        ),
        SmartText(
          'Full Diamond Details',
          onTap: () async {
            context.pushNamed(AppRoutes.productDetailsPage, arguments: {
              RoutesData.isPageFor: ScreenIdentifier.productDetailForDiamonds
            });
          },
        ),
      ]),
    );
  }
}
