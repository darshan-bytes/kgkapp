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
            context.pushNamed(AppRoutes.diamondListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondListingForDIY});
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
      ]),
    );
  }
}
