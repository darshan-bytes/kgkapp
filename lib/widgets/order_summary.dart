import 'package:kgk/kgk.dart';

class OrderSummary extends StatelessWidget {
  final String? title;
  final List<OrderSummaryItem> items;
  final String totalPrice;
  final void Function()? onTapCheckout;
  final bool isPromoCodeApplied;
  final TextStyle? titleStyle;
  final TextStyle? totalStyle;

  const OrderSummary({
    this.title,
    super.key,
    required this.items,
    required this.totalPrice,
    this.onTapCheckout,
    this.isPromoCodeApplied = true,
    this.titleStyle,
    this.totalStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).orderSummaryStyle;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
      color: style.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartText(
            title ?? APPStrings.orderSummary.tr,
            style: titleStyle == null ? style.orderSummaryTitleStyle : style.orderSummaryTitleStyle.merge(titleStyle),
          ),
          SizedBox(height: 24.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildOrderSummaryItem(item, style);
            },
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          ),
          SizedBox(height: 16.h),
          if (isPromoCodeApplied) ...[
            const Divider(),
            _buildPromoCodeSection(style),
            const Divider(),
          ],
          SizedBox(height: 16.h),
          _buildTotalSection(style),
          if (onTapCheckout != null) ...[
            SizedBox(height: 24.h),
            SmartButton(onTap: onTapCheckout!, title: APPStrings.checkout.tr),
          ]
        ],
      ),
    );
  }

  Widget _buildOrderSummaryItem(OrderSummaryItem item, style) {
    return Row(
      children: [
        Expanded(
            child: SmartText(
          item.title,
          style: style.orderSummaryItemStyle,
        )),
        SizedBox(width: 17.w),
        SmartText(item.value, style: style.orderSummaryItemStyle),
      ],
    );
  }

  Widget _buildPromoCodeSection(style) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        children: [
          Expanded(child: SmartText(APPStrings.addPromoCode.tr, style: style.addPromoCodeStyle)),
          SizedBox(width: 17.w),
          const SmartImage(path: AppImages.icPlus),
        ],
      ),
    );
  }

  Widget _buildTotalSection(OrderSummaryStyle style) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          Expanded(
              child: SmartText(
            APPStrings.total.tr,
            style: style.orderSummaryItemStyle,
          )),
          SizedBox(width: 17.w),
          SmartText(
            totalPrice,
            style: totalStyle ?? style.totalPriceStyle,
          ),
        ],
      ),
    );
  }
}

class OrderSummaryItem {
  final String title;
  final String value;

  const OrderSummaryItem({
    required this.title,
    required this.value,
  });
}
