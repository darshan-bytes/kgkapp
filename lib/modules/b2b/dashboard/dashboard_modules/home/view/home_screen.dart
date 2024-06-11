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
        const SizedBox(
          height: 20,
        ),
        SmartText(
          'DIY',
          onTap: () {
            context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDIY});
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SmartText(
          'Auction',
          onTap: () async {
            context.pushNamed(AppRoutes.auctionPage);
          },
        ),
      SmartText(
          'Order Screen',
          onTap: () async {
            context.pushNamed(AppRoutes.orderPage);
          },
          optionalPadding:const EdgeInsets.all(20) ,)
      ]),
    );
  }
}
