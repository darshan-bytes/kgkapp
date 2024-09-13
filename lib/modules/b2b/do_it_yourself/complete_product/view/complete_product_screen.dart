import 'package:kgk/kgk.dart';

class CompleteProductScreen extends StatelessWidget {
  const CompleteProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProductBloc = BlocProvider.of<CompleteProductBloc>(context);
    final CompleteProductStyle style = AppTheme.of(context).completeProductStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.diy.tr,
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
      ),
      body: SmartSingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DiyProgressWidget(selectedStep: 3),
            SmartCarouselSlider(
              imgList: completeProductBloc.imgList,
              controller: completeProductBloc.controller,
            ),
            SizedBox(height: 40.h),
            _productDetail(style, completeProductBloc, context)
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(style, completeProductBloc),
    );
  }

  Widget bottomNavigationBar(CompleteProductStyle style, CompleteProductBloc completeProductBloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
      decoration: BoxDecoration(
        color: style.whiteColor,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartImage(path: completeProductBloc.imgList.first, height: 55.w, width: 55.w),
            Expanded(
              flex: 4,
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmartText(APPStrings.approxPrice.tr, style: style.productTypeStyle),
                  SizedBox(height: 4.w),
                  SmartText('\$1200.00', style: style.priceStyle),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 5,
              child: SmartButton(
                prefixImage: AppImages.icShoppingBag,
                onTap: () {},
                title: APPStrings.addToBag.tr,
                height: 55.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productDetail(CompleteProductStyle style, CompleteProductBloc completeProductBloc, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SmartText('Martin Flyer', style: style.productTypeStyle),
              SizedBox(width: 8.w),
              Container(
                height: 6.w,
                width: 6.w,
                decoration: BoxDecoration(
                    color: colors(context).color8C8C8C,
                    border: Border.all(
                      color: colors(context).color8C8C8C,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.r))),
              ),
              SizedBox(width: 8.w),
              SmartText('DERC03RDA', style: style.productCodeStyle),
            ],
          ),
          SizedBox(height: 8.h),
          SmartText('1.01 Carat Round Diamond', style: style.productNameStyle),
          SizedBox(height: 8.h),
          Row(
            children: [
              SmartRatingBar(
                itemCount: 5,
                initialRating: 4,
                onRatingUpdate: (double value) {},
                itemSize: 16.w,
                itemPadding: EdgeInsets.only(right: 2.w, left: 2.w),
              ),
              SizedBox(width: 8.w),
              SmartText(APPStrings.reviewsX.tr.interpolate([120]), style: style.productCodeStyle)
            ],
          ),
          SizedBox(height: 16.h),
          _compareWidget(completeProductBloc),
          Divider(height: 40.h),
          ProductSelectedSettings(
            onTap: () {
              context.popUntilOfContext((route) => route.settings.name == AppRoutes.stoneListingPage);
            },
            selectedSettings: SelectedSettings(
              name: '2.00 Carat H VS1 Excellent Cut Round Diamond',
              price: '\$2,680.00',
              specification: 'Very Good Cut | K Color | VS1 Clarity',
              image: AppImages.icBlankDiamond,
              imageColor: style.ratingGlowColor,
            ),
          ),
          SizedBox(height: 24.h),
          ProductSelectedSettings(
            onTap: () {
              context.popUntilOfContext((route) => route.settings.name == AppRoutes.settingListingPage);
            },
            selectedSettings: SelectedSettings(
              name: '14k White & Rose gold Engagement Ring ',
              price: '\$1,360.00',
              specification: 'Very Good Cut | K Color | VS1 Clarity ',
              image: AppImages.icRing,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SmartText(APPStrings.buyingInBulk.tr, style: style.productTypeStyle),
              SizedBox(width: 12.w),
              SmartButton(
                title: APPStrings.askForQuotation.tr,
                width: 170.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                onTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder: (context) => QuotationRequestConfirmation(
                      onContinueShopping: () {
                        context.pop();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SmartText(APPStrings.approxPriceNote.tr, style: style.productTypeStyle),
          SizedBox(height: 32.h),
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
          SizedBox(height: 32.h),
          const Divider(),
          _ringDetails(completeProductBloc, style, context),
          const Divider(),
          _diamondDetails(completeProductBloc, style, context),
          const Divider(),
          _gemstoneDetails(completeProductBloc),
          Divider(height: 1.h),
          SizedBox(height: 28.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _ringDetails(CompleteProductBloc completeProductBloc, CompleteProductStyle style, BuildContext context) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductRingDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: completeProductBloc.isRingDetailsOpen ? EdgeInsets.only(bottom: 28.h) : EdgeInsets.zero,
          child: SmartExpansionTile(
            key: completeProductBloc.ringDetailsKey,
            title: SmartText(
              'Ring details',
              style: style.detailsHeaderStyle,
            ),
            onExpansionChanged: (value) {
              completeProductBloc.add(ProductRingDetailsToggleEvent(isRingDetailsOpen: !completeProductBloc.isRingDetailsOpen));
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

  Widget _diamondDetails(CompleteProductBloc completeProductBloc, CompleteProductStyle style, BuildContext context) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductDiamondDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: completeProductBloc.isDiamondDetailsOpen ? EdgeInsets.only(bottom: 28.h) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: completeProductBloc.isDiamondDetailsOpen,
            key: completeProductBloc.diamondDetailsKey,
            title: SmartText(
              APPStrings.diamondDetails.tr,
              style: style.detailsHeaderStyle,
            ),
            trailing: (completeProductBloc.isDiamondDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(const CompleteProductDiamondDetailsToggleEvent());
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

  Widget _compareWidget(CompleteProductBloc completeProductBloc) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: completeProductBloc.isCompare,
          onChanged: (value) {
            if (value != null) {
              completeProductBloc.add(CompleteProductCompareToggle(value));
            }
          },
          label: APPStrings.compareProduct.tr,
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

  Widget _gemstoneDetails(CompleteProductBloc completeProductBloc) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductDiamondDetailsToggleState,
      builder: (context, state) {
        final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
        return Padding(
          padding: completeProductBloc.isGemstoneDetailsOpen ? EdgeInsets.only(bottom: 28.h) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: completeProductBloc.isGemstoneDetailsOpen,
            key: completeProductBloc.gemstoneDetailsKey,
            title: SmartText(
              'Gemstone details',
              style: style.settingSelectionTitleStyle,
            ),
            trailing: (completeProductBloc.isGemstoneDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(const CompleteProductGemstoneDetailsToggleEvent());
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
              SizedBox(height: 28.h),
            ],
          ),
        );
      },
    );
  }
}
