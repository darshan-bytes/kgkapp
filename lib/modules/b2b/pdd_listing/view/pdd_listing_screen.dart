import 'package:kgk/kgk.dart';

class PddListingScreen extends StatelessWidget {
  const PddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 100.w,
            ),
            B2BListingItem(
              type: B2BListingType.conceptListingType,
              onTapMenuButton: () {},
              listingItemModel: B2BCustomListingDataModel(
                strConceptNumber: '123',
                strConceptName: 'Concept Name',
                strPresentation: '2',
                status: OrderStatus.inProgress,
                strAssignToImageUrl: '',
                strMarket: 'Market',
                strMarketFlagImageUrl: '',
                strCreatedBy: 'Created By',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
