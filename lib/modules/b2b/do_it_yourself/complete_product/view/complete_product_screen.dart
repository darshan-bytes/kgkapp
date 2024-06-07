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
        onFavorite: () {},
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DiyProgressWidget(selectedStep: 3),
            _imageSlider(completeProductBloc),
            SizedBox(height: 40.h),
            _productDetail(style, completeProductBloc, context)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: SmartButton(
                height: 48.w,
                prefixImage: AppImages.icShoppingBag,
                title: APPStrings.addToBag.tr,
                onTap: () {},
              ),
            ),
            SizedBox(width: 8.w),
            SelectionButton(
              padding: EdgeInsets.all(12.w),
              isSelected: false,
              onTap: () {},
              image: AppImages.icHeart,
              height: 48.w,
              // imageHeight: 24.w,
              // imageWidth: 24.w,
            ),
            const SizedBox(width: 8),
            SelectionButton(
              padding: EdgeInsets.all(12.w),
              isSelected: false,
              onTap: () {},
              image: AppImages.icShare,
              height: 48.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSlider(CompleteProductBloc completeProductBloc) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductImagePageChangeState,
      builder: (context, state) {
        final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
        return Column(
          children: [
            CarouselSlider(
              items: completeProductBloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: completeProductBloc.controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.5,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    completeProductBloc.add(CompleteProductImageChangeEvent(index));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: completeProductBloc.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => completeProductBloc.controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0.w,
                    height: 10.0.w,
                    margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            completeProductBloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
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
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
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
                allowHalfRating: false,
                itemSize: 16.w,
                itemPadding: EdgeInsets.only(right: 2.w, left: 2.w),
              ),
              SizedBox(
                width: 8.w,
              ),
              SmartText(
                APPStrings.reviewsX.tr.interpolate([120]),
                style: style.productCodeStyle,
              )
            ],
          ),
          SizedBox(height: 16.h),
          _compareWidget(completeProductBloc),
          Divider(height: 40.h),
          ProductSelectedSettings(
            onTap: () {},
            selectedSettings: SelectedSettings(
              name: '2.00 Carat H VS1 Excellent Cut Round Diamond',
              price: '\$ 2,680',
              specification: 'Very Good Cut | K Color | VS1 Clarity',
              image: AppImages.icBlankDiamond,
              imageColor: style.ratingGlowColor,
            ),
          ),
          SizedBox(height: 24.h),
          ProductSelectedSettings(
            onTap: () {},
            selectedSettings: SelectedSettings(
              name: '14k White & Rose gold Engagement Ring ',
              price: '\$ 1,360',
              specification: 'Very Good Cut | K Color | VS1 Clarity ',
              image: AppImages.icRing,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SmartText(APPStrings.approxPrice.tr, style: style.productTypeStyle),
              SizedBox(width: 12.w),
              SmartText('\$1200.00', style: style.priceStyle),
            ],
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              text: APPStrings.buyingInBulk.tr,
              style: style.productTypeStyle,
              children: [
                WidgetSpan(child: SizedBox(width: 12.w)),
                TextSpan(
                  text: APPStrings.askForQuotation.tr,
                  style: style.detailsHeaderStyle,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
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
            trailing: (completeProductBloc.isRingDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(ProductRingDetailsToggleEvent(isRingDetailsOpen: !completeProductBloc.isRingDetailsOpen));
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
              'Diamond details',
              style: style.detailsHeaderStyle,
            ),
            trailing: (completeProductBloc.isDiamondDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(ProductDiamondDetailsToggleEvent(isDiamondDetailsOpen: !completeProductBloc.isDiamondDetailsOpen));
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

  Widget _compareWidget(CompleteProductBloc completeProductBloc) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: completeProductBloc.isCompare,
          onChanged: (value) {
            completeProductBloc.add(CompleteProductCompareToggle(value));
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
        SmartText(
          type,
          style: style.settingTypeStyle,
        ),
        SmartText(
          value,
          style: style.settingValueStyle,
        ),
      ],
    );
  }
}
