import 'package:kgk/kgk.dart';

class ProductGridItem extends StatelessWidget {
  final ProductDetails productDetails;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onFavTap;
  final Function()? onAddToBagTap;
  final Function()? onEyeTap;
  final Function()? onCancelTap;
  final bool isFavourite;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isStoneWithPrice;

  const ProductGridItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.productDetails,
    this.fit = BoxFit.cover,
    this.isFavourite = false,
    this.onFavTap,
    this.onAddToBagTap,
    this.onEyeTap,
    this.onCancelTap,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.isStoneWithPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productItemStyle;
    final double productItemWidth = (context.width - 46.w) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: productItemWidth,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          border: Border.all(color: style.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            productImageSection(productItemWidth, style),
            productDetailsSection(productItemWidth, style),
          ],
        ),
      ),
    );
  }

  Widget productImageSection(double width, ProductItemStyle style) {
    return Stack(
      children: [
        Container(
          height: boxHeight ?? 172.h,
          width: width,
          alignment: Alignment.center,
          color: style.productBackgroundColor,
          child: SmartImage(
            path: productDetails.imageUrl ?? '',
            height: imageHeight,
            width: imageWidth,
            fit: fit,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              if (onCancelTap != null)
                buildIcon(path: AppImages.icCancel, onTap: onCancelTap, style: style, backgroundColor: Colors.transparent),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Row(
            children: [
              if (onEyeTap != null) buildIcon(path: AppImages.icAddEye, onTap: onEyeTap, style: style),
              SizedBox(width: 8.w),
              if (onFavTap != null)
                buildIcon(path: isFavourite ? AppImages.icHeartFill : AppImages.icProductFavIcon, onTap: onFavTap, style: style),
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
        decoration: BoxDecoration(color: backgroundColor ?? style.backgroundColor, borderRadius: BorderRadius.circular(4)),
        height: 24.w,
        width: 24.w,
        alignment: Alignment.center,
        child: SmartImage(
          path: path,
          height: 16.w,
          width: 16.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget productDetailsSection(double width, ProductItemStyle style) {
    return Flexible(
      child: Container(
        width: width,
        color: style.backgroundColor,
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText(
              productDetails.name,
              style: style.productNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (productDetails.originalPrice.isNotNullNorEmpty) ...[
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SmartText(
                      productDetails.offerPrice.isNotNullNorEmpty ? productDetails.offerPrice : productDetails.originalPrice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: style.priceTextStyle,
                    ),
                  ),
                  if (productDetails.offerPrice.isNotNullNorEmpty) ...[
                    SizedBox(width: 10.w),
                    Flexible(
                      child: SmartText(
                        productDetails.originalPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: style.checkedPriceStyle,
                      ),
                    ),
                  ] else ...[
                    if (isStoneWithPrice) SmartImage(path: AppImages.icStone, height: 16.w, width: 16.w)
                  ],
                ],
              ),
            ],
            if (productDetails.discountPercentage.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              SmartText(
                productDetails.discountPercentage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
              SizedBox(height: 8.h),
            ],
            if (productDetails.discountPercentage.isNullOrEmpty)
              SizedBox(
                height: 14.h,
              ),
            if (onAddToBagTap != null)
              SmartButton(
                height: 32.h,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                titleStyle: style.buttonTextStyle,
                onTap: onAddToBagTap!,
                title: APPStrings.addToBag.tr,
                isShadow: true,
              ),
          ],
        ),
      ),
    );
  }
}
