import 'package:kgk/kgk.dart';

class ProductGridItem extends StatefulWidget {
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
  final bool isKGKCouture;
  final bool isHomeView;
  final bool isHidePriceView;

  ProductGridItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.productDetails,
    this.fit = BoxFit.contain,
    this.isFavourite = false,
    this.onFavTap,
    this.onAddToBagTap,
    this.onEyeTap,
    this.onCancelTap,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
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
    this.isCrtAndGramVisible = false,
    this.isFromWatchlist = false,
    this.isKGKCouture = false,
    this.isHomeView = false,
    bool isHidePriceView = false,
  }) : isHidePriceView = (isHidePriceView || (productDetails.finalPrice.isNullOrEmpty && productDetails.originalPrice.isNullOrEmpty));

  @override
  Key get key => ValueKey(productDetails.suid ?? productDetails.productId);

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductItemStyle style = AppTheme.of(context).productItemStyle;
    final double productItemWidth = (context.width - 46.w) / 2;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        width: productItemWidth,
        decoration: BoxDecoration(color: style.backgroundColor, border: Border.all(color: style.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [productImageSection(productItemWidth, style, context), productDetailsSection(context, productItemWidth, style)],
        ),
      ),
    );
  }

  Widget productImageSection(double width, ProductItemStyle style, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.boxHeight ?? 172.h,
          width: width,
          alignment: AlignmentDirectional.center,
          color: style.productBackgroundColor,
          child: SmartImage(
            path: widget.productDetails.imageUrl ?? '',
            height: widget.imageHeight ?? 172.h,
            width: widget.imageWidth,
            fit: widget.fit,
            isMemCacheEnabled: false,
          ),
        ),
        if (widget.productDetails.isForAuction)
          PositionedDirectional(
            start: -4.w,
            child: SmartImage(path: AppImages.icAuctionLabel(AppLocalizations.of(context)?.locale?.languageCode ?? 'en'), fit: BoxFit.fill),
          ),
        if (widget.isOutOfStock)
          PositionedDirectional(
            top: 8.h,
            start: 8.w,
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: style.outOfStockBackgroundColor, borderRadius: BorderRadius.circular(4.r)),
              child: SmartText(APPStrings.outOfStock.tr, style: style.outOfStockStyle),
            ),
          ),
        PositionedDirectional(top: 8.h, end: 8.w, child: _buildTopPositionView(style)),
        PositionedDirectional(
          bottom: 8.h,
          end: 8.w,
          child: Row(
            children: [
              if (widget.onEyeTap != null)
                buildIcon(
                  path: AppImages.icAddEye,
                  onTap: () {
                    BlocProvider.of<AppBloc>(context).onTapWatchList(context, productDetails: widget.productDetails);
                  },
                  style: style,
                ),
              SizedBox(width: 8.w),
              if (widget.onFavTap != null)
                BlocBuilder<AppBloc, AppState>(
                  buildWhen: (previous, current) => current is ProductAddToFavoriteState || current is ProductRemoveFromFavoriteState,
                  builder: (context, state) {
                    return buildIcon(
                      path: widget.productDetails.isFavourite ? AppImages.icHeartFill : AppImages.icProductFavIcon,
                      onTap: () {
                        BlocProvider.of<AppBloc>(
                          context,
                        ).onTapFavorite(context, productDetails: widget.productDetails, onFavTap: widget.onFavTap);
                      },
                      style: style,
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopPositionView(ProductItemStyle style) {
    if (widget.onCommentTap != null) {
      return buildIcon(
        path: AppImages.icMessages,
        onTap: widget.onCommentTap,
        style: style,
        backgroundColor: widget.isCommentSelected ? style.myBagDividerColor : null,
        iconColor: widget.isCommentSelected ? style.commentSelectedColor : null,
      );
    } else if (widget.onCancelTap != null) {
      return buildIcon(path: AppImages.icCancel, onTap: widget.onCancelTap, style: style, backgroundColor: Colors.transparent);
    } else if (widget.isCustomisable) {
      return buildIcon(path: AppImages.icCustomisable, style: style, borderColor: style.borderColor);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildIcon({
    required String path,
    Function()? onTap,
    required ProductItemStyle style,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
  }) {
    return Bounceable(
      onTap: onTap,
      scaleFactor: 0.5,
      child: Badge(
        label: SmartText('2', style: style.badgeTextStyle),
        backgroundColor: style.primaryColor,
        isLabelVisible: widget.isBadgeVisible,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? style.backgroundColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: borderColor ?? style.transparentColor),
          ),
          height: 30.w,
          width: 30.w,
          alignment: AlignmentDirectional.center,
          child: SmartImage(path: path, height: 20.w, width: 20.w, fit: BoxFit.contain, color: iconColor),
        ),
      ),
    );
  }

  Widget productDetailsSection(BuildContext context, double width, ProductItemStyle style) {
    return Flexible(
      child: Container(
        width: width,
        color: style.backgroundColor,
        padding: EdgeInsetsDirectional.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText(
              widget.productDetails.title ?? widget.productDetails.productSku ?? widget.productDetails.contractNoSkuNo,
              style: style.diamondTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SmartText(
              "${widget.productDetails.subTitle ?? widget.productDetails.name ?? ''}\n\n",
              style: style.productNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// Below Lines are commented as they are not required in the current implementation as discussed in the client call
            /*if (productDetails.kgkCollectionName.isNotNullNorEmpty || isFromWatchlist)
              SmartText(
                "${productDetails.kgkCollectionName ?? ''}\n",
                style: style.priceTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                optionalPadding: EdgeInsetsDirectional.only(top: 8.h),
              ),
            if (productDetails.businessCategoryName.isNotNullNorEmpty || isFromWatchlist)
              SmartText(
                "${productDetails.businessCategoryName ?? ''}\n",
                style: style.productNameStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),*/
            SizedBox(height: 8.h),
            if (!widget.isHidePriceView)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SmartText(
                          widget.productDetails.finalPrice.isNotNullNorEmpty
                              ? "${widget.productDetails.finalPrice}\n"
                              : widget.productDetails.originalPrice,
                          style: style.priceTextStyle,
                          optionalPadding: EdgeInsetsDirectional.only(end: 8.w),
                          maxLines: 1,
                        ),
                        if (widget.productDetails.finalPrice.isNotNullNorEmpty && widget.productDetails.isShowDiscountPrice) ...[
                          SmartText(
                            widget.productDetails.originalPrice ?? ' ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: style.checkedPriceStyle,
                          ),
                        ] else ...[
                          if (!widget.isKGKCouture)
                            SmartText(" \n", maxLines: 1, overflow: TextOverflow.ellipsis, style: style.checkedPriceStyle),
                        ],
                      ],
                    ),
                  ),
                  if ((widget.isStoneWithPrice && widget.productDetails.ctsOrGms != null))
                    SmartImage(
                      path:
                          widget.productDetails.ctsOrGms! > 0.1
                              ? AppImages.icOneRing
                              : widget.productDetails.ctsOrGms! > 0.2
                              ? AppImages.icTwoRing
                              : AppImages.icThreeRing,
                      height: 20.w,
                      width: 20.w,
                      fit: BoxFit.fill,
                    ),
                ],
              ),

            // if (productDetails.discountPercentageString.isNotNullNorEmpty) ...[
            //   SizedBox(height: 4.h),
            //   SmartText(
            //     productDetails.discountPercentageString,
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //     style: style.discountTextStyle,
            //   ),
            // ],
            if (!widget.isHomeView && (widget.isCrtAndGramVisible || widget.isFromWatchlist)) diamondAndGramSection(style),
            if (widget.isForAuction) SizedBox(height: 40.w),
            if (widget.onAddToBagTap != null)
              SmartButton(
                height: 32.w,
                margin: EdgeInsetsDirectional.only(top: 8.h),
                padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                titleStyle: style.buttonTextStyle,
                onTap: () {
                  if (widget.buttonText.isNullOrEmpty) {
                    if (widget.productDetails.isAddedToCart) {
                      BlocProvider.of<LandingBloc>(
                        context,
                      ).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context, isForce: true));
                      context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                    } else {
                      BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(widget.productDetails, context));
                    }
                  } else {
                    widget.onAddToBagTap?.call();
                  }
                },
                title: widget.buttonText ?? (widget.productDetails.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr),
                prefixImage: widget.prefixImage,
                isShadow: false,
                imageSize: widget.imageSize ?? 16.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget diamondAndGramSection(ProductItemStyle style) {
    if (widget.productDetails.cts.isNullOrEmpty && widget.productDetails.gms.isNullOrEmpty) {
      return SizedBox(height: 24.h);
    }
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Row(
              children: [
                if (widget.productDetails.cts.isNotNullNorEmpty) ...[
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: SmartText(
                            widget.productDetails.cts,
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
                if (widget.productDetails.gms.isNotNullNorEmpty)
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SmartImage(path: AppImages.icGram, height: 16.w, width: 16.w),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: SmartText(
                            widget.productDetails.gms,
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
