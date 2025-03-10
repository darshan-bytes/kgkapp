import 'package:kgk/kgk.dart';

class CartProductItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final Function()? onFavTap;
  final Function()? onAddToBagTap;
  final Function()? onEyeTap;
  final Function()? onRemoveTap;
  final Function()? onMoveToWishListTap;
  final Function()? onDeleteTap;
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
  final bool isCheckboxShow;
  final TextStyle? priceTextStyle;
  final bool isDropDownEnable;
  final bool isEnableAddToWishList;
  final bool isOutOfStock;

  const CartProductItem({
    super.key,
    required this.productDetails,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.fit = BoxFit.cover,
    this.onFavTap,
    this.onAddToBagTap,
    this.onEyeTap,
    this.onRemoveTap,
    this.onMoveToWishListTap,
    this.onDeleteTap,
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
    this.onChangedCheckbox,
    this.isCheckboxShow = false,
    this.isDropDownEnable = true,
    this.isEnableAddToWishList = true,
    this.priceTextStyle,
    required this.isOutOfStock,
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
                            })),
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
          alignment: Alignment.center,
          color: style.productBackgroundColor,
          child: SmartImage(
            path: productDetails.imageUrl ?? '',
            height: imageHeight,
            width: imageWidth,
            fit: fit,
          ),
        ),
        if (isCheckboxShow)
          Positioned(
              top: 8.h,
              left: 8.w,
              child: SmartCheckbox(
                height: 24.w,
                width: 24.w,
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
          borderRadius: BorderRadius.circular(4.r),
        ),
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
    final textFieldStyle = AppTheme.of(context).textFieldStyle;
    return Expanded(
      child: Container(
        color: style.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SmartText(
                    productDetails.name,
                    style: style.productNameStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onDeleteTap != null)
                  GestureDetector(
                    onTap: onDeleteTap,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                        child: SmartImage(path: AppImages.icDelete, height: 18.w, width: 18.w)),
                  ),
              ],
            ),
            if (productDetails.finalPrice.isNotNullNorEmpty) ...[
              SizedBox(height: 8.h),
              priceSection(style),
            ],
            if (productDetails.gms.isNotNullNorEmpty || productDetails.cts.isNotNullNorEmpty) ...[
              SizedBox(height: 8.h),
              diamondAndGramSection(style, context),
            ],
            if (productDetails.discountPercentageString.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              SmartText(
                "${productDetails.discountPercentageString}%",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
            ],
            // SizedBox(height: 8.h),
            // SmartText(selectedQuality?.name ?? '', style: style.productNameStyle),
            // SizedBox(height: 8.h),
            // SmartText("${APPStrings.qty.tr} : ${selectedQuantity?.name ?? ''}", style: style.productNameStyle),
            // SizedBox(height: 12.h),
            //padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: SmartDropDown<CartProductQuality>(
                  //     selectedItem: selectedQuality,
                  //     items: qualityOptionsList.map((e) => SmartDropDownItem<CartProductQuality>(value: e, title: e.name ?? '')).toList(),
                  //     hintText: APPStrings.selectQuality.tr,
                  //     onChanged: (newValue) => onQualityChanged?.call(newValue!),
                  //   ),
                  // ),
                  // SizedBox(width: 8.w),
                  DropdownButton<CartProductQuantity>(
                    isDense: true,
                    value: selectedQuantity,
                    onChanged: (newValue) => onQuantityChanged?.call(newValue!),
                    selectedItemBuilder: (context) {
                      return quantityOptionsList.map((e) {
                        return SmartText(APPStrings.qtyX.tr.interpolate([e.name]));
                      }).toList();
                    },
                    items: quantityOptionsList
                        .map((e) => DropdownMenuItem<CartProductQuantity>(
                              value: e,
                              child: SmartText(e.name ?? ''),
                            ))
                        .toList(),
                  ),
                ],
              ),
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
            style: priceTextStyle ?? style.priceTextStyle,
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
        if (productDetails.cts.isNotNullNorEmpty) ...[
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                Flexible(
                  child: SmartText(
                    "${productDetails.cts} ${APPStrings.crt.tr}",
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
        if (productDetails.gms.isNotNullNorEmpty)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icGram, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                Flexible(
                  child: SmartText(
                    "${productDetails.gms} ${APPStrings.grms.tr}",
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
