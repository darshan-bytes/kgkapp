import 'package:kgk/kgk.dart';

class OrderSummary extends StatelessWidget {
  final String? title;
  final List<OrderSummaryItem> items;
  final String totalPrice;
  final String subTotalPrice;
  final void Function()? onTapCheckout;
  final void Function()? onTapRemovePromoCode;
  final void Function()? onApplyPromoCode;
  final bool isPromoCodeApplied;
  final TextStyle? titleStyle;
  final TextStyle? totalStyle;
  final BagOrderCharge? promoCode;

  const OrderSummary({
    this.title,
    super.key,
    required this.items,
    required this.totalPrice,
    required this.subTotalPrice,
    this.onTapCheckout,
    this.isPromoCodeApplied = true,
    this.titleStyle,
    this.totalStyle,
    this.promoCode,
    this.onTapRemovePromoCode,
    this.onApplyPromoCode,
  });

  @override
  Widget build(BuildContext context) {
    final OrderSummaryStyle style = AppTheme.of(context).orderSummaryStyle;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
      color: style.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartText(
            title ?? APPStrings.orderSummary.tr,
            style: titleStyle?.merge(style.orderSummaryTitleStyle) ?? style.orderSummaryTitleStyle,
          ),
          SizedBox(height: 20.h),
          if (isPromoCodeApplied) ...[
            const Divider(),
            _buildPromoCodeSection(style, context),
            const Divider(),
            SizedBox(height: 14.h),
          ],
          _buildTotalSection(style, isSubTotal: true),
          SizedBox(height: 6.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsetsDirectional.only(bottom: 6.0),
                child: _buildOrderSummaryItem(item, style),
              );
            },
          ),
          _buildTotalSection(style),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryItem(OrderSummaryItem item, OrderSummaryStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(child: SmartText(item.title, style: style.orderSummaryItemStyle)),
          SizedBox(width: 16.w),
          SmartText(item.value, style: style.orderSummaryItemValueStyle),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection(OrderSummaryStyle style, BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.applyPromoCodeScreen, arguments: {RoutesData.promoCode: promoCode}).then(
          (_) => BlocProvider.of<MyBagBloc>(context).add(FetchOrderSummaryDataEvent(context)),
        );
        onApplyPromoCode?.call();
      },
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: promoCode != null ? 10.h : 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(promoCode?.title ?? APPStrings.addPromoCode.tr, style: style.addPromoCodeStyle),
                  if (promoCode != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SmartText(APPStrings.viewAllCoupons.tr, style: style.viewAllCouponsStyle),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_forward_ios, size: 12.w, color: style.viewAllCouponsStyle.color),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 17.w),
            SmartText(
              promoCode == null ? APPStrings.apply.tr : APPStrings.applied.tr,
              style: (promoCode == null ? style.totalPriceStyle : style.applyButtonStyle).merge(totalStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(OrderSummaryStyle style, {bool isSubTotal = false}) {
    return Row(
      children: [
        Expanded(
          child: SmartText(
            isSubTotal ? APPStrings.subTotal.tr : APPStrings.total.tr,
            style: style.orderSummaryItemStyle,
          ),
        ),
        SizedBox(width: 16.w),
        SmartText(
          isSubTotal ? subTotalPrice : totalPrice,
          style: totalStyle ?? style.totalPriceStyle,
        ),
      ],
    );
  }
}

class OrderSummaryItem {
  const OrderSummaryItem({required this.title, required this.value});

  final String title;
  final String value;
}
