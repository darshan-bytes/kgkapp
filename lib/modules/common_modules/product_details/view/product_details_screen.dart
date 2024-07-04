import 'package:kgk/kgk.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsBloc productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductDetailsLoadedState,
          builder: (context, state) {
            return SmartAppBar(
              title: productDetailsBloc.isCustomisation ? APPStrings.customiseProduct.tr : productDetailsBloc.productName,
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      body: getScaffoldBody(productDetailsBloc, style),
      floatingActionButton: _buildCompareButton(productDetailsBloc, style),
      bottomNavigationBar: _buildBottomNavigationBar(productDetailsBloc, style, context),
    );
  }

  Widget _buildBottomNavigationBar(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style, BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDetailsLoadedState,
      builder: (context, state) {
        return Container(
          decoration: productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 7.r,
                      blurRadius: 7.r,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (productDetailsBloc.isCustomisation) ...[
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SmartText(
                          APPStrings.totalApproxPrice.tr,
                          style: style.totalApproxStyle,
                        ),
                        const Spacer(),
                        SmartText(
                          "\$1,470.00",
                          style: style.totalApproxStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        SmartText(
                          '14K Rose and White Gold',
                          style: style.totalApproxSubStyle,
                        ),
                        const Spacer(),
                        SmartText(
                          "\$120.00",
                          style: style.totalApproxSubStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        SmartText(
                          'Round Diamond 0.5 ct',
                          style: style.totalApproxSubStyle,
                        ),
                        const Spacer(),
                        SmartText(
                          "\$1350.00",
                          style: style.totalApproxSubStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: SmartButton(
                          prefixImage: AppImages.icShoppingBag,
                          title: APPStrings.addToBag.tr,
                          onTap: () {
                            //TODO: Add to bag functionality
                          },
                        ),
                      ),
                      if (!productDetailsBloc.isCustomisation) ...[
                        SizedBox(width: 8.w),
                        SelectionButton(
                          padding: EdgeInsets.all(12.w),
                          isSelected: false,
                          onTap: () {},
                          image: AppImages.icHeart,
                        ),
                        SizedBox(width: 8.w),
                        SelectionButton(
                          padding: EdgeInsets.all(12.w),
                          isSelected: false,
                          onTap: () {},
                          image: AppImages.icShare,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompareButton(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductCompareToggleState,
      builder: (context, state) {
        return productDetailsBloc.isCompare
            ? ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.compareProductPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.ratingGlowColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: style.compareCountBGColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: SmartText('3', style: AppTheme.of(context).primaryButtonStyle.titleStyle),
                    )
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }

  Widget getScaffoldBody(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return SafeArea(
      child: SmartSingleChildScrollView(
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductDetailsLoadedState,
          builder: (context, state) {
            return Column(
              children: [
                SmartCarouselSlider(
                  imgList: productDetailsBloc.imgList,
                  controller: productDetailsBloc.controller,
                  on360Tap: productDetailsBloc.isCustomisation ? () {} : null,
                ),
                SizedBox(height: 40.h),
                _productDetail(style, productDetailsBloc, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _productDetail(ProductDetailsStyle style, ProductDetailsBloc productDetailsBloc, BuildContext context) {
    printWrapped("productDetailsBloc.screenIdentifier==${productDetailsBloc.screenIdentifier}");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _productTypeAndCode(style, productDetailsBloc),
          SizedBox(height: 8.h),
          SmartText(productDetailsBloc.productName, style: style.productNameStyle),
          SizedBox(height: 8.h),
          _buildRatingBarAndReviews(style),
          SizedBox(height: 16.h),
          _compareWidget(productDetailsBloc, style),
          Divider(height: 48.h),
          _buildPriceDetails(style, productDetailsBloc),
          Divider(height: 48.h),
          _buildCustomizationList(productDetailsBloc),
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing) Divider(height: 48.h),
          if (!productDetailsBloc.isCustomisation && productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            ProductCustomiseDescriptionWidget(
              onTap: () {
                context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                  RoutesData.isCustomisationPage: true,
                  RoutesData.productId: productDetailsBloc.productDetails?.productId,
                  RoutesData.isPageFor: productDetailsBloc.screenIdentifier
                });
              },
            ),
            Divider(height: 48.h),
          ],
          Row(
            children: [
              SmartImage(
                path: AppImages.icDiamond,
                height: 24.w,
                width: 24.w,
              ),
              SizedBox(width: 16.w),
              SmartText(
                APPStrings.diamondPurityYouCanTrust.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              SizedBox(width: 16.w),
              SmartText(
                APPStrings.shippingAcrossAllCountries.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            SizedBox(height: 24.h),
            const Divider(),
            _ringDetails(productDetailsBloc, style),
            const Divider(),
            _diamondDetails(productDetailsBloc, style),
            const Divider(),
            _gemstoneDetails(productDetailsBloc, style),
            const Divider(),
          ],
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForGemstones) ...[
            SizedBox(height: 24.h),
            const Divider(),
            _diamondDetails(productDetailsBloc, style),
            const Divider(),
          ],
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForDiamonds) ...[
            SizedBox(height: 24.h),
            const Divider(),
            InkWell(
              onTap: () {
                context.pushNamed(AppRoutes.diamondInfoPopupPage);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        APPStrings.diamondDetails.tr,
                        style: style.settingSelectionTitleStyle,
                      ),
                    ),
                    SmartImage(path: AppImages.icRight, height: 20.w, width: 20.w),
                  ],
                ),
              ),
            ),
            const Divider(),
          ],
          SizedBox(height: 24.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 24.h),
          const Divider(),
          SizedBox(height: 24.h),
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            const ProductReviewsDetails(),
            SizedBox(height: 32.h),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: productDetailsBloc.reviewList.length > 5 ? 5 : productDetailsBloc.reviewList.length,
              itemBuilder: (context, index) => ProductCustomerReviewWidget(reviewDataModel: productDetailsBloc.reviewList[index]),
              separatorBuilder: (_, __) => Divider(height: 32.h),
            ),
            if (productDetailsBloc.reviewList.length > 5) ...[
              SizedBox(height: 16.h),
              SmartText(APPStrings.viewAllXReviews.tr.interpolate([25]), style: style.viewAllReviewStyle, onTap: () {
                context.pushNamed(AppRoutes.allReviewPage, arguments: {RoutesData.productId: productDetailsBloc.productDetails?.productId});
              }),
            ],
            SizedBox(height: 32.h),
          ],
          _buildSuggestedProductList(productDetailsBloc, style),
          if (productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing ||
              productDetailsBloc.screenIdentifier == ScreenIdentifier.productForGemstones) ...[
            SizedBox(height: 32.h),
            _buildRecentlyViewedProductList(productDetailsBloc, style),
          ]
        ],
      ),
    );
  }

  Widget _productTypeAndCode(ProductDetailsStyle style, ProductDetailsBloc productDetailsBloc) {
    return productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing
        ? Row(
            children: [
              SmartText('Martin Flyer', style: style.productTypeStyle),
              SizedBox(width: 8.w),
              Container(
                height: 4.w,
                width: 4.w,
                decoration: BoxDecoration(
                    color: style.dotColor,
                    border: Border.all(
                      color: style.dotColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.r))),
              ),
              SizedBox(width: 8.w),
              SmartText('DERC03RDA', style: style.productCodeStyle),
            ],
          )
        : SmartText('SKU 14178065', style: style.productCodeStyle);
  }

  Widget _buildRatingBarAndReviews(ProductDetailsStyle style) {
    return Row(
      children: [
        SmartRatingBar(
          initialRating: 3,
          itemSize: 16,
          onRatingUpdate: (value) {},
          ignoreGestures: true,
        ),
        SizedBox(width: 8.w),
        SmartText(
          APPStrings.reviewsX.tr.interpolate([120]),
          style: style.productCodeStyle,
        )
      ],
    );
  }

  Widget _compareWidget(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: productDetailsBloc.isCompare,
          onChanged: (value) {
            productDetailsBloc.add(const ToggleCompareProductEvent());
          },
          label: APPStrings.compareProduct.tr,
          labelStyle: style.compareProductStyle,
        );
      },
    );
  }

  Widget _buildPriceDetails(ProductDetailsStyle style, ProductDetailsBloc productDetailsBloc) {
    return productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing
        ? Row(
            children: [
              SmartText('\$1200.00', style: style.priceStyle),
              SizedBox(width: 8.w),
              SmartText('\$1600.00', style: style.originalPriceStyle),
              SizedBox(width: 8.w),
              SmartText('(3% OFF)', style: style.discountStyle),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText('\$3,020', style: style.priceStyle),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  SmartText(APPStrings.wantToSeeProductPhysically.tr, style: style.productCodeStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SmartText(APPStrings.orderSample.tr, style: style.orderSampleStyle),
                  ),
                ],
              ),
            ],
          );
  }

  Widget _buildCustomizationList(ProductDetailsBloc productDetailsBloc) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productDetailsBloc.productCustomizations.length,
      itemBuilder: (context, index) => ProductDetailsCustomizations(index: index),
      separatorBuilder: (_, __) => Divider(height: 48.h),
    );
  }

  Widget _ringDetails(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is RingDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: productDetailsBloc.isRingDetailsOpen ? EdgeInsets.only(bottom: 28.h) : EdgeInsets.zero,
          child: SmartExpansionTile(
            key: productDetailsBloc.ringDetailsKey,
            title: SmartText(
              'Ring details',
              style: style.settingSelectionTitleStyle,
            ),
            trailing: (productDetailsBloc.isRingDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              productDetailsBloc.add(const RingDetailsToggleEvent());
            },
            children: [
              SizedBox(height: 16.h),
              _settingWidget(APPStrings.productType.tr, 'Engagement Ring', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.brand.tr, 'Flyerfit', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.meleeWeight.tr, 'SA-.25cts Dia-0.28cts', context),
            ],
          ),
        );
      },
    );
  }

  Widget _diamondDetails(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDiamondDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: productDetailsBloc.isDiamondDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: productDetailsBloc.isDiamondDetailsOpen,
            key: productDetailsBloc.diamondDetailsKey,
            title: SmartText(
              productDetailsBloc.screenIdentifier == ScreenIdentifier.productForRing
                  ? APPStrings.diamondDetails.tr
                  : APPStrings.productDetails.tr,
              style: style.settingSelectionTitleStyle,
            ),
            trailing: (productDetailsBloc.isDiamondDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              productDetailsBloc.add(const ProductDiamondDetailsToggleEvent());
            },
            children: [
              SizedBox(height: 16.h),
              _settingWidget(APPStrings.shape.tr, 'Engagement Ring', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.quantity.tr, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.totalCarat.tr, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.color.tr, 'F-G', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.clarity.tr, 'VS2-SI1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.setting.tr, 'TypeThree Stone', context),
            ],
          ),
        );
      },
    );
  }

  Widget _gemstoneDetails(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is GemstoneDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: productDetailsBloc.isGemstoneDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: productDetailsBloc.isGemstoneDetailsOpen,
            key: productDetailsBloc.gemstoneDetailsKey,
            title: SmartText(
              'Gemstone details',
              style: style.settingSelectionTitleStyle,
            ),
            trailing: (productDetailsBloc.isGemstoneDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              productDetailsBloc.add(const GemstoneDetailsToggleEvent());
            },
            children: [
              SizedBox(height: 16.h),
              _settingWidget(APPStrings.shape.tr, 'Engagement Ring', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.quantity.tr, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.totalCarat.tr, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.color.tr, 'F-G', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.clarity.tr, 'VS2-SI1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.setting.tr, 'TypeThree Stone', context),
            ],
          ),
        );
      },
    );
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(type, style: style.settingTypeStyle),
        SmartText(value, style: style.settingValueStyle),
      ],
    );
  }

  Widget _buildSuggestedProductList(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return SmartSuggestionProductList(
        title: APPStrings.youMayAlsoLike.tr,
        onViewAllTap: () {},
        suggestedProductList: productDetailsBloc.suggestedProductList,
        onEyeTap: () {},
        onFavTap: () {},
        isPaddingNeeded: false,
        scrollController: productDetailsBloc.youMayLikeScrollController);
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       children: [
    //         SmartText(APPStrings.youMayAlsoLike.tr, style: style.customerReviewTitleStyle),
    //         const Spacer(),
    //         SmartText(
    //           APPStrings.viewAll.tr,
    //           optionalPadding: EdgeInsets.only(right: 17.w),
    //         ),
    //       ],
    //     ),
    //     SizedBox(height: 16.h),
    //     Scrollbar(
    //       controller: productDetailsBloc.youMayLikeScrollController,
    //       thumbVisibility: true,
    //       child: SmartSingleChildScrollView(
    //         controller: productDetailsBloc.youMayLikeScrollController,
    //         scrollDirection: Axis.horizontal,
    //         child: Wrap(
    //           direction: Axis.horizontal,
    //           spacing: 12.0,
    //           runSpacing: 12,
    //           children: List.generate(productDetailsBloc.suggestedProductList.length, (index) {
    //             ProductDetails product = productDetailsBloc.suggestedProductList[index];
    //             return ProductGridItem(
    //               margin: EdgeInsets.only(bottom: 17.h),
    //               onEyeTap: () {},
    //               onFavTap: () {},
    //               productDetails: product,
    //               isStoneWithPrice: productDetailsBloc.screenIdentifier == ScreenIdentifier.productForDiamonds,
    //             );
    //           }),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildRecentlyViewedProductList(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return SmartSuggestionProductList(
        title: APPStrings.recentlyViewed.tr,
        onViewAllTap: () {},
        suggestedProductList: productDetailsBloc.recentlyViewedProductList,
        onEyeTap: () {},
        onFavTap: () {},
        isPaddingNeeded: false,
        scrollController: productDetailsBloc.recentViewScrollController);
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     SmartText(APPStrings.recentlyViewed.tr, style: style.customerReviewTitleStyle),
    //     SizedBox(height: 16.h),
    //     Scrollbar(
    //       controller: productDetailsBloc.recentViewScrollController,
    //       thumbVisibility: true,
    //       child: SmartSingleChildScrollView(
    //         scrollDirection: Axis.horizontal,
    //         controller: productDetailsBloc.recentViewScrollController,
    //         child: Wrap(
    //           direction: Axis.horizontal,
    //           spacing: 12.0,
    //           runSpacing: 12,
    //           children: List.generate(productDetailsBloc.recentlyViewedProductList.length, (index) {
    //             ProductDetails product = productDetailsBloc.recentlyViewedProductList[index];
    //             return ProductGridItem(
    //               margin: EdgeInsets.only(bottom: 17.h),
    //               onEyeTap: () {},
    //               onFavTap: () {},
    //               productDetails: product,
    //             );
    //           }),
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 16.h),
    //   ],
    // );
  }
}
