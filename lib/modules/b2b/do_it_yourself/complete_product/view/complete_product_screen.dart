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
            const SizedBox(height: 40),
            _productDetail(style, completeProductBloc, context)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: SmartButton(
                prefixImage: AppImages.icShoppingBag,
                title: APPStrings.addToBag.tr,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 8),
            SelectionButton(
              padding: const EdgeInsets.all(12),
              isSelected: false,
              onTap: () {},
              image: AppImages.icHeart,
            ),
            const SizedBox(width: 8),
            SelectionButton(
              padding: const EdgeInsets.all(12),
              isSelected: false,
              onTap: () {},
              image: AppImages.icShare,
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
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SmartText('Martin Flyer', style: style.productTypeStyle),
              const SizedBox(width: 8),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    color: colors(context).color8C8C8C,
                    border: Border.all(
                      color: colors(context).color8C8C8C,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
              ),
              const SizedBox(width: 8),
              SmartText('DERC03RDA', style: style.productCodeStyle),
            ],
          ),
          const SizedBox(height: 8),
          SmartText('1.01 Carat Round Diamond', style: style.productNameStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingBar(
                itemCount: 5,
                initialRating: 4,
                glowColor: style.ratingGlowColor,
                onRatingUpdate: (double value) {},
                allowHalfRating: false,
                itemSize: 16,
                itemPadding: const EdgeInsets.only(right: 2, left: 2),
                ratingWidget: RatingWidget(
                  empty: const SmartImage(path: AppImages.icEmptyStar),
                  full: const SmartImage(path: AppImages.icFullStar),
                  half: Container(),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SmartText(
                APPStrings.reviews.tr.interpolate([120]),
                style: style.productCodeStyle,
              )
            ],
          ),
          const SizedBox(height: 16),
          _compareWidget(completeProductBloc),
          const Divider(height: 40),
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
          const SizedBox(height: 24),
          ProductSelectedSettings(
            onTap: () {},
            selectedSettings: SelectedSettings(
              name: '14k White & Rose gold Engagement Ring ',
              price: '\$ 1,360',
              specification: 'Very Good Cut | K Color | VS1 Clarity ',
              image: AppImages.icRing,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SmartText(APPStrings.approxPrice.tr, style: style.productTypeStyle),
              const SizedBox(width: 12),
              SmartText('\$1200.00', style: style.priceStyle),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: APPStrings.buyingInBulk.tr,
              style: style.productTypeStyle,
              children: [
                const WidgetSpan(child: SizedBox(width: 12)),
                TextSpan(
                  text: APPStrings.askForQuotation.tr,
                  style: style.detailsHeaderStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SmartText(APPStrings.approxPriceNote.tr, style: style.productTypeStyle),
          const SizedBox(height: 32),
          Row(
            children: [
              const SmartImage(
                path: AppImages.icDiamond,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 16),
              SmartText(
                APPStrings.diamondPurityYouCanTrust.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              const SizedBox(width: 16),
              SmartText(
                APPStrings.shippingAcrossAllCountries.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          _ringDetails(completeProductBloc, style, context),
          const Divider(height: 1),
          _diamondDetails(completeProductBloc, style, context),
          const Divider(height: 1),
          const SizedBox(height: 28),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _ringDetails(CompleteProductBloc completeProductBloc, CompleteProductStyle style, BuildContext context) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductRingDetailsToggleState,
      builder: (context, state) {
        return Padding(
          padding: completeProductBloc.isRingDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            key: completeProductBloc.ringDetailsKey,
            title: SmartText(
              'Ring details',
              style: style.detailsHeaderStyle,
            ),
            trailing: (completeProductBloc.isRingDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(ProductRingDetailsToggleEvent(isRingDetailsOpen: !completeProductBloc.isRingDetailsOpen));
            },
            children: [
              const SizedBox(height: 16),
              _settingWidget(APPStrings.productType.tr, 'Engagement Ring', context),
              const SizedBox(height: 14),
              _settingWidget(APPStrings.brand, 'Flyerfit', context),
              const SizedBox(height: 14),
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
          padding: completeProductBloc.isDiamondDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: completeProductBloc.isDiamondDetailsOpen,
            key: completeProductBloc.diamondDetailsKey,
            title: SmartText(
              'Diamond details',
              style: style.detailsHeaderStyle,
            ),
            trailing: (completeProductBloc.isDiamondDetailsOpen)
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: style.ratingGlowColor)
                : Icon(Icons.keyboard_arrow_down, size: 24, color: style.ratingGlowColor),
            onExpansionChanged: (value) {
              completeProductBloc.add(ProductDiamondDetailsToggleEvent(isDiamondDetailsOpen: !completeProductBloc.isDiamondDetailsOpen));
            },
            children: [
              const SizedBox(height: 16),
              _settingWidget(APPStrings.shape.tr, 'Engagement Ring', context),
              const SizedBox(height: 14),
              _settingWidget(APPStrings.quantity, '1', context),
              const SizedBox(height: 14),
              _settingWidget(APPStrings.totalCarat, '1', context),
              const SizedBox(height: 14),
              _settingWidget(APPStrings.color, 'F-G', context),
              const SizedBox(height: 14),
              _settingWidget(APPStrings.clarity, 'VS2-SI1', context),
              const SizedBox(height: 14),
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
