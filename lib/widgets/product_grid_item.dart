import 'package:kgk/kgk.dart';

class ProductGridItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
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
  final bool isForAuction;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool isStoneWithPrice;
  final String? prefixImage;
  final double? imageSize;
  final bool isCommentSelected;
  final String? buttonText;
  final bool isBadgeVisible;
  final bool forPreviewCatalogue;
  final bool isCrtAndGramVisible;
  final bool isFromWatchlist;

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
    this.isForAuction = false,
    this.prefixImage,
    this.imageSize,
    this.onCommentTap,
    this.isCommentSelected = false,
    this.buttonText,
    this.isBadgeVisible = false,
    this.forPreviewCatalogue = false,
    this.isCrtAndGramVisible = true,
    this.isFromWatchlist = false,
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
            productImageSection(productItemWidth, style, context),
            productDetailsSection(context, productItemWidth, style),
          ],
        ),
      ),
    );
  }

  Widget productImageSection(double width, ProductItemStyle style, BuildContext context) {
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
            isMemCacheEnabled: false,
          ),
        ),
        if (productDetails.isForAuction)
          Positioned(
            top: 0.h,
            left: -4.w,
            child: SmartImage(path: AppImages.icAuctionLabel, height: 32.w, width: 92.w, fit: BoxFit.fill),
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
              if (onEyeTap != null)
                buildIcon(
                    path: AppImages.icAddEye,
                    onTap: () {
                      BlocProvider.of<AppBloc>(context).onTapWatchList(
                        context,
                        productDetails: productDetails,
                      );
                    },
                    style: style),
              SizedBox(width: 8.w),
              if (onFavTap != null)
                BlocBuilder<AppBloc, AppState>(
                  buildWhen: (previous, current) => current is ProductAddToFavoriteState || current is ProductRemoveFromFavoriteState,
                  builder: (context, state) {
                    return buildIcon(
                        path: productDetails.isFavourite ? AppImages.icHeartFill : AppImages.icProductFavIcon,
                        onTap: () {
                          BlocProvider.of<AppBloc>(context).onTapFavorite(
                            context,
                            productDetails: productDetails,
                            onFavTap: onFavTap,
                          );
                        },
                        style: style);
                  },
                ),
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
      return const SizedBox.shrink();
    }
  }

  Widget buildIcon(
      {required String path,
      Function()? onTap,
      required ProductItemStyle style,
      Color? backgroundColor,
      Color? borderColor,
      Color? iconColor}) {
    return Bounceable(
      onTap: onTap,
      scaleFactor: 0.5,
      child: Badge(
        label: SmartText('2', style: style.badgeTextStyle),
        backgroundColor: style.primaryColor,
        isLabelVisible: isBadgeVisible,
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
            height: 20.w,
            width: 20.w,
            fit: BoxFit.contain,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget productDetailsSection(BuildContext context, double width, ProductItemStyle style) {
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
              productDetails.title,
              style: style.priceTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SmartText(
              "${productDetails.subTitle}\n\n",
              style: style.productNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (productDetails.kgkCollectionName.isNotNullNorEmpty || isFromWatchlist)
              SmartText(
                "${productDetails.kgkCollectionName ?? ''}\n",
                style: style.priceTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                optionalPadding: EdgeInsets.only(top: 8.h),
              ),
            if (productDetails.businessCategoryName.isNotNullNorEmpty || isFromWatchlist)
              SmartText(
                "${productDetails.businessCategoryName ?? ''}\n",
                style: style.productNameStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      SmartText(
                        productDetails.finalPrice.isNotNullNorEmpty ? productDetails.finalPrice : productDetails.originalPrice,
                        style: style.priceTextStyle,
                        optionalPadding: EdgeInsets.only(right: 8.w),
                      ),
                      if (productDetails.finalPrice.isNotNullNorEmpty && productDetails.isShowDiscountPrice) ...[
                        SmartText(
                          productDetails.originalPrice,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style.checkedPriceStyle,
                        ),
                      ] else ...[
                        SmartText("\n")
                      ]
                    ],
                  ),
                ),
                if ((isStoneWithPrice && productDetails.ctsOrGms != null))
                  SmartImage(
                    path: productDetails.ctsOrGms! > 0.1
                        ? AppImages.icOneRing
                        : productDetails.ctsOrGms! > 0.2
                            ? AppImages.icTwoRing
                            : AppImages.icThreeRing,
                    height: 20.w,
                    width: 20.w,
                    fit: BoxFit.fill,
                  )
              ],
            ),
            if (productDetails.discountPercentageString.isNotNullNorEmpty) ...[
              SizedBox(height: 4.h),
              SmartText(
                productDetails.discountPercentageString,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
            ],
            if (isCrtAndGramVisible || isFromWatchlist) diamondAndGramSection(style),
            if (onAddToBagTap != null)
              SmartButton(
                height: 32.w,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                titleStyle: style.buttonTextStyle,
                onTap: () {
                  if (buttonText.isNullOrEmpty) {
                    if (productDetails.isAddedToCart) {
                      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
                      context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                    } else {
                      BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(productDetails, context));
                    }
                  } else {
                    onAddToBagTap?.call();
                  }
                },
                title: buttonText ?? (productDetails.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr),
                prefixImage: prefixImage,
                isShadow: false,
                imageSize: imageSize ?? 16.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget diamondAndGramSection(ProductItemStyle style) {
    if (productDetails.cts.isNullOrEmpty && productDetails.gms.isNullOrEmpty) {
      return SizedBox(height: 24.h);
    }
    return Padding(
      padding: EdgeInsets.only(top: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 14.w,
            width: 14.w,
            decoration: BoxDecoration(
              color: productDetails.getCatalogueBadgeColor,
              borderRadius: BorderRadius.circular(32.r),
            ),
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
                          child: SmartText(
                            productDetails.cts,
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
                            productDetails.gms,
                            style: style.diamondTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
