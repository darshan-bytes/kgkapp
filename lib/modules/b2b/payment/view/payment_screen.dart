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
          return SizedBox(
            height: MediaQuery.of(context).size.height,
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
                const Divider(
                  height: 0.5,
                  endIndent: 14,
                  indent: 14,
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
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      SmartText(
                        APPStrings.total.tr,
                        style: style.footerTotalStyle,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SmartText(
                        '\$35,700,00',
                        style: style.footerTotalAmountStyle,
                      ),
                      const Spacer(),
                      SmartButton(
                        onTap: () {},
                        title: APPStrings.placeOrder.tr,
                        width: 168,
                      )
                    ],
                  ),
                )
              ],
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
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmartImage(path: imagePath, height: 24, width: 24),
                const SizedBox(
                  width: 10,
                ),
                SmartText(text),
                const Spacer(),
                SmartImage(path: plusIconPath, height: 24, width: 24),
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
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      child: Row(
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: SmartText(
              APPStrings.shippingBillingAddress.tr,
              style: style.shippingBillingAddressStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DotIndicator(
              dotColor: style.fillLineColor,
            ),
          ),
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          SmartText(APPStrings.payment.tr, style: style.shippingBillingAddressStyle),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return OrderSummary(
      title: APPStrings.priceDetails.tr,
      titleStyle: const TextStyle(fontSize: 24),
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
