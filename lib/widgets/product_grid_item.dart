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
  final Function()? onCommentTap;
  final bool isFavourite;
  final BoxFit fit;
  final bool isCustomisable;
  final bool isOutOfStock;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isStoneWithPrice;
  final String? prefixImage;
  final double? imageSize;
  final bool isCommentSelected;
  final String? buttonText;

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
    this.isCustomisable = false,
    this.isOutOfStock = false,
    this.prefixImage,
    this.imageSize,
    this.onCommentTap,
    this.isCommentSelected = false,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final ProductItemStyle style = AppTheme.of(context).productItemStyle;
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
        if (isOutOfStock)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: style.outOfStockBackgroundColor, borderRadius: BorderRadius.circular(4.r)),
              child: SmartText(APPStrings.outOfStock.tr, style: style.outOfStockStyle),
            ),
          ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: _buildTopPositionView(style),
        ),
        Positioned(
          bottom: 8.h,
          right: 8.w,
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

  Widget _buildTopPositionView(ProductItemStyle style) {
    if (onCommentTap != null) {
      return buildIcon(
          path: AppImages.icMessages,
          onTap: onCommentTap,
          style: style,
          backgroundColor: isCommentSelected ? style.myBagDividerColor : null,
          iconColor: isCommentSelected ? style.commentSelectedColor : null);
    } else if (onCancelTap != null) {
      return buildIcon(path: AppImages.icCancel, onTap: onCancelTap, style: style, backgroundColor: Colors.transparent);
    } else if (isCustomisable) {
      return buildIcon(path: AppImages.icCustomisable, style: style, borderColor: style.borderColor);
    } else {
      return const SizedBox();
    }
  }

  Widget buildIcon(
      {required String path,
      Function()? onTap,
      required ProductItemStyle style,
      Color? backgroundColor,
      Color? borderColor,
      Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? style.backgroundColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: borderColor ?? style.transparentColor)),
        height: 24.w,
        width: 24.w,
        alignment: Alignment.center,
        child: SmartImage(
          path: path,
          height: 16.w,
          width: 16.w,
          fit: BoxFit.contain,
          color: iconColor,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        SmartText(
                          productDetails.offerPrice.isNotNullNorEmpty ? productDetails.offerPrice : productDetails.originalPrice,
                          style: style.priceTextStyle,
                          optionalPadding: EdgeInsets.only(right: 8.w),
                        ),
                        if (productDetails.offerPrice.isNotNullNorEmpty) ...[
                          SmartText(
                            productDetails.originalPrice,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: style.checkedPriceStyle,
                          ),
                        ]
                      ],
                    ),
                  ),
                  if (isStoneWithPrice)
                    SmartImage(
                      path: AppImages.icStone,
                      height: 20.w,
                      width: 20.w,
                      fit: BoxFit.fill,
                    )
                ],
              )
            ],
            if (productDetails.discountPercentage.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              SmartText(
                productDetails.discountPercentage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
            ],
            if (onAddToBagTap != null)
              SmartButton(
                height: 32.w,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                titleStyle: style.buttonTextStyle,
                onTap: onAddToBagTap!,
                title: buttonText ?? APPStrings.addToBag.tr,
                prefixImage: prefixImage,
                isShadow: false,
                imageSize: imageSize ?? 16.w,
              ),
          ],
        ),
      ),
    );
  }
}
