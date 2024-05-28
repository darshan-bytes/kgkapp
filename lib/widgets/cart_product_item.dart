import 'package:kgk/kgk.dart';

class CartProductItem extends StatelessWidget {
  final ProductDetails productDetails;
  final double boxHeight;
  final double boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onFavTap;
  final Function()? onAddToBagTap;
  final Function()? onEyeTap;
  final Function()? onRemoveTap;
  final Function()? onMoveToWishListTap;
  final BoxFit fit;
  final bool isFavourite;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final CartProductQuantity? selectedQuantity;
  final CartProductQuality? selectedQuality;
  final List<CartProductQuality> qualityOptionsList;
  final List<CartProductQuantity> quantityOptionsList;
  final Function(CartProductQuality)? onQualityChanged;
  final Function(CartProductQuantity)? onQuantityChanged;
  final bool isSelectedProduct;
  final Function(bool?)? onChangedCheckbox;

  const CartProductItem(
      {super.key,
      required this.productDetails,
      this.boxHeight = 96,
      this.boxWidth = 96,
      this.imageHeight,
      this.imageWidth,
      this.onTap,
      this.fit = BoxFit.cover,
      this.onFavTap,
      this.onAddToBagTap,
      this.onEyeTap,
      this.onRemoveTap,
      this.onMoveToWishListTap,
      this.isFavourite = false,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero,
      this.selectedQuantity,
      this.selectedQuality,
      required this.qualityOptionsList,
      required this.quantityOptionsList,
      this.onQualityChanged,
      this.onQuantityChanged,
      this.isSelectedProduct = false,
      required this.onChangedCheckbox});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productImageSection(style),
                const SizedBox(width: 16),
                productDetailsSection(style, context),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: style.borderColor)),
              ),
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
                  Container(width: 1, height: 48, color: style.myBagDividerColor),
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
                          })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productImageSection(ProductItemStyle style) {
    return Stack(
      children: [
        Container(
          height: boxHeight,
          width: boxWidth,
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
            left: 8,
            child: SmartCheckbox(
              height: 24,
              width: 24,
              value: isSelectedProduct,
              onChanged: (bool? newValue) {
                if (onChangedCheckbox != null) {
                  onChangedCheckbox!(newValue);
                }
              },
            )),
      ],
    );
  }

  Widget buildIcon({
    required String path,
    Function()? onTap,
    required ProductItemStyle style,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? style.backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
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
              const SizedBox(height: 8),
              priceSection(style),
            ],
            if (productDetails.gram.isNotNullNorEmpty || productDetails.diamond.isNotNullNorEmpty) ...[
              const SizedBox(height: 8),
              diamondAndGramSection(style, context),
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
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: SmartDropdownButtonFormField<CartProductQuality>(
                      value: selectedQuality,
                      items: qualityOptionsList,
                      itemLableBuilder: (CartProductQuality value) {
                        if (value.name != null) {
                          return value.name!;
                        }
                        return APPStrings.selectQuality.tr;
                      },
                      onChanged: (newValue) => onQualityChanged?.call(newValue!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: SmartDropdownButtonFormField<CartProductQuantity>(
                      value: selectedQuantity,
                      onChanged: (newValue) => onQuantityChanged?.call(newValue!),
                      items: quantityOptionsList,
                      itemLableBuilder: (CartProductQuantity value) {
                        if (value.name != null) {
                          return value.name!;
                        }
                        return APPStrings.selectQuantity.tr;
                      },
                    ),
                  ),
                ],
              ),
            )
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
                const SmartImage(path: AppImages.icBlankDiamond, height: 16, width: 16),
                const SizedBox(width: 4),
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
          const SizedBox(width: 8),
        ],
        if (productDetails.gram.isNotNullNorEmpty)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SmartImage(path: AppImages.icGram, height: 16, width: 16),
                const SizedBox(width: 4),
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
