import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/order_details/view/track_order_bottomsheet.dart';

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
            // context.pushNamed(AppRoutes.auctionPage);
            Utils.showSmartModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => TrackOrderBottomSheet(),
            );
          },
        ),
      ]),
    );
  }
}
