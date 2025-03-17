import 'package:kgk/kgk.dart';

class MyOrderTypeSelection extends StatelessWidget {
  const MyOrderTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsetsDirectional.all(20.w),
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.orderPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.orderDetailsForMyOrder});
                },
                title: 'Normal Order',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.retailerOrderListingPage,
                      arguments: {RoutesData.isPageFor: ScreenIdentifier.orderDetailsForRetailer});
                },
                title: 'Retailer Order',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
