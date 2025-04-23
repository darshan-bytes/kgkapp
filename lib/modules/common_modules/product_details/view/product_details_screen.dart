import 'package:kgk/kgk.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsBloc bloc = BlocProvider.of<ProductDetailsBloc>(context);
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.appBarHeight,
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductDetailsLoadedState,
          builder: (context, state) {
            return SmartAppBar(
              title: bloc.isCustomisation ? APPStrings.customiseProduct.tr : bloc.productName,
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      body: getScaffoldBody(bloc, style),
      floatingActionButton: bloc.isErrorInLoadingData ? null : _buildCompareButton(bloc, style),
      bottomNavigationBar:
          (bloc.isErrorInLoadingData || bloc.productDetails == null) ? null : _buildBottomNavigationBar(bloc, style, context),
    );
  }

  Widget _buildBottomNavigationBar(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: style.whiteColor,
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.5), spreadRadius: 7.r, blurRadius: 7.r, offset: const Offset(0, 3))],
      ),
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        buildWhen: (previous, current) => current is ProductDetailsLoadedState || current is ProductDetailsAuctionPlaceBidState,
        builder: (context, state) {
          if (bloc.isBidPlaced && !bloc.isMyBidPlaced && state is ProductDetailsAuctionPlaceBidState) {
            return _buildAuctionBidPlaceView(bloc);
          } else {
            if ((bloc.productDetails?.auctionId).isNotNullNorEmpty) {
              return const SizedBox();
            }
            return _buildBottomActionView(bloc, style, context);
          }
        },
      ),
    );
  }

  Widget _buildBottomActionView(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bloc.isCustomisation) ...[
              if (bloc.userType == UserType.b2cUser) ..._buildB2CCustomisationDetails(style),
              if (bloc.userType == UserType.b2bUser) ..._buildB2BCustomisationDetails(bloc, style),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: 66.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmartImage(path: bloc.imgList.isNotEmpty ? bloc.imgList.first : '', height: 54.w, width: 54.w),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SmartText(
                                bloc.productDetails?.finalPrice.isNotNullNorEmpty == true
                                    ? "${bloc.productDetails?.finalPrice}\n"
                                    : bloc.productDetails?.originalPrice,
                                style: style.priceStyle,
                                maxLines: 1,
                                isAutoSizeText: true,
                              ),
                              if (bloc.productDetails?.finalPrice.isNotNullNorEmpty == true &&
                                  (bloc.productDetails?.finalPrice != bloc.productDetails?.originalPrice))
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: SmartText(
                                        bloc.productDetails?.originalPrice,
                                        style: style.originalPriceStyle.copyWith(decoration: TextDecoration.lineThrough, fontSize: 12.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    SmartText(bloc.productDetails?.discountPercentageString, style: style.discountStyle, maxLines: 1),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 4,
                  child: SmartButton(
                    height: 54.h,
                    prefixImage: AppImages.icShoppingBag,
                    title: bloc.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                    onTap: () {
                      bloc.handleBagButtonClick(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildB2CCustomisationDetails(ProductDetailsStyle style) {
    return [
      SizedBox(height: 10.h),
      Row(
        children: [
          SmartText(APPStrings.totalApproxPrice.tr, style: style.totalApproxStyle),
          const Spacer(),
          SmartText("\$1,470.00", style: style.totalApproxStyle),
        ],
      ),
      SizedBox(height: 14.h),
      Row(
        children: [
          SmartText('14K Rose and White Gold', style: style.totalApproxSubStyle),
          const Spacer(),
          SmartText("\$120.00", style: style.totalApproxSubStyle),
        ],
      ),
      SizedBox(height: 14.h),
      Row(
        children: [
          SmartText('Round Diamond 0.5 ct', style: style.totalApproxSubStyle),
          const Spacer(),
          SmartText("\$1350.00", style: style.totalApproxSubStyle),
        ],
      ),
      SizedBox(height: 14.h),
    ];
  }

  List<Widget> _buildB2BCustomisationDetails(ProductDetailsBloc bloc, ProductDetailsStyle style) {
    return [
      Row(
        children: [
          SmartImage(
            path: bloc.productDetails?.imageUrl ?? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
            height: 73.w,
            width: 73.w,
            imageBorderRadius: BorderRadius.circular(7.66.r),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText("C097973", style: style.originalPriceStyle),
                SizedBox(height: 4.h),
                SmartText("14k White & Rose gold Engagement Ring", style: style.bottomNavBarSubTitleStyle, isAutoSizeText: true),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.total.tr, style: style.totalApproxSubStyle),
          SizedBox(width: 16.w),
          Flexible(child: SmartText("\$35,700.00", style: style.totalApproxSubStyle)),
        ],
      ),
      SizedBox(height: 8.h),
    ];
  }

  Widget _buildCompareButton(ProductDetailsBloc bloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductCompareToggleState,
      builder: (context, state) {
        final compareProductBloc = BlocProvider.of<CompareProductBloc>(context);
        return bloc.isCompare
            ? ElevatedButton(
              onPressed: () {
                if (compareProductBloc.productIdList.length < 2) {
                  Utils.showMessage(APPStrings.compareProductMinimum.tr);
                  return;
                } else {
                  context.pushNamed(AppRoutes.compareProductPage);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: style.ratingGlowColor,
                padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 24.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmartText(APPStrings.compare.tr, style: AppTheme.of(context).primaryButtonStyle.titleStyle),
                  SizedBox(width: 16.w),
                  Container(
                    height: 24.w,
                    width: 24.w,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(color: style.compareCountBGColor, borderRadius: BorderRadius.circular(4.r)),
                    child: BlocBuilder<CompareProductBloc, CompareProductState>(
                      buildWhen: (previous, current) => current is CompareProductAddedState,
                      builder: (context, state) {
                        return SmartText(
                          compareProductBloc.productIdList.length.toString(),
                          style: AppTheme.of(context).primaryButtonStyle.titleStyle,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
            : const SizedBox();
      },
    );
  }

  Widget getScaffoldBody(ProductDetailsBloc bloc, ProductDetailsStyle style) {
    return SafeArea(
      child: SmartSingleChildScrollView(
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductDetailsLoadedState,
          builder: (context, state) {
            if (state is ProductDetailsLoadedState) {
              return bloc.isErrorInLoadingData
                  ? getErrorWidget(bloc, context)
                  : Column(
                    children: [
                      Stack(
                        children: [
                          SmartCarouselSlider(
                            imgList: bloc.imgList,
                            controller: bloc.controller,
                            on360Tap:
                                bloc.the3DFile.isNotNullNorEmpty
                                    ? () {
                                      bloc.onTap360Image(context);
                                    }
                                    : null,
                            onVideoTap:
                                bloc.videoUrl.isNotNullNorEmpty
                                    ? () {
                                      bloc.handleVideoTap(context);
                                    }
                                    : null,
                            onTapFullImage: (int index) {
                              bloc.onTapFullImage(context: context, currentIndex: index);
                            },
                          ),
                          if (!bloc.isCustomisation)
                            Padding(
                              padding: EdgeInsetsDirectional.all(12.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (bloc.canAddToWishlist) ...[
                                    SizedBox(width: 8.w),
                                    BlocBuilder<AppBloc, AppState>(
                                      buildWhen:
                                          (previous, current) =>
                                              current is ProductAddToFavoriteState || current is ProductRemoveFromFavoriteState,
                                      builder: (context, state) {
                                        return SelectionButton(
                                          height: 42.w,
                                          width: 42.w,
                                          padding: EdgeInsetsDirectional.all(6.w),
                                          isSelected: false,
                                          onTap: () {
                                            if (bloc.productDetails != null) {
                                              BlocProvider.of<AppBloc>(
                                                context,
                                              ).onTapFavorite(context, productDetails: bloc.productDetails!);
                                            }
                                          },
                                          imageWidth: 20.w,
                                          imageHeight: 20.w,
                                          fit: BoxFit.contain,
                                          image: (bloc.productDetails?.isFavourite ?? false) ? AppImages.icHeartFill : AppImages.icHeart,
                                        );
                                      },
                                    ),
                                  ],
                                  SizedBox(width: 8.w),
                                  SelectionButton(
                                    height: 42.w,
                                    width: 42.w,
                                    padding: EdgeInsetsDirectional.all(6.w),
                                    isSelected: false,
                                    onTap: () async {
                                      if (bloc.productDetails != null) {
                                        String? link = await BlocProvider.of<AppBloc>(
                                          context,
                                        ).handleShareProduct(context: context, productDetails: bloc.productDetails!, isShowLoading: true);
                                        if (link != null) {
                                          Utils.showSmartModalBottomSheet(
                                            context: context,
                                            enableDrag: false,
                                            builder:
                                                (sheetContext) => ShareOptionSheet(
                                                  title: APPStrings.share.tr,
                                                  onTapQrCode: () async {
                                                    sheetContext.pop();
                                                    _showQrCodeDialog(context: context, data: link);
                                                  },
                                                  onTapCopy: () async {
                                                    await Clipboard.setData(ClipboardData(text: link));
                                                    Utils.showMessage(APPStrings.textCopied.tr);
                                                  },
                                                  onTapOther: () async {
                                                    bloc.onTapShareLink(context: sheetContext, link: link);
                                                  },
                                                ),
                                          );
                                        } else {
                                          Utils.showMessage(APPStrings.failedToCreateSharingLink.tr);
                                        }
                                      }
                                    },
                                    image: AppImages.icShare,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _productDetail(style, bloc, context),
                    ],
                  );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _productDetail(ProductDetailsStyle style, ProductDetailsBloc bloc, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _productTypeAndCode(style, bloc),
          SizedBox(height: 8.h),
          SmartText(bloc.productName, style: style.productNameStyle),
          if (bloc.productDetails?.reviewCount != null) ...[SizedBox(height: 8.h), _buildRatingBarAndReviews(style, bloc.productDetails)],
          if (bloc.canCompare) ...[SizedBox(height: 12.h), _compareWidget(bloc, style)],
          SizedBox(height: 16.h),

          /// AUCTION FLOW FOR DIAMOND
          if (bloc.screenIdentifier == ScreenIdentifier.productForDiamonds && (bloc.productDetails?.auctionId).isNotNullNorEmpty) ...[
            BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              buildWhen: (previous, current) => current is ProductDetailsAuctionPlaceBidState,
              builder: (context, state) {
                if (state is ProductDetailsAuctionPlaceBidState) {
                  return auctionRecentBidSection(bloc: bloc);
                }
                return SizedBox.shrink();
              },
            ),
            SizedBox(height: 16.h),
          ],

          /// NOTE : COMMENTED AS OF NOW TO MAKE IT SIMILAR WITH WEB
          // Divider(height: 48.h),
          // _buildCustomizationList(bloc),
          // if (bloc.screenIdentifier == ScreenIdentifier.productForRing) Divider(height: 48.h),
          if (!bloc.isCustomisation && bloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            ProductCustomiseDescriptionWidget(
              onTap: () {
                context.pushNamed(
                  AppRoutes.productDetailsPage,
                  arguments: {
                    RoutesData.isCustomisationPage: true,
                    RoutesData.productId: bloc.productDetails?.productId,
                    RoutesData.isPageFor: bloc.screenIdentifier,
                  },
                );
              },
            ),
            Divider(height: 48.h),
          ],
          Row(
            children: [
              SmartImage(path: AppImages.icDiamond, height: 24.w, width: 24.w),
              SizedBox(width: 16.w),
              SmartText(APPStrings.diamondPurityYouCanTrust.tr, style: style.diamondPurityStyle),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              SizedBox(width: 16.w),
              SmartText(APPStrings.shippingAcrossAllCountries.tr, style: style.diamondPurityStyle),
            ],
          ),
          if (bloc.hasComponents) ...[
            SizedBox(height: 24.h),
            const Divider(),
            ProductDetailsComponentsView(
              commodity: bloc.productDetails?.commodity ?? Commodity.jewellery,
              components: bloc.productDetails?.components,
              stoneElements: bloc.productDetails?.stoneElements,
            ),
          ],
          if (bloc.screenIdentifier == ScreenIdentifier.productForDiamonds) ...[
            SizedBox(height: 24.h),
            const Divider(),
            InkWell(
              onTap: () {
                context.pushNamed(AppRoutes.diamondInfoPopupPage, arguments: {RoutesData.diamondInfo: bloc.diamondData});
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 24.h),
                child: Row(
                  children: [
                    Expanded(child: SmartText(APPStrings.diamondDetails.tr, style: style.settingSelectionTitleStyle)),
                    SmartImage(path: AppImages.icRight, height: 20.w, width: 20.w, matchTextDirection: true),
                  ],
                ),
              ),
            ),
            const Divider(),
          ],
          SizedBox(height: 24.h),
          const InquiryWidget(email: 'enquiry.diaind@kgkmail.com', phone: '+91 - 1234567830'),
          SizedBox(height: 24.h),
          const Divider(),
          if (bloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            SizedBox(height: 24.h),

            ///TODO:Here Need to work on isShowWriteReviewButton
            BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              buildWhen: (previous, current) => current is ProductDetailsLoadedState || current is ProductDetailsRecentlyViewedLoadedState,
              builder: (context, state) {
                return ProductReviewsDetails(
                  isShowEditReview: bloc.isShowEditReview,
                  isShowWriteReviewButton: !bloc.userReviewSubmitted,
                  ratings: List.generate(bloc.reviewList.length, (index) => (bloc.reviewList[index].rating ?? 0)).toList(),
                  averageRating: bloc.productDetails?.rating ?? 0,
                  reviewCount: bloc.productDetails?.reviewCount ?? 0,
                  onTap: () async {
                    bloc.add(ProductDetailsWriteReviewEvent(context));
                  },
                );
              },
            ),

            SizedBox(height: 32.h),
            BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              buildWhen: (previous, current) => current is ProductDetailsRecentlyViewedLoadedState,
              builder: (context, state) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: bloc.reviewList.length > 5 ? 5 : bloc.reviewList.length,
                  itemBuilder: (context, index) => ProductCustomerReviewWidget(reviewDataModel: bloc.reviewList[index]),
                  separatorBuilder: (_, __) => Divider(height: 32.h),
                );
              },
            ),
            if (bloc.reviewList.length > 5) ...[
              SizedBox(height: 16.h),
              SmartText(
                APPStrings.viewAllXReviews.tr.interpolate([bloc.reviewList.length]),
                style: style.viewAllReviewStyle,
                onTap: () {
                  context.pushNamed(AppRoutes.allReviewPage, arguments: {RoutesData.productId: bloc.productDetails?.productId});
                },
              ),
            ],
          ],
          _buildSuggestedProductList(bloc, style, context),
          _buildRecentlyViewedProductList(bloc, style, context),
        ],
      ),
    );
  }

  Widget _productTypeAndCode(ProductDetailsStyle style, ProductDetailsBloc bloc) {
    if (bloc.productDetails == null) return const SizedBox();
    return bloc.screenIdentifier == ScreenIdentifier.productForRing
        ? Row(
          children: [
            if (bloc.productDetails!.brandName.isNotNullNorEmpty) SmartText(bloc.productDetails?.brandName, style: style.productTypeStyle),
            if (bloc.productDetails!.brandName.isNotNullNorEmpty && bloc.productDetails!.productSku.isNotNullNorEmpty) ...[
              SizedBox(width: 8.w),
              Container(
                height: 4.w,
                width: 4.w,
                decoration: BoxDecoration(
                  color: style.dotColor,
                  border: Border.all(color: style.dotColor),
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            if (bloc.productDetails!.productSku.isNotNullNorEmpty)
              SmartText(bloc.productDetails?.productSku, style: style.productCodeStyle),
          ],
        )
        : SmartText(bloc.productDetails?.productSku, style: style.productCodeStyle);
  }

  Widget _buildRatingBarAndReviews(ProductDetailsStyle style, ProductDetailsModel? productDetails) {
    return Row(
      children: [
        SmartRatingBar(initialRating: productDetails?.rating ?? 0, itemSize: 16.w, onRatingUpdate: (value) {}, ignoreGestures: true),
        SizedBox(width: 8.w),
        SmartText(APPStrings.reviewsX.tr.interpolate([productDetails?.reviewCount]), style: style.productCodeStyle),
      ],
    );
  }

  Widget _compareWidget(ProductDetailsBloc bloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductCompareToggleState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SmartCheckbox(
                value: bloc.isCompare,
                onChanged: (value) {
                  bloc.add(ToggleCompareProductEvent(context: context));
                },
                label: APPStrings.compareProduct.tr,
                labelStyle: style.compareProductStyle,
              ),
            ),
            SelectionButton(
              height: 42.w,
              width: 42.w,
              padding: EdgeInsetsDirectional.all(6.w),
              isSelected: false,
              onTap: () {
                context.pushNamed(
                  AppRoutes.makeInquiryPage,
                  arguments: {
                    RoutesData.inquiryContextId: bloc.productDetails?.suid,
                    RoutesData.contextId: bloc.productDetails?.contractNoSkuNo,
                    RoutesData.commodity: bloc.productDetails?.commodity?.value,
                  },
                );
              },
              imageWidth: 20.w,
              imageHeight: 20.w,
              fit: BoxFit.contain,
              image: AppImages.icInquiries,
              matchTextDirection: true,
            ),
          ],
        );
      },
    );
  }

  /// Right now not used anywhere but can be used in future
  Widget _buildPriceDetails(ProductDetailsStyle style, ProductDetailsBloc bloc) {
    return bloc.screenIdentifier == ScreenIdentifier.productForRing
        ? Row(
          children: [
            SmartText('\$1200.00', style: style.priceStyle),
            SizedBox(width: 8.w),
            SmartText('\$1600.00', style: style.originalPriceStyle),
            SizedBox(width: 8.w),
            SmartText(APPStrings.percentageOffInterpolating.interpolate(["3"]), style: style.discountStyle),
          ],
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText('\$3,020', style: style.priceStyle),
            SizedBox(height: 8.h),
            Row(
              children: [
                SmartText(APPStrings.wantToSeeProductPhysically.tr, style: style.productCodeStyle),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  child: SmartText(APPStrings.orderSample.tr, style: style.orderSampleStyle),
                ),
              ],
            ),
          ],
        );
  }

  Widget _buildCustomizationList(ProductDetailsBloc bloc) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bloc.productCustomizations.length,
      itemBuilder: (context, index) => ProductDetailsCustomizations(index: index),
      separatorBuilder: (_, __) => Divider(height: 48.h),
    );
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [SmartText(type, style: style.settingTypeStyle), SmartText(value, style: style.settingValueStyle)],
    );
  }

  Widget _buildSuggestedProductList(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDetailsSuggestedLoadedState,
      builder: (context, state) {
        if (bloc.suggestedProductList.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32.h),
            SmartSuggestionProductList(
              onAddToBagTap: () {},
              title: APPStrings.youMayAlsoLike.tr,
              onViewAllTap:
                  bloc.suggestedProductList.length > 5
                      ? () => bloc.navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(
                        context,
                        productNavigation: AppConst.youMayLike,
                        productId: bloc.productId,
                      )
                      : null,
              suggestedProductList: bloc.suggestedProductList,
              onProductTap: (product) {
                context.pushNamed(
                  AppRoutes.productDetailsPage,
                  arguments: {RoutesData.productId: product.suid, RoutesData.isPageFor: bloc.screenIdentifier},
                );
              },
              onEyeTap: () {},
              onFavTap: () {},
              isPaddingNeeded: false,
              scrollController: bloc.youMayLikeScrollController,
              isCrtAndGramVisible: false,
              margin: EdgeInsetsDirectional.zero,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecentlyViewedProductList(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDetailsRecentlyViewedLoadedState,
      builder: (context, state) {
        if (bloc.recentlyViewedProductList.isNotNullNorEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32.h),
              SmartSuggestionProductList(
                onAddToBagTap: () {},
                title: APPStrings.recentlyViewed.tr,
                onViewAllTap:
                    bloc.recentlyViewedProductList.length > 5
                        ? () {
                          bloc.navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(
                            context,
                            productNavigation: AppConst.recentlyViewed,
                          );
                        }
                        : null,
                suggestedProductList: bloc.recentlyViewedProductList,
                onProductTap: (product) {
                  context.pushNamed(
                    AppRoutes.productDetailsPage,
                    arguments: {RoutesData.productId: product.suid, RoutesData.isPageFor: bloc.screenIdentifier},
                  );
                },
                onEyeTap: () {},
                onFavTap: () {},
                isPaddingNeeded: false,
                scrollController: bloc.recentViewScrollController,
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget getErrorWidget(ProductDetailsBloc bloc, BuildContext context) {
    final NoDataFoundStyle style = AppTheme.of(context).noDataFoundStyle;
    return Padding(
      padding: EdgeInsetsDirectional.all(16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmartText(APPStrings.somethingWrong.tr, style: style.titleStyle),
            SizedBox(height: 16.h),
            SmartButton(
              title: APPStrings.retry.tr,
              onTap: () {
                bloc.add(LoadProductDetailsEvent(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  _showQrCodeDialog({required BuildContext context, required String data}) {
    final QRCodeDialogStyle style = AppTheme.of(context).qrCodeDialogStyle;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.all(24.w),
                  decoration: BoxDecoration(
                    color: style.whiteColor,
                    boxShadow: [BoxShadow(color: style.shadowColor, blurRadius: 15.0, spreadRadius: 5.0)],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 56.w,
                        width: 56.w,
                        decoration: BoxDecoration(border: Border.all(color: style.borderColor), borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(Icons.qr_code_2_outlined, size: 42.w, color: style.primaryColor),
                      ),
                      SizedBox(height: 16.h),
                      SmartText(APPStrings.scanThisQRCode.tr, style: style.titleStyle),
                      SizedBox(height: 8.h),
                      SmartText(APPStrings.scanThisQRCodeDetails.tr, style: style.subTitleStyle, textAlign: TextAlign.center),
                      SizedBox(height: 20.h),
                      QrImageView(data: data, version: QrVersions.auto, size: 245.w, backgroundColor: style.whiteColor),
                    ],
                  ),
                ),
                PositionedDirectional(
                  end: 20.w,
                  top: 20.h,
                  child: SmartImage(
                    path: AppImages.icCross,
                    height: 24.w,
                    width: 24.w,
                    color: style.primaryColor,
                    onTap: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget auctionRecentBidSection({required ProductDetailsBloc bloc}) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen:
          (previous, current) => current is ProductDetailsAuctionTimerUpdateState || current is ProductDetailsAuctionTimerCompletedState,
      builder: (context, state) {
        final style = AppTheme.of(context).auctionScreenStyle;
        bloc.getTimerText(state);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStartingBid(bloc, style),
            SizedBox(height: 12.h),
            _buildRecentBidsContainer(bloc, style, context),
            SizedBox(height: 12.h),
            _buildBidStatus(bloc, style),
          ],
        );
      },
    );
  }

  Widget _buildStartingBid(ProductDetailsBloc bloc, AuctionScreenStyle style) {
    return SmartRichText(
      spans: [
        SmartTextSpan(text: APPStrings.startingBidPrice.tr, style: style.auctionTimerStyle),
        SmartTextSpan(text: " ${bloc.startingBidPrice}", style: style.recentBidValueStyle),
      ],
    );
  }

  Widget _buildRecentBidsContainer(ProductDetailsBloc bloc, AuctionScreenStyle style, BuildContext context) {
    return Container(
      key: bloc.targetKey,
      decoration: BoxDecoration(
        color: style.recentBidBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: style.borderColor),
      ),
      padding: EdgeInsetsDirectional.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SmartText(bloc.timerTitle, style: style.auctionTimerStyle),
              SizedBox(width: 8.w),
              Flexible(child: SmartText(bloc.timerValue, style: style.recentBidStyle)),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 10.h),
          if (bloc.recentBidList.isNotEmpty) ...[
            _buildRecentBidHeader(bloc, style, context),
            SizedBox(height: 10.h),
            _buildRecentBidsList(bloc, style),
          ] else ...[
            Center(child: SmartText(APPStrings.noBidsFound.tr, textAlign: TextAlign.center)),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentBidHeader(ProductDetailsBloc bloc, AuctionScreenStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.recentBid.tr, style: style.recentBidStyle),
          if (bloc.recentBidList.length > 5) _buildViewAllBidsButton(context, style, bloc.recentBidList),
        ],
      ),
    );
  }

  Widget _buildViewAllBidsButton(BuildContext context, AuctionScreenStyle style, List<Map<String, dynamic>> recentBidList) {
    return InkWell(
      onTap: () async {
        await Utils.showSmartModalBottomSheet(context: context, builder: (context) => AllBidsBottomSheet(recentBidList: recentBidList));
      },
      child: Row(
        children: [
          SmartText(APPStrings.viewAll.tr, style: style.auctionTimerStyle),
          SizedBox(width: 8.w),
          Container(
            height: 24.w,
            width: 24.w,
            alignment: AlignmentDirectional.center,
            child: const SmartImage(path: AppImages.icArrowRight),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBidsList(ProductDetailsBloc bloc, AuctionScreenStyle style) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bloc.recentBidList.length > 5 ? 5 : bloc.recentBidList.length,
      itemBuilder: (context, index) {
        return _buildBidItem(
          isMyBid: bloc.recentBidList[index][AppConst.isMyBidKey] ?? false,
          labelText: bloc.recentBidList[index][AppConst.dateTimeKey] ?? '',
          value: bloc.recentBidList[index][AppConst.priceKey] ?? '',
          style: style,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
    );
  }

  Widget _buildBidStatus(ProductDetailsBloc bloc, AuctionScreenStyle style) {
    if (bloc.isMyBidPlaced) {
      return Row(
        children: [
          const SmartImage(path: AppImages.icSuccessPlaceBid),
          SizedBox(width: 8.w),
          SmartRichText(
            spans: [
              SmartTextSpan(text: APPStrings.yourBidOf.tr, style: style.auctionTimerStyle),
              SmartTextSpan(text: " ${bloc.auctionDataModel?.myBidValue} ", style: style.recentBidValueStyle),
              SmartTextSpan(text: APPStrings.hasBeenPlaced.tr, style: style.auctionTimerStyle),
            ],
          ),
        ],
      );
    }
    return SmartText(APPStrings.enterBidAmountHigherThanX.tr.interpolate([bloc.startingBidPrice]), style: style.auctionTimerStyle);
  }

  Widget _buildBidItem({required String labelText, required String value, required AuctionScreenStyle style, bool isMyBid = false}) {
    return Row(
      children: [
        const SmartImage(path: AppImages.icCalendar),
        SizedBox(width: 8.w),
        Expanded(
          child: Row(
            children: [
              Expanded(child: SmartText(labelText, style: style.auctionTimerStyle, isAutoSizeText: true)),
              SizedBox(width: 5.w),
              if (isMyBid) _buildMyBidTag(style),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        SmartText(value, style: style.recentBidValueStyle),
      ],
    );
  }

  Widget _buildMyBidTag(AuctionScreenStyle style) {
    return Container(
      decoration: BoxDecoration(color: style.myBidBackgroundColor, borderRadius: BorderRadius.circular(23.r)),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
      child: SmartText(APPStrings.myBid.tr, style: style.myBidTextStyle),
    );
  }

  Widget _buildAuctionBidPlaceView(ProductDetailsBloc bloc) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is BidAmountFieldErrorState && current.fieldType == FieldTypeValidationEnum.bidAmount,
      builder: (context, state) {
        AuctionScreenStyle style = AppTheme.of(context).auctionScreenStyle;
        return SafeArea(
          minimum: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SmartText(APPStrings.enterBidAmountHigherThanX.tr.interpolate([bloc.startingBidPrice]), style: style.auctionTimerStyle),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: SmartTextField(
                        height: 42.h,
                        contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                        controller: bloc.bidAmountController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        maxLines: 1,
                        errorText: bloc.bidAmountError,
                        onValueChanges: (value) {
                          if (bloc.bidAmountError.isNotNullNorEmpty) {
                            bloc.add(ProductDetailsPlaceBidFieldChangeEvent(fieldType: FieldTypeValidationEnum.bidAmount));
                          }
                        },
                        suffixIcon: SmartButton(
                          width: 134.w,
                          height: 42.h,
                          title: APPStrings.placeBid.tr,
                          borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                          onTap: () {
                            bloc.add(ProductDetailsAuctionPlaceBidEvent(context, bloc.bidAmountController.text));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
