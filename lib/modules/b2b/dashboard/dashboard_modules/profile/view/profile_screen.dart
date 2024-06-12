import 'package:kgk/kgk.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.compareProductPage);
                },
                child: const Text('View All Compare Product')),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.paymentPage);
                },
                child: const Text('Payment Screen')),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutes.orderPage);
              },
              child: const Text('Order Screen'),
            ),
            const SizedBox(
              height: 10,
            ),
            SmartText(
              'Auction List Screen',
              onTap: () async {
                context.pushNamed(AppRoutes.auctionListingPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
