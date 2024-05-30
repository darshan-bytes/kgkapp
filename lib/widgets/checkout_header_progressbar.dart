import 'package:kgk/kgk.dart';

class CheckoutHeaderProgressbar extends StatelessWidget {
  final bool isShippingAndBillingAddressFilled;

  const CheckoutHeaderProgressbar({super.key, this.isShippingAndBillingAddressFilled = false});

  @override
  Widget build(BuildContext context) {
    final AddAddressScreenStyle style = AppTheme.of(context).addAddressScreenStyle;
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
              dotColor: isShippingAndBillingAddressFilled ? style.fillLineColor : style.dotColor,
            ),
          ),
          Container(
            height: 6,
            width: 6,
            decoration:
                BoxDecoration(color: isShippingAndBillingAddressFilled ? style.filledDotColor : style.dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          SmartText(APPStrings.payment.tr,
              style: isShippingAndBillingAddressFilled ? style.shippingBillingAddressStyle : style.paymentStyle),
        ],
      ),
    );
  }
}
