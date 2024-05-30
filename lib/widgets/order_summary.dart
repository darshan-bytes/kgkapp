import 'package:kgk/kgk.dart';

class OrderSummary extends StatelessWidget {
  final String? title;
  final List<OrderSummaryItem> items;
  final String totalPrice;
  final void Function()? onTapCheckout;
  final bool isPromoCodeApplied;
  final TextStyle? titleStyle;

  const OrderSummary({
    this.title,
    super.key,
    required this.items,
    required this.totalPrice,
    this.onTapCheckout,
    this.isPromoCodeApplied = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).orderSummaryStyle;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 24),
      color: style.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartText(
            title ?? APPStrings.orderSummary.tr,
            style: titleStyle == null ? style.orderSummaryTitleStyle : style.orderSummaryTitleStyle.merge(titleStyle),
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildOrderSummaryItem(item, style);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
          const SizedBox(height: 16),
          if (isPromoCodeApplied) ...[
            const Divider(height: 1),
            _buildPromoCodeSection(style),
            const Divider(height: 1),
          ],
          const SizedBox(height: 16),
          _buildTotalSection(style),
          if (onTapCheckout != null) ...[
            const SizedBox(height: 24),
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
        const SizedBox(width: 17),
        SmartText(item.value, style: style.orderSummaryItemStyle),
      ],
    );
  }

  Widget _buildPromoCodeSection(style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(child: SmartText(APPStrings.addPromoCode.tr, style: style.addPromoCodeStyle)),
          const SizedBox(width: 17),
          const SmartImage(path: AppImages.icPlus),
        ],
      ),
    );
  }

  Widget _buildTotalSection(OrderSummaryStyle style) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
              child: SmartText(
            APPStrings.total.tr,
            style: style.orderSummaryItemStyle,
          )),
          const SizedBox(width: 17),
          SmartText(
            totalPrice,
            style: style.totalPriceStyle,
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
