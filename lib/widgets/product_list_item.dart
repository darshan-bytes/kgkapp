import 'package:kgk/kgk.dart';

class ProductListItem extends StatelessWidget {
  final ProductDetails productDetails;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onFavTap;
  final Function()? onAddToBagTap;
  final Function()? onEyeTap;
  final BoxFit fit;
  final bool isFavourite;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isCustomisable;

  const ProductListItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.productDetails,
    this.fit = BoxFit.cover,
    this.onFavTap,
    this.onAddToBagTap,
    this.onEyeTap,
    this.isFavourite = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.isCustomisable = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: style.backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImageSection(style),
            SizedBox(width: 16.w),
            productDetailsSection(style, context),
          ],
        ),
      ),
    );
  }

  Widget productImageSection(ProductItemStyle style) {
    return Stack(
      children: [
        Container(
          height: boxHeight ?? 144.w,
          width: boxWidth ?? 144.w,
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
              if (isCustomisable) buildIcon(path: AppImages.icCustomisable, style: style, borderColor: style.borderColor),
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

  Widget buildIcon({required String path, Function()? onTap, required ProductItemStyle style, Color? backgroundColor, Color? borderColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? style.backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor ?? style.transparentColor)),
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

  Widget productDetailsSection(ProductItemStyle style, BuildContext context) {
    return Expanded(
      child: Container(
        color: style.backgroundColor,
        child: Column(
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
              priceSection(style),
            ],
            if (productDetails.gram.isNotNullNorEmpty || productDetails.diamond.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              diamondAndGramSection(style, context),
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
            if (onAddToBagTap != null)
              SmartButton(
                margin: productDetails.discountPercentage.isNullOrEmpty ? EdgeInsets.only(top: 8.h) : EdgeInsets.zero,
                titleStyle: style.buttonWithIconTextStyle,
                onTap: onAddToBagTap!,
                title: APPStrings.addToBag.tr,
                prefixImage: AppImages.icShoppingBag,
              ),
          ],
        ),
      ),
    );
  }

  Widget priceSection(ProductItemStyle style) {
    return Row(
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
        ],
      ],
    );
  }

  Widget diamondAndGramSection(ProductItemStyle style, BuildContext context) {
    return Row(
      children: [
        if (productDetails.diamond.isNotNullNorEmpty) ...[
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                Flexible(
                  child: SmartText(
                    productDetails.diamond,
                    style: style.diamondTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
        ],
        if (productDetails.gram.isNotNullNorEmpty)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icGram, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                Flexible(
                  child: SmartText(
                    productDetails.gram,
                    style: style.diamondTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
