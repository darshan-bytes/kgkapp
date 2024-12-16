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
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onNotification: () {
          context.pushNamed(AppRoutes.notificationPage);
        },
      ),
      bottomNavigationBar: SafeArea(child: SizedBox(height: 72.h)),
      body: SafeArea(
          child: Center(
        child: SmartSingleChildScrollView(
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
                _buildContinueShoppingButton(context),
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
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: APPStrings.yourOrderNumber.tr,
              style: style.subTitleStyle,
              children: [
                WidgetSpan(child: SizedBox(width: 4.w)),
                TextSpan(
                  text: orderNumber,
                  style: style.orderNumberStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueShoppingButton(BuildContext context) {
    return SmartButton(
      onTap: () {
        BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
        context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
      },
      title: APPStrings.continueShopping.tr,
    );
  }
}
