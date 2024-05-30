import 'package:kgk/kgk.dart';

class OrderSummary extends StatelessWidget {
  final List<OrderSummaryItem> items;
  final String totalPrice;
  final void Function() onTapCheckout;

  const OrderSummary({
    super.key,
    required this.items,
    required this.totalPrice,
    required this.onTapCheckout,
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
            APPStrings.orderSummary.tr,
            style: style.orderSummaryTitleStyle,
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
          const Divider(height: 1),
          _buildPromoCodeSection(style),
          const Divider(height: 1),
          const SizedBox(height: 16),
          _buildTotalSection(style),
          const SizedBox(height: 24),
          SmartButton(onTap: onTapCheckout, title: APPStrings.checkout.tr),
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
