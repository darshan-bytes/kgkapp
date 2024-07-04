import 'package:kgk/kgk.dart';

class MyOrderTypeSelection extends StatelessWidget {
  const MyOrderTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.orderPage);
                },
                title: 'Normal Order',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.orderPage);
                },
                title: 'Retailer Order',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.manufacturerOrderListingPage);
                },
                title: 'Manufacturer Order',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
