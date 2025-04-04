import 'package:kgk/kgk.dart';

class DIYBagItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onRemoveTap;
  final Function()? onMoveToWishListTap;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isSelectedProduct;
  final Function(bool?)? onChangedCheckbox;
  final bool isCheckboxShow;
  final TextStyle? priceTextStyle;
  final bool isEnableAddToWishList;
  final bool isOutOfStock;

  const DIYBagItem({
    super.key,
    required this.productDetails,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.fit = BoxFit.cover,
    this.onRemoveTap,
    this.onMoveToWishListTap,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
    this.isSelectedProduct = false,
    this.onChangedCheckbox,
    this.isCheckboxShow = false,
    this.isEnableAddToWishList = true,
    this.priceTextStyle,
    this.isOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productItemStyle;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(color: style.backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOutOfStock) ...[
              Row(
                children: [
                  Icon(Icons.warning_amber_outlined, color: style.errorColor, size: 16.w),
                  SizedBox(width: 8.w),
                  SmartText(APPStrings.thisProductIsCurrentlyNotInStock.tr, style: style.outOfStockTextStyle),
                ],
              ),
              SizedBox(height: 12.h),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productImageSection(style),
                SizedBox(width: 16.w),
                productDetailsSection(style, context),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: style.borderColor))),
              child: Row(
                children: [
                  Expanded(
                      child: SmartButton(
                    activeBackgroundColor: style.backgroundColor,
                    title: APPStrings.remove.tr,
                    titleStyle: style.removeBagTextStyle,
                    borderRadius: const BorderRadius.all(Radius.zero),
                    onTap: () {
                      if (onRemoveTap != null) {
                        onRemoveTap!();
                      }
                    },
                  )),
                  Container(width: 1.w, height: 48.w, color: style.myBagDividerColor),
                  if (isEnableAddToWishList)
                    Expanded(
                      child: SmartButton(
                        activeBackgroundColor: style.backgroundColor,
                        title: APPStrings.moveToWishlist.tr,
                        titleStyle: style.removeBagTextStyle,
                        borderRadius: const BorderRadius.all(Radius.zero),
                        onTap: () {
                          if (onMoveToWishListTap != null) {
                            onMoveToWishListTap!();
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget productImageSection(ProductItemStyle style) {
    return Stack(
      children: [
        Container(
          height: boxHeight ?? 96.w,
          width: boxWidth ?? 96.w,
          alignment: AlignmentDirectional.center,
          color: style.productBackgroundColor,
          child: SmartImage(path: productDetails.imageUrl ?? '', height: imageHeight, width: imageWidth, fit: fit),
        ),
        if (isCheckboxShow)
          PositionedDirectional(
            top: 8.h,
            start: 8.w,
            child: SmartCheckbox(
              height: 24.w,
              width: 24.w,
              value: isSelectedProduct,
              onChanged: (bool? newValue) {
                if (onChangedCheckbox != null) {
                  onChangedCheckbox!(newValue);
                }
              },
            ),
          ),
      ],
    );
  }

  Widget productDetailsSection(ProductItemStyle style, BuildContext context) {
    return Expanded(
      child: Container(
        color: style.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (productDetails.diyBagItemProductDetailsList.isNotNullNorEmpty) ...[
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productDetails.diyBagItemProductDetailsList!.length,
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(),
                ),
                itemBuilder: (context, index) =>
                    _displayProductView(model: productDetails.diyBagItemProductDetailsList![index], style: style),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _displayProductView({required DiyBagItemProductDetailsModel model, required ProductItemStyle style}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildIcon(path: model.icon ?? "", style: style),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(model.productNameTitle ?? "-", maxLines: 2, overflow: TextOverflow.ellipsis, style: style.productNameStyle),
              SizedBox(height: 4.h),
              SmartText(model.skuNo ?? "-", maxLines: 1, overflow: TextOverflow.ellipsis, style: style.diamondTextStyle),
              SizedBox(height: 4.h),
              if (model.finalPrice.isNotNullNorEmpty) ...[
                Row(
                  children: [
                    Flexible(
                      child: SmartText(
                        model.discountPrice.isNotNullNorEmpty ? model.discountPrice : model.finalPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: priceTextStyle ?? style.priceTextStyle,
                      ),
                    ),
                    if (model.finalPrice.isNotNullNorEmpty) ...[
                      SizedBox(width: 10.w),
                      Flexible(
                        child: SmartText(model.finalPrice, maxLines: 1, overflow: TextOverflow.ellipsis, style: style.checkedPriceStyle),
                      )
                    ],
                  ],
                )
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIcon({required String path, Function()? onTap, required ProductItemStyle style, Color? backgroundColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor ?? style.backgroundColor, borderRadius: BorderRadius.circular(4.r)),
        height: 24.w,
        width: 24.w,
        alignment: AlignmentDirectional.center,
        child: SmartImage(path: path, height: 16.w, width: 16.w, fit: BoxFit.contain),
      ),
    );
  }
}
