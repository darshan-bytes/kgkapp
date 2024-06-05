import 'package:kgk/kgk.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;

  const OrderConfirmationScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).orderConfirmationStyle;
    return Scaffold(
      appBar: SmartAppBar(
        isBack: false,
        leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
        onFilter: () {},
        onFavorite: () {},
        onNotification: () {},
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(17.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmartText(
                  APPStrings.thankYouForYourPurchase.tr,
                  style: style.titleTextStyle,
                ),
                SizedBox(height: 24.h),
                _buildYourOrderSummary(style),
                SizedBox(height: 8.h),
                SmartText(
                  APPStrings.orderConfirmWithTrackInfo.tr,
                  style: style.descriptionStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
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
