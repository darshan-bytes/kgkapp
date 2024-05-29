import 'package:kgk/kgk.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;

  const OrderConfirmationScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).orderConfirmationStyle;
    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: kToolbarHeight,
        onFilter: () {},
        onFavorite: () {},
        onNotification: () {},
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmartText(
                  APPStrings.thankYouForYourPurchase.tr,
                  style: style.titleTextStyle,
                ),
                const SizedBox(height: 24),
                _buildYourOrderSummary(style),
                const SizedBox(height: 8),
                SmartText(
                  APPStrings.orderConfirmWithTrackInfo.tr,
                  style: style.descriptionStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildContinueShoppingButton(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildYourOrderSummary(OrderConfirmationStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmartText(
          APPStrings.yourOrderNumber.tr,
          style: style.subTitleStyle,
        ),
        SmartText(
          orderNumber,
          style: style.orderNumberStyle,
        ),
      ],
    );
  }

  Widget _buildContinueShoppingButton() {
    return SmartButton(
      onTap: () {},
      title: APPStrings.continueShopping.tr,
    );
  }
}
