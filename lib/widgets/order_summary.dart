import 'package:kgk/kgk.dart';

class OrderSummary extends StatelessWidget {
  final String? title;
  final List<OrderSummaryItem> items;
  final String totalPrice;
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
            _buildPromoCodeSection(style, context),
            const Divider(),
          ],
          SizedBox(height: 16.h),
          _buildTotalSection(style),
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
        SmartText(item.value, style: style.orderSummaryItemValueStyle),
      ],
    );
  }

  Widget _buildPromoCodeSection(OrderSummaryStyle style, BuildContext context) {
    return InkWell(
      onTap: () {
        /// navigate to applyPromoCodeScreen with promoCode for applied promoCode
        context.pushNamed(AppRoutes.applyPromoCodeScreen, arguments: {RoutesData.promoCode: promoCode}).then(
          (value) {
            BlocProvider.of<MyBagBloc>(context).add(FetchOrderSummaryDataEvent(context));
          },
        );
        onApplyPromoCode?.call();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: promoCode != null ? 10.h : 14.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(
                    promoCode?.title ?? APPStrings.addPromoCode.tr,
                    style: style.addPromoCodeStyle,
                  ),
                  if (promoCode != null)
                    Row(
                      children: [
                        SmartText(APPStrings.viewAllCoupons.tr, style: style.viewAllCouponsStyle),
                        SizedBox(width: 5.w),
                        Icon(Icons.arrow_forward_ios, size: 12.w, color: style.viewAllCouponsStyle.color)
                      ],
                    )
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
