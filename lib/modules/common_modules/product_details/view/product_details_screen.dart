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
              onFavorite: () {},
            );
          },
        ),
      ),
      body: getScaffoldBody(productDetailsBloc, style),
      floatingActionButton: _buildCompareButton(productDetailsBloc, style),
      bottomNavigationBar: _buildBottomNavigationBar(productDetailsBloc, style),
    );
  }

  Widget _buildBottomNavigationBar(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return SafeArea(
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        buildWhen: (previous, current) => current is ProductDetailsLoadedState,
        builder: (context, state) {
          return Container(
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
                        onTap: () {},
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
          );
        },
      ),
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
                  backgroundColor: colors(context).primary,
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
      child: SingleChildScrollView(
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductDetailsLoadedState,
          builder: (context, state) {
            return Column(
              children: [
                _imageSlider(productDetailsBloc),
                SizedBox(height: 40.h),
                _productDetail(style, productDetailsBloc, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _imageSlider(ProductDetailsBloc productDetailsBloc) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: productDetailsBloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: productDetailsBloc.controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.5,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    productDetailsBloc.add(OnProductImageChangeEvent(index));
                  }),
            ),
            if (productDetailsBloc.isCustomisation)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SmartImage(
                    path: AppImages.ic360,
                    height: 36.w,
                    width: 36.w,
                  ),
                  onPressed: () {},
                ),
              )
          ],
        ),
        BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          buildWhen: (previous, current) => current is ProductImagePageChangeState,
          builder: (context, state) {
            final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: productDetailsBloc.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => productDetailsBloc.controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0.w,
                    height: 10.0.w,
                    margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: productDetailsBloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _productDetail(ProductDetailsStyle style, ProductDetailsBloc productDetailsBloc, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _productTypeAndCode(style),
          SizedBox(height: 8.h),
          SmartText(productDetailsBloc.productName, style: style.productNameStyle),
          SizedBox(height: 8.h),
          _buildRatingBarAndReviews(style),
          SizedBox(height: 16.h),
          _compareWidget(productDetailsBloc, style),
          Divider(height: 48.h),
          _buildPriceDetails(style),
          Divider(height: 48.h),
          _buildCustomizationList(style, productDetailsBloc),
          Divider(height: 48.h),
          if (!productDetailsBloc.isCustomisation) ...[
            ProductCustomiseDescriptionWidget(
              onTap: () {
                context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                  RoutesData.isCustomisationPage: true,
                  RoutesData.productId: productDetailsBloc.productDetails?.productId,
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
          SizedBox(height: 24.h),
          const Divider(),
          _ringDetails(productDetailsBloc, style),
          const Divider(),
          _diamondDetails(productDetailsBloc, style),
          const Divider(),
          SizedBox(height: 24.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 32.h),
          const ProductReviewsDetails(),
          SizedBox(height: 32.h),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            itemCount: 4,
            itemBuilder: (context, index) => const ProductCustomerReviewWidget(),
            separatorBuilder: (_, __) => Divider(height: 32.h),
          ),
          SizedBox(height: 16.h),
          SmartText(APPStrings.viewAllXReviews.tr.interpolate([25]), style: style.viewAllReviewStyle),
          SizedBox(height: 32.h),
          _buildSuggestedProductList(productDetailsBloc, style),
          SizedBox(height: 32.h),
          _buildRecentlyViewedProductList(productDetailsBloc, style),
        ],
      ),
    );
  }

  Widget _productTypeAndCode(ProductDetailsStyle style) {
    return Row(
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
    );
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
          APPStrings.reviews.tr.interpolate([120]),
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

  Widget _buildPriceDetails(ProductDetailsStyle style) {
    return Row(
      children: [
        SmartText('\$1200.00', style: style.priceStyle),
        SizedBox(width: 8.w),
        SmartText('\$1600.00', style: style.originalPriceStyle),
        SizedBox(width: 8.w),
        SmartText('(3% OFF)', style: style.discountStyle),
      ],
    );
  }

  Widget _buildCustomizationList(ProductDetailsStyle style, ProductDetailsBloc productDetailsBloc) {
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
              _settingWidget(APPStrings.brand, 'Flyerfit', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.meleeWeight, 'SA-.25cts Dia-0.28cts', context),
            ],
          ),
        );
      },
    );
  }

  Widget _diamondDetails(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is DiamondDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: productDetailsBloc.isDiamondDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: productDetailsBloc.isDiamondDetailsOpen,
            key: productDetailsBloc.diamondDetailsKey,
            title: SmartText(
              'Diamond details',
              style: style.settingSelectionTitleStyle,
            ),
            trailing: (productDetailsBloc.isDiamondDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              productDetailsBloc.add(const DiamondDetailsToggleEvent());
            },
            children: [
              SizedBox(height: 16.h),
              _settingWidget(APPStrings.shape.tr, 'Engagement Ring', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.quantity, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.totalCarat, '1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.color, 'F-G', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.clarity, 'VS2-SI1', context),
              SizedBox(height: 14.h),
              _settingWidget(APPStrings.setting, 'TypeThree Stone', context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.youMayAlsoLike.tr, style: style.customerReviewTitleStyle),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 12.0,
            runSpacing: 12,
            children: List.generate(productDetailsBloc.suggestedProductList.length, (index) {
              ProductDetails product = productDetailsBloc.suggestedProductList[index];
              return ProductGridItem(
                margin: EdgeInsets.only(bottom: 17.h),
                onEyeTap: () {},
                onFavTap: () {},
                productDetails: product,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyViewedProductList(ProductDetailsBloc productDetailsBloc, ProductDetailsStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.recentlyViewed.tr, style: style.customerReviewTitleStyle),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 12.0,
            runSpacing: 12,
            children: List.generate(productDetailsBloc.recentlyViewedProductList.length, (index) {
              ProductDetails product = productDetailsBloc.recentlyViewedProductList[index];
              return ProductGridItem(
                margin: EdgeInsets.only(bottom: 17.h),
                onEyeTap: () {},
                onFavTap: () {},
                productDetails: product,
              );
            }),
          ),
        ),
      ],
    );
  }
}
