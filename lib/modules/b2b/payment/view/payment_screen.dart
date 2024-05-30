import 'package:kgk/kgk.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaymentBloc>(context);
    final style = AppTheme.of(context).paymentStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.checkout.tr),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return SafeArea(
            child: SizedBox(
              height: context.height,
              child: Column(
                children: [
                  _buildShippingBillingAddress(bloc, style),
                  _paymentOption(
                    onTap: () {},
                    imagePath: AppImages.icPaypal,
                    text: APPStrings.paypal.tr,
                    plusIconPath: AppImages.icPlus,
                    context: context,
                  ),
                  Divider(
                    height: 0.5.h,
                    endIndent: 14.w,
                    indent: 14.w,
                  ),
                  _paymentOption(
                    onTap: () {},
                    imagePath: AppImages.icUpi,
                    text: APPStrings.upi.tr,
                    plusIconPath: AppImages.icPlus,
                    context: context,
                  ),
                  const Spacer(),
                  _buildOrderSummary(),
                  Container(
                    height: 80.h,
                    margin: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        SmartText(
                          APPStrings.total.tr,
                          style: style.footerTotalStyle,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        SmartText(
                          '\$35,700,00',
                          style: style.footerTotalAmountStyle,
                        ),
                        const Spacer(),
                        SmartButton(
                          onTap: () {},
                          title: APPStrings.placeOrder.tr,
                          width: 168.w,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _paymentOption({
    required VoidCallback onTap,
    required String imagePath,
    required String text,
    required String plusIconPath,
    required BuildContext context,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 48.h,
            margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmartImage(path: imagePath, height: 24.w, width: 24.w),
                SizedBox(
                  width: 10.w,
                ),
                SmartText(text),
                const Spacer(),
                SmartImage(path: plusIconPath, height: 24.w, width: 24.w),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShippingBillingAddress(PaymentBloc bloc, PaymentStyle style) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: style.borderColor))),
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            height: 6.w,
            width: 6.w,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: SmartText(
              APPStrings.shippingBillingAddress.tr,
              style: style.shippingBillingAddressStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: DotIndicator(
              dotColor: style.fillLineColor,
            ),
          ),
          Container(
            height: 6.w,
            width: 6.w,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          SmartText(APPStrings.payment.tr, style: style.shippingBillingAddressStyle),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return OrderSummary(
      title: APPStrings.priceDetails.tr,
      titleStyle: TextStyle(fontSize: 24.sp),
      isPromoCodeApplied: false,
      items: [
        // Here String come from API
        OrderSummaryItem(title: APPStrings.subtotal.tr, value: "\$11,950.00"),
        OrderSummaryItem(title: APPStrings.shipping.tr, value: "\$0.00"),
        OrderSummaryItem(title: APPStrings.salesTax.tr, value: "\$0.00"),
      ],
      totalPrice: "\$35,700.00",
    );
  }
}
