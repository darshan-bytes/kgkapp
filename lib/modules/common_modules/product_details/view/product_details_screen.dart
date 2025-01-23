import 'package:kgk/kgk.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsBloc bloc = BlocProvider.of<ProductDetailsBloc>(context);
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
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
      bottomNavigationBar: bloc.isErrorInLoadingData ? null : _buildBottomNavigationBar(bloc, style, context),
    );
  }

  Widget _buildBottomNavigationBar(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDetailsLoadedState,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: style.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 7.r,
                blurRadius: 7.r,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                          height: 60.h,
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
                                    SmartText(bloc.productDetails?.displayPrice,
                                        style: style.priceStyle, maxLines: 1, isAutoSizeText: true),
                                    if (bloc.productDetails?.offerPrice.isNotNullNorEmpty == true)
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SmartText(bloc.productDetails?.offerPrice, style: style.originalPriceStyle),
                                          SizedBox(width: 2.w),
                                          SmartText(bloc.productDetails?.discountPercentageString, style: style.discountStyle),
                                        ],
                                      )
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
          ),
        );
      },
    );
  }

  List<Widget> _buildB2CCustomisationDetails(ProductDetailsStyle style) {
    return [
      SizedBox(height: 10.h),
      Row(
        children: [
          SmartText(APPStrings.totalApproxPrice.tr, style: style.totalApproxStyle),
          const Spacer(),
          SmartText("\$1,470.00", style: style.totalApproxStyle)
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
      Row(children: [
        SmartImage(
            path: bloc.productDetails?.imageUrl ?? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
            height: 73.w,
            width: 73.w,
            imageBorderRadius: BorderRadius.circular(7.66.r)),
        SizedBox(width: 10.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText("C097973", style: style.originalPriceStyle),
            SizedBox(height: 4.h),
            SmartText("14k White & Rose gold Engagement Ring", style: style.bottomNavBarSubTitleStyle, isAutoSizeText: true),
          ],
        )),
      ]),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.total.tr, style: style.totalApproxSubStyle),
          SizedBox(width: 16.w),
          Flexible(child: SmartText("\$35,700.00", style: style.totalApproxSubStyle))
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
                      child: BlocBuilder<CompareProductBloc, CompareProductState>(
                        buildWhen: (previous, current) => current is CompareProductAddedState,
                        builder: (context, state) {
                          return SmartText(compareProductBloc.productIdList.length.toString(),
                              style: AppTheme.of(context).primaryButtonStyle.titleStyle);
                        },
                      ),
                    )
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
                              on360Tap: bloc.isCustomisation ? () {} : null,
                              onTapFullImage: (int index) {
                                bloc.onTapFullImage(context: context, currentIndex: index);
                              },
                            ),
                            if (!bloc.isCustomisation)
                              Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 8.w),
                                    BlocBuilder<AppBloc, AppState>(
                                      buildWhen: (previous, current) =>
                                          current is ProductAddToFavoriteState || current is ProductRemoveFromFavoriteState,
                                      builder: (context, state) {
                                        return SelectionButton(
                                          height: 42.w,
                                          width: 42.w,
                                          padding: EdgeInsets.all(6.w),
                                          isSelected: false,
                                          onTap: () {
                                            if (bloc.productDetails != null) {
                                              BlocProvider.of<AppBloc>(context).onTapFavorite(
                                                context,
                                                productDetails: bloc.productDetails!,
                                              );
                                            }
                                          },
                                          imageWidth: 20.w,
                                          imageHeight: 20.w,
                                          fit: BoxFit.contain,
                                          image: (bloc.productDetails?.isFavourite ?? false) ? AppImages.icHeartFill : AppImages.icHeart,
                                        );
                                      },
                                    ),
                                    SizedBox(width: 8.w),
                                    SelectionButton(
                                      height: 42.w,
                                      width: 42.w,
                                      padding: EdgeInsets.all(6.w),
                                      isSelected: false,
                                      onTap: () {
                                        Utils.showSmartModalBottomSheet(
                                          context: context,
                                          enableDrag: false,
                                          builder: (context) => ShareOptionSheet(
                                            title: APPStrings.share.tr,
                                            onTapQrCode: () {
                                              context.pop();
                                              _showQrCodeDialog(context: context, data: "https://dev.kgk.magnetoinfotech.com");
                                            },
                                            onTapCopy: () async {
                                              if (bloc.productDetails != null) {
                                                await BlocProvider.of<AppBloc>(context)
                                                    .handleShareProduct(context: context, productDetails: bloc.productDetails!);
                                              }
                                              bloc.onTapCopyLink(context: context);
                                            },
                                            onTapOther: () async {
                                              bloc.onTapShareLink(context: context);
                                            },
                                          ),
                                        );
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
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _productTypeAndCode(style, bloc),
          SizedBox(height: 8.h),
          SmartText(bloc.productName, style: style.productNameStyle),
          SizedBox(height: 8.h),
          _buildRatingBarAndReviews(style, bloc.productDetails),
          SizedBox(height: 16.h),
          _compareWidget(bloc, style),
          SizedBox(height: 16.h),

          /// NOTE : COMMENTED AS OF NOW TO MAKE IT SIMILAR WITH WEB
          // Divider(height: 48.h),
          // _buildCustomizationList(bloc),
          // if (bloc.screenIdentifier == ScreenIdentifier.productForRing) Divider(height: 48.h),
          if (!bloc.isCustomisation && bloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            ProductCustomiseDescriptionWidget(
              onTap: () {
                context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                  RoutesData.isCustomisationPage: true,
                  RoutesData.productId: bloc.productDetails?.productId,
                  RoutesData.isPageFor: bloc.screenIdentifier
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
          if (bloc.screenIdentifier == ScreenIdentifier.productForRing ||
              bloc.screenIdentifier == ScreenIdentifier.productForGemstones) ...[
            SizedBox(height: 24.h),
            const Divider(),
            ProductDetailsComponentsView(
                commodity: bloc.productDetails?.commodity ?? Commodity.jewellery,
                components: bloc.productDetails?.components,
                stoneElements: bloc.productDetails?.stoneElements),
          ],
          if (bloc.screenIdentifier == ScreenIdentifier.productForDiamonds) ...[
            SizedBox(height: 24.h),
            const Divider(),
            InkWell(
              onTap: () {
                context.pushNamed(AppRoutes.diamondInfoPopupPage, arguments: {RoutesData.diamondInfo: bloc.diamondData});
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
          if (bloc.screenIdentifier == ScreenIdentifier.productForRing) ...[
            SizedBox(height: 24.h),

            ///TODO:Here Need to work on isShowWriteReviewButton
            BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              buildWhen: (previous, current) => current is ProductDetailsLoadedState || current is ProductDetailsRecentlyViewedLoadedState,
              builder: (context, state) {
                return ProductReviewsDetails(
                  isShowWriteReviewButton: true,
                  ratings: List.generate(bloc.reviewList.length, (index) => (bloc.reviewList[index].rating ?? 0)).toList(),
                  averageRating: bloc.productDetails?.rating ?? 0,
                  reviewCount: bloc.productDetails?.reviewCount ?? 0,
                  onTap: () {
                    /// First check if the user is logged in or not
                    if (StorageManager().getIsSkipLogin()) {
                      Utils.showMessage(APPStrings.loginToUseThisFeature.tr);
                      return;
                    }
                    context.pushNamed(AppRoutes.writeReviewPage, arguments: {
                      RoutesData.productId: bloc.productDetails?.productId,
                      RoutesData.commodity: bloc.productDetails?.commodity,
                    });
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
              SmartText(APPStrings.viewAllXReviews.tr.interpolate([25]), style: style.viewAllReviewStyle, onTap: () {
                context.pushNamed(AppRoutes.allReviewPage, arguments: {RoutesData.productId: bloc.productDetails?.productId});
              }),
            ],
            if (bloc.suggestedProductList.isNotNullNorEmpty) SizedBox(height: 32.h),
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
              if (bloc.productDetails!.brandName.isNotNullNorEmpty)
                SmartText(bloc.productDetails?.brandName, style: style.productTypeStyle),
              if (bloc.productDetails!.brandName.isNotNullNorEmpty && bloc.productDetails!.productSku.isNotNullNorEmpty) ...[
                SizedBox(width: 8.w),
                Container(
                  height: 4.w,
                  width: 4.w,
                  decoration: BoxDecoration(
                      color: style.dotColor,
                      border: Border.all(color: style.dotColor),
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
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
        SmartRatingBar(
          initialRating: productDetails?.rating ?? 0,
          itemSize: 16.w,
          onRatingUpdate: (value) {},
          ignoreGestures: true,
        ),
        SizedBox(width: 8.w),
        SmartText(
          APPStrings.reviewsX.tr.interpolate([productDetails?.reviewCount]),
          style: style.productCodeStyle,
        )
      ],
    );
  }

  Widget _compareWidget(ProductDetailsBloc bloc, ProductDetailsStyle style) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: bloc.isCompare,
          onChanged: (value) {
            bloc.add(ToggleCompareProductEvent(context: context));
          },
          label: APPStrings.compareProduct.tr,
          labelStyle: style.compareProductStyle,
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
      children: [
        SmartText(type, style: style.settingTypeStyle),
        SmartText(value, style: style.settingValueStyle),
      ],
    );
  }

  Widget _buildSuggestedProductList(ProductDetailsBloc bloc, ProductDetailsStyle style, BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductDetailsSuggestedLoadedState,
      builder: (context, state) {
        if (bloc.suggestedProductList.isEmpty) return const SizedBox.shrink();
        return SmartSuggestionProductList(
            title: APPStrings.youMayAlsoLike.tr,
            onViewAllTap: bloc.suggestedProductList.length > 5
                ? () => bloc.navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(context, productNavigation: AppConst.youMayLike)
                : null,
            suggestedProductList: bloc.suggestedProductList,
            onProductTap: (product) {
              context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                RoutesData.productId: product.productId,
                RoutesData.isPageFor: bloc.screenIdentifier,
              });
            },
            onEyeTap: () {},
            onFavTap: () {},
            isPaddingNeeded: false,
            scrollController: bloc.youMayLikeScrollController);
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
                title: APPStrings.recentlyViewed.tr,
                onViewAllTap: bloc.recentlyViewedProductList.length > 5
                    ? () {
                        bloc.navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(context,
                            productNavigation: AppConst.recentlyViewed);
                      }
                    : null,
                suggestedProductList: bloc.recentlyViewedProductList,
                onProductTap: (product) {
                  context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                    RoutesData.productId: product.productId,
                    RoutesData.isPageFor: bloc.screenIdentifier,
                  });
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
      padding: EdgeInsets.all(16.w),
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
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: style.whiteColor,
                    boxShadow: [
                      BoxShadow(color: style.shadowColor, blurRadius: 15.0, spreadRadius: 5.0),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 56.w,
                          width: 56.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: style.borderColor),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.qr_code_2_outlined, size: 42.w, color: style.primaryColor)),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
