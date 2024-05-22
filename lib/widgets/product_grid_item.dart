import 'package:kgk/kgk.dart';

class ProductGridItem extends StatelessWidget {
  final ProductDetails productDetails;
  final double boxHeight;
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

  const ProductGridItem({
    super.key,
    this.boxHeight = 172,
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
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productItemStyle;
    final double productItemWidth = (MediaQuery.of(context).size.width - 46) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          height: boxHeight,
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
              if (onEyeTap != null)
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
              const SizedBox(width: 8),
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
        height: 24,
        width: 24,
        alignment: Alignment.center,
        child: SmartImage(
          path: path,
          height: 16,
          width: 16,
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
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SmartText(
                productDetails.name,
                style: style.productNameStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (productDetails.originalPrice.isNotNullNorEmpty) ...[
              const SizedBox(height: 8),
              Row(
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
                    const SizedBox(width: 10),
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
              ),
            ],
            if (productDetails.discountPercentage.isNotNullNorEmpty) ...[
              const SizedBox(height: 4),
              SmartText(
                productDetails.discountPercentage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
              const SizedBox(height: 8),
            ],
            if (onAddToBagTap != null)
              SmartButton(
                height: 32,
                padding: const EdgeInsets.symmetric(vertical: 8),
                titleStyle: style.buttonTextStyle,
                onTap:onAddToBagTap! ,
                title: APPStrings.addToBag.tr,
              ),
          ],
        ),
      ),
    );
  }
}