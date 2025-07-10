import 'package:kgk/kgk.dart';

class ProductListItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
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
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isCustomisable;
  final bool isOutOfStock;

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
    this.padding,
    this.margin,
    this.isCustomisable = false,
    this.isOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0.8,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: style.borderColor, strokeAlign: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadowColor: style.primaryColor,
        child: Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(color: style.backgroundColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [productImageSection(style, context), SizedBox(width: 16.w), productDetailsSection(style, context)],
          ),
        ),
      ),
    );
  }

  Widget productImageSection(ProductItemStyle style, BuildContext context) {
    return SizedBox(
      height: boxHeight ?? 144.w,
      width: boxWidth ?? 144.w,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            height: boxHeight ?? 144.w,
            width: boxWidth ?? 144.w,
            alignment: AlignmentDirectional.topCenter,
            color: style.whiteColor,
            child: SmartImage(path: productDetails.imageUrl ?? '', height: imageHeight, width: imageWidth, fit: fit),
          ),
          if (isOutOfStock)
            PositionedDirectional(
              top: 8.h,
              start: 8.w,
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: style.outOfStockBackgroundColor, borderRadius: BorderRadius.circular(4.r)),
                child: SmartText(APPStrings.outOfStock.tr, style: style.outOfStockStyle),
              ),
            ),
          PositionedDirectional(
            top: 8.h,
            end: 8.w,
            child: Row(
              children: [if (isCustomisable) buildIcon(path: AppImages.icCustomisable, style: style, borderColor: style.borderColor)],
            ),
          ),
          PositionedDirectional(
            bottom: 8.w,
            end: 8.w,
            child: Row(
              children: [
                if (onEyeTap != null &&
                    (StorageManager.instance.getIsSkipLogin() ||
                        (Utils.getPermissionByModuleName(moduleName: ModuleKey.watchlist)?.create?.allowed == true &&
                            Utils.getPermissionByModuleName(moduleName: ModuleKey.watchlist)?.update?.allowed == true)))
                  buildIcon(
                    path: AppImages.icAddEye,
                    onTap: () {
                      BlocProvider.of<AppBloc>(context).onTapWatchList(context, productDetails: productDetails);
                    },
                    style: style,
                  ),
                SizedBox(width: 8.w),
                if (onFavTap != null &&
                    (StorageManager.instance.getIsSkipLogin() ||
                        (Utils.getPermissionByModuleName(moduleName: ModuleKey.wishlist)?.create?.allowed == true)))
                  BlocBuilder<AppBloc, AppState>(
                    buildWhen: (previous, current) => current is ProductAddToFavoriteState || current is ProductRemoveFromFavoriteState,
                    builder: (context, state) {
                      return buildIcon(
                        path: isFavourite ? AppImages.icHeartFill : AppImages.icProductFavIcon,
                        onTap: () {
                          BlocProvider.of<AppBloc>(context).onTapFavorite(context, productDetails: productDetails);
                        },
                        style: style,
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIcon({required String path, Function()? onTap, required ProductItemStyle style, Color? backgroundColor, Color? borderColor}) {
    return Bounceable(
      onTap: onTap,
      scaleFactor: 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? style.backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor ?? style.transparentColor),
        ),
        height: 30.w,
        width: 30.w,
        alignment: AlignmentDirectional.center,
        child: SmartImage(path: path, height: 20.w, width: 20.w, fit: BoxFit.contain),
      ),
    );
  }

  Widget productDetailsSection(ProductItemStyle style, BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
        color: style.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            /*   if (productDetails.title != null)
              SmartText(
                productDetails.title,
                style: style.diamondTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (productDetails.subTitle != null)
              SmartText(
                "${productDetails.subTitle}\n\n",
                style: style.productNameStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),*/
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmartText(
                  productDetails.productSku ?? productDetails.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style.diamondTextStyle,
                ),
              ],
            ),
            SmartText(
              productDetails.name ?? productDetails.subTitle ?? '',
              style: style.productNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (productDetails.originalPrice.isNotNullNorEmpty) ...[SizedBox(height: 8.h), priceSection(style)],

            /// Below Lines are commented as they are not required in the current implementation as discussed in the client call
            /*Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (productDetails.kgkCollectionName.isNotNullNorEmpty)
                  Flexible(
                    child: SmartText(
                      productDetails.kgkCollectionName,
                      style: style.priceTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      optionalPadding: EdgeInsetsDirectional.only(top: 8.h),
                    ),
                  ),
                if (productDetails.businessCategoryName.isNotNullNorEmpty) ...[
                  SmartText(
                    "|",
                    style: style.priceTextStyle,
                    optionalPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: 8.w,
                    ),
                  ),
                  Expanded(
                    child: SmartText(
                      productDetails.businessCategoryName,
                      style: style.productNameStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]
              ],
            ),*/
            /*if (productDetails.cts.isNotNullNorEmpty || productDetails.gms.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              diamondAndGramSection(style),
            ],*/
            SizedBox(height: 4.h),
            if (onAddToBagTap != null)
              SmartButton(
                height: 32.w,
                margin:
                    productDetails.discountPercentageString.isNullOrEmpty
                        ? EdgeInsetsDirectional.only(top: 8.h)
                        : EdgeInsetsDirectional.zero,
                padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                titleStyle: style.buttonTextStyle,
                onTap: () {
                  if (productDetails.isAddedToCart) {
                    BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
                    context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                  } else {
                    BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(productDetails, context));
                  }
                },
                title: productDetails.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                prefixImage: AppImages.icShoppingBag,
                imageSize: 16.w,
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
            productDetails.finalPrice.isNotNullNorEmpty ? productDetails.finalPrice : productDetails.originalPrice,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.priceTextStyle,
          ),
        ),
        if (productDetails.finalPrice.isNotNullNorEmpty && productDetails.isShowDiscountPrice) ...[
          SizedBox(width: 10.w),
          Flexible(
            child: SmartText(productDetails.originalPrice, maxLines: 1, overflow: TextOverflow.ellipsis, style: style.checkedPriceStyle),
          ),
        ],
      ],
    );
  }

  Widget diamondAndGramSection(ProductItemStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 14.w,
          width: 14.w,
          decoration: BoxDecoration(color: productDetails.getCatalogueBadgeColor, borderRadius: BorderRadius.circular(32.r)),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Row(
            children: [
              if (productDetails.cts.isNotNullNorEmpty) ...[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: SmartText(productDetails.cts, style: style.diamondTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                        child: SmartText(productDetails.gms, style: style.diamondTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
