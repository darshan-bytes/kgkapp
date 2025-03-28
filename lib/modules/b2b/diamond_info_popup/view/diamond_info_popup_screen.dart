import 'package:kgk/kgk.dart';

class DiamondInfoPopupScreen extends StatelessWidget {
  const DiamondInfoPopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiamondInfoPopupBloc bloc = BlocProvider.of<DiamondInfoPopupBloc>(context);
    final DiamondInfoPopupScreenStyle style = AppTheme.of(context).diamondInfoPopupScreenStyle;

    return BlocBuilder<DiamondInfoPopupBloc, DiamondInfoPopupState>(
      builder: (context, state) {
        final ProductInfoModel productInfoModel = bloc.productInfoModel;
        return Scaffold(
          appBar: SmartAppBar(title: APPStrings.diamonds.tr),
          bottomNavigationBar: _buildBottomNavigationBar(context, productInfoModel, bloc),
          body: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
            child: SmartSingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  _buildImageSlider(bloc),
                  if (productInfoModel.productName.isNotNullNorEmpty) ...[
                    SizedBox(height: 16.h),
                    SmartText(
                      productInfoModel.productName,
                      style: style.productNameStyle,
                    ),
                  ],
                  if (productInfoModel.originalPrice.isNotNullNorEmpty) ...[
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 4.h,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: SmartText(
                              productInfoModel.offerPrice.isNotNullNorEmpty ? productInfoModel.offerPrice : productInfoModel.originalPrice,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: style.offerPriceStyle,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Flexible(
                            child: SmartText(
                              productInfoModel.originalPrice,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: style.actualPriceStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const Divider(),
                    SizedBox(height: 16.h),
                  ],
                  _buildBasicInfo(productInfoModel, style, bloc),
                  SizedBox(height: 8.h),

                  /// Below code is commented as of now, because for noe there is only one section's data available
                  // const Divider(),
                  // SizedBox(height: 16.h),
                  // _buildMeasurementsInfo(productInfoModel, style),
                  // SizedBox(height: 8.h),
                  // const Divider(),
                  // SizedBox(height: 16.h),
                  // _buildInclusionInfo(productInfoModel, style),
                  // SizedBox(height: 8.h),
                  // const Divider(),
                  // SizedBox(height: 16.h),
                  // _buildOtherInfo(productInfoModel, style),
                  // SizedBox(height: 8.h),
                  // const Divider(),
                  // SizedBox(height: 16.h),
                  // _buildPriceDetailsInfo(productInfoModel, style),
                  // SizedBox(height: 16.h),
                  const Divider(),
                  SizedBox(height: 24.h),
                  _buildInquirySection(context),
                  //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                  // SizedBox(height: 24.h),
                  // InkWell(
                  //   onTap: () {
                  //     context.pushNamed(AppRoutes.productDetailsPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForDiamonds});
                  //   },
                  //   child: Center(
                  //     child: SmartText(
                  //       APPStrings.viewMoreDetails.tr,
                  //       style: style.viewMoreDetailsTextStyle,
                  //       optionalPadding: REdgeInsets.symmetric(vertical: 12.h),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSlider(DiamondInfoPopupBloc bloc) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        CarouselSlider(
          items: bloc.imgList.map((e) {
            return SmartImage(path: e);
          }).toList(),
          carouselController: bloc.controller,
          options: CarouselOptions(
            autoPlay: bloc.imgList.length > 1,
            viewportFraction: 1.5,
            aspectRatio: 1,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
        ),
        if (bloc.imgList.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                height: 24.w,
                width: 24.w,
                child: InkWell(
                  onTap: () => bloc.controller.previousPage(),
                  child: const Center(
                    child: SmartImage(
                      path: AppImages.icArrowLeft,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                height: 24.w,
                width: 24.w,
                child: InkWell(
                  onTap: () => bloc.controller.nextPage(),
                  child: const Center(
                    child: SmartImage(
                      path: AppImages.icArrowRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildBasicInfo(ProductInfoModel productInfoModel, DiamondInfoPopupScreenStyle style, DiamondInfoPopupBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.productDetails.tr, style: style.labelStyle),
        SizedBox(height: 12.h),
        ...List.generate(bloc.diamondDatum?.components.length ?? 0, (index) {
          StoneElement stoneElement = bloc.diamondDatum!.components[index];
          return _buildProductInfoItem(stoneElement.title ?? '', stoneElement.value, style);
        }),
      ],
    );
  }

  Widget _buildMeasurementsInfo(ProductInfoModel productInfoModel, DiamondInfoPopupScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.measurements.tr, style: style.labelStyle),
        SizedBox(height: 12.h),
        _buildProductInfoItem(APPStrings.tablePercentage.tr, productInfoModel.tablePercentage, style),
        _buildProductInfoItem(APPStrings.depthPercentage.tr, productInfoModel.depthPercentage, style),
        _buildProductInfoItem(APPStrings.length.tr, productInfoModel.length, style),
        _buildProductInfoItem(APPStrings.width.tr, productInfoModel.width, style),
        _buildProductInfoItem(APPStrings.depth.tr, productInfoModel.depth, style),
        _buildProductInfoItem(APPStrings.crownAngle.tr, productInfoModel.crownAngle, style),
        _buildProductInfoItem(APPStrings.crownHeight.tr, productInfoModel.crownHeight, style),
        _buildProductInfoItem(APPStrings.pavilionAngle.tr, productInfoModel.pavilionAngle, style),
        _buildProductInfoItem(APPStrings.pavilionDepth.tr, productInfoModel.pavilionDepth, style),
        _buildProductInfoItem(APPStrings.girdle.tr, productInfoModel.girdle, style),
        _buildProductInfoItem(APPStrings.culetSize.tr, productInfoModel.culetSize, style),
        _buildProductInfoItem(APPStrings.girdleCondition.tr, productInfoModel.girdleCondition, style),
        _buildProductInfoItem(APPStrings.laserInclusion.tr, productInfoModel.laserInclusion, style),
        _buildProductInfoItem(APPStrings.lowerHalf.tr, productInfoModel.lowerHalf, style),
        _buildProductInfoItem(APPStrings.starLength.tr, productInfoModel.starLength, style),
      ],
    );
  }

  Widget _buildInclusionInfo(ProductInfoModel productInfoModel, DiamondInfoPopupScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.inclusionInfo.tr, style: style.labelStyle),
        SizedBox(height: 12.h),
        _buildProductInfoItem(APPStrings.girdlePercentage.tr, productInfoModel.girdlePercentage, style),
        _buildProductInfoItem(APPStrings.colorGrading.tr, productInfoModel.colorGrading, style),
        _buildProductInfoItem(APPStrings.clarityGrading.tr, productInfoModel.clarityGrading, style),
        _buildProductInfoItem(APPStrings.blackTable.tr, productInfoModel.blackTable, style),
        _buildProductInfoItem(APPStrings.blackCrown.tr, productInfoModel.blackCrown, style),
        _buildProductInfoItem(APPStrings.crownOpen.tr, productInfoModel.crownOpen, style),
        _buildProductInfoItem(APPStrings.tableOpen.tr, productInfoModel.tableOpen, style),
        _buildProductInfoItem(APPStrings.pavOpen.tr, productInfoModel.pavOpen, style),
        _buildProductInfoItem(APPStrings.milkey.tr, productInfoModel.milkey, style),
        _buildProductInfoItem(APPStrings.heartAndArrow.tr, productInfoModel.heartAndArrow, style),
        _buildProductInfoItem(APPStrings.noBGM.tr, productInfoModel.noBGM, style),
        _buildProductInfoItem(APPStrings.girdleInclusion.tr, productInfoModel.girdleInclusion, style),
        _buildProductInfoItem(APPStrings.whiteInCenter.tr, productInfoModel.whiteInCenter, style),
        _buildProductInfoItem(APPStrings.whiteInCrown.tr, productInfoModel.whiteInCrown, style),
        _buildProductInfoItem(APPStrings.countryOfOrigin.tr, productInfoModel.countryOfOrigin, style),
      ],
    );
  }

  Widget _buildOtherInfo(ProductInfoModel productInfoModel, DiamondInfoPopupScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.other.tr, style: style.labelStyle),
        SizedBox(height: 12.h),
        _buildProductInfoItem(APPStrings.keyToSymbol.tr, productInfoModel.keyToSymbol, style),
        _buildProductInfoItem(APPStrings.reportComments.tr, productInfoModel.reportComments, style),
      ],
    );
  }

  Widget _buildPriceDetailsInfo(ProductInfoModel productInfoModel, DiamondInfoPopupScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.priceDetails.tr, style: style.labelStyle),
        SizedBox(height: 12.h),
        _buildProductInfoItem(APPStrings.rap.tr, productInfoModel.rap, style),
        _buildProductInfoItem(APPStrings.disc.tr, productInfoModel.discount, style),
        _buildProductInfoItem(APPStrings.pricePerCrt.tr, productInfoModel.pricePerCrt, style),
        _buildProductInfoItem(APPStrings.amount.tr, productInfoModel.amount, style),
      ],
    );
  }

  Widget _buildProductInfoItem(String title, String? value, DiamondInfoPopupScreenStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 8.0.h),
      child: Row(children: [
        Expanded(child: SmartText(title, style: style.itemTitleStyle)),
        Expanded(child: SmartText(value.isNotNullNorEmpty ? value : APPStrings.dash.tr, style: style.itemValueStyle)),
      ]),
    );
  }

  Widget _buildInquirySection(BuildContext context) {
    final MyBagScreenStyle myBagScreenStyle = AppTheme.of(context).myBagScreenStyle;
    return Column(
      children: [
        Row(
          children: [
            SmartImage(
              path: AppImages.icCertificate,
              height: 24.w,
              width: 24.w,
            ),
            SizedBox(width: 16.w),
            SmartText(
              APPStrings.certificate.tr,
              style: myBagScreenStyle.diamondPurityStyle,
            )
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            const SmartImage(path: AppImages.icDiamond),
            SizedBox(width: 16.w),
            SmartText(
              APPStrings.purityGuaranteed.tr,
              style: myBagScreenStyle.diamondPurityStyle,
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
              style: myBagScreenStyle.diamondPurityStyle,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, ProductInfoModel productInfo, DiamondInfoPopupBloc bloc) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 8.h),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SmartButton(
                prefixImage: AppImages.icShoppingBag,
                title: productInfo.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                onTap: () {
                  ProductDetailsModel? productDetails = ProductDetailsModel(
                    productId: productInfo.productId,
                    suid: productInfo.productId,
                    commodity: Commodity.diamond,
                  );

                  if (!productInfo.isAddedToCart) {
                    BlocProvider.of<AppBloc>(context).onTapBag(context, productDetails: productDetails);
                    productInfo.isAddedToCart = true;
                  } else {
                    BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
                    context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                  }
                },
              ),
            ),
            SizedBox(width: 8.w),
            SelectionButton(
              height: 42.w,
              width: 42.w,
              padding: EdgeInsetsDirectional.all(6.w),
              isSelected: bloc.productDetailsModel.isFavourite,
              onTap: () {
                // Add/Remove from wishlist
                if (!bloc.productDetailsModel.isFavourite) {
                  BlocProvider.of<AppBloc>(context).add(ProductAddToFavoriteEvent(bloc.productDetailsModel, context));
                  bloc.productDetailsModel.isFavourite = true;
                } else {
                  BlocProvider.of<AppBloc>(context).add(ProductRemoveFromFavoriteEvent(bloc.productDetailsModel, context));
                }
              },
              image: AppImages.icHeart,
            ),
          ],
        ),
      ),
    );
  }
}
