import 'package:kgk/kgk.dart';

class PddListingScreen extends StatelessWidget {
  const PddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.w,
          ),
          B2BListingItem(
            type: B2BListingType.conceptListingType,
            listingItemModel: B2BCustomListingDataModel(
              conceptNumber: '123',
              conceptName: 'Concept Name',
              presentation: '2',
              status: OrderStatus.inProgress,
              assignToImageUrl: '',
              market: 'Market',
              marketFlagImageUrl: '',
              createdBy: 'Created By',
            ),
          ),
        ],
      ),
    );
  }
}
