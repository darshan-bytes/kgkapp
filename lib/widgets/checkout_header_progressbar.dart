import 'package:kgk/kgk.dart';

class CheckoutHeaderProgressbar extends StatelessWidget {
  final bool isShippingAndBillingAddressFilled;

  const CheckoutHeaderProgressbar({super.key, this.isShippingAndBillingAddressFilled = false});

  @override
  Widget build(BuildContext context) {
    final AddAddressScreenStyle style = AppTheme.of(context).addAddressScreenStyle;
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
              dotColor: isShippingAndBillingAddressFilled ? style.fillLineColor : style.dotColor,
            ),
          ),
          Container(
            height: 6.w,
            width: 6.w,
            decoration:
                BoxDecoration(color: isShippingAndBillingAddressFilled ? style.filledDotColor : style.dotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          SmartText(APPStrings.payment.tr,
              style: isShippingAndBillingAddressFilled ? style.shippingBillingAddressStyle : style.paymentStyle),
        ],
      ),
    );
  }
}
