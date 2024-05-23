import 'package:kgk/kgk.dart';

class RingDetailScreen extends StatelessWidget {
  const RingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    final ringBloc = context.read<RingDetailBloc>();
    return Scaffold(
      appBar: SmartAppBar(
        title: 'DIY',
        onFavorite: () { },
        onFilter: () { },
      ),
      body: BlocBuilder<RingDetailBloc, RingDetailState>(
        buildWhen: (_, current) => current is RingImagePageChangeState,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DiyProgressWidget(selectedStep: 2,),
                _imageSlider(context, ringBloc),
                const SizedBox(height: 40,),
                _productDetail(context, ringBloc)
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: BottomAppBar(
          color: colors(context).white.withOpacity(0.08),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: colors(context).primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
            child: Text(
              APPStrings.selectSetting.tr,
              style: style.selectSettingStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageSlider(BuildContext context, RingDetailBloc ringBloc) {
    return Column(
      children: [
        CarouselSlider(
          items: ringBloc.imgList.map((e) {
            return SmartImage(path: e, width: double.infinity,);
          }).toList(),
          carouselController: ringBloc.controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.5,
              aspectRatio: 1,
              onPageChanged: (index, reason) {
                ringBloc.add(RingImagePageChangeEvent(index: index));
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ringBloc.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => ringBloc.controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(ringBloc.current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _productDetail(BuildContext context, RingDetailBloc ringBloc) {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    final ringDetailBloc = context.read<RingDetailBloc>();
    return BlocBuilder<RingDetailBloc, RingDetailState>(
      buildWhen: (_, current) => current is RingSettingState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SmartText(
                    'Martin Flyer',
                    style: style.ringTypeStyle,
                  ),
                  const SizedBox(width: 8,),
                  SmartText(
                    '●',
                    color: colors(context).color8C8C8C,
                  ),
                  const SizedBox(width: 8,),
                  SmartText(
                    'DERC03RDA',
                    style: style.ringCodeStyle,
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              SmartText(
                '1.01 Carat Round Diamond',
                style: style.ringNameStyle,
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  RatingBar(
                    itemCount: 5,
                    glowColor: colors(context).primary,
                    onRatingUpdate: (double value) {  },
                    allowHalfRating: false,
                    itemSize: 16,
                    itemPadding: const EdgeInsets.only(right: 2, left: 2),
                    ratingWidget: RatingWidget(
                      empty: const SmartImage(path: AppImages.icEmptyStar),
                      full: const SmartImage(path: AppImages.icFullStar),
                      half: Container(),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  SmartText(
                    APPStrings.reviews.interpolate([120]).tr,
                    style: style.reviewStyle,
                  )
                ],
              ),
              const SizedBox(height: 20,),
              const Divider(height: 1,),
              const SizedBox(height: 20,),
              _metalSelectionWidget(context, ringBloc),
              const SizedBox(height: 10,),
              const Divider(height: 1,),
              const SizedBox(height: 16,),
              Row(
                children: [
                  SmartText(
                    APPStrings.approxPrice.tr,
                    style: style.approxPriceLabelStyle,
                  ),
                  const SizedBox(width: 12,),
                  SmartText(
                    '\$1200.00',
                    style: style.priceStyle,
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  SmartText(
                    APPStrings.buyingInBulk.tr,
                    style: style.buyInBulkStyle,
                  ),
                  const SizedBox(width: 12,),
                  InkWell(
                    onTap: () {},
                    child: SmartText(
                      APPStrings.askForQuotation.tr,
                      style: style.askQuestionStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              SmartText(
                APPStrings.approxPriceNote.tr,
                style: style.approxPriceNoteStyle,
              ),
              const SizedBox(height: 32,),
              Row(
                children: [
                  const SmartImage(path: AppImages.icDiamond),
                  const SizedBox(width: 16,),
                  SmartText(APPStrings.diamondPurityYouCanTrust.tr, style: style.diamondPurityStyle,)
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: [
                  const SmartImage(path: AppImages.icTruck),
                  const SizedBox(width: 16,),
                  SmartText(APPStrings.shippingAcrossAllCountries.tr, style: style.shippingStyle,)
                ],
              ),
              const SizedBox(height: 32,),
              const Divider(height: 1,),
              const SizedBox(height: 32,),
              GestureDetector(
                onTap: () {
                  ringDetailBloc.add(RingSettingEvent(isSettingOpen: ringDetailBloc.isSettingOpen ? false : true));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmartText(APPStrings.settingDetails, style: style.settingHeaderStyle,),
                    if (!ringDetailBloc.isSettingOpen) ... [
                      const Icon(Icons.keyboard_arrow_up, size: 24,),
                    ] else ...[
                      const Icon(Icons.keyboard_arrow_down, size: 24,),
                    ],
                  ],
                ),
              ),
              if (!ringDetailBloc.isSettingOpen) ... [
                const SizedBox(height: 16,),
                _settingWidget(APPStrings.productType.tr, 'Engagement Ring', context),
                const SizedBox(height: 14,),
                _settingWidget(APPStrings.brand, 'Flyerfit', context),
                const SizedBox(height: 14,),
                _settingWidget(APPStrings.meleeWeight, 'SA-.25cts Dia-0.28cts', context),
              ],
              const SizedBox(height: 28,),
              const Divider(height: 1,),
              const SizedBox(height: 28,),
              _settingWidget('Shape', 'Round', context),
              const SizedBox(height: 12,),
              _settingWidget('Quantity', '1', context),
              const SizedBox(height: 12,),
              _settingWidget('Total carat (min)', '1', context),
              const SizedBox(height: 12,),
              _settingWidget('Color', 'F-G', context),
              const SizedBox(height: 12,),
              _settingWidget('Clarity', 'VS2-SI1', context),
              const SizedBox(height: 12,),
              _settingWidget('Setting', 'TypeThree Stone', context),
              const SizedBox(height: 28,),
              const Divider(height: 1,),
              const SizedBox(height: 28,),
              const InquiryWidget(email: 'enquiry.diaind@kgkmail.com', phone: '+91 - 1234567830',),
              const SizedBox(height: 24,),
            ],
          ),
        );
      },
    );
  }

  Widget _metalSelectionWidget(BuildContext context, RingDetailBloc ringBloc) {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.metal.tr, style: style.metalHeaderStyle,),
        const SizedBox(height: 12,),
        Container(
          height: 100,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              bool isSelected = index % 3 == 0;
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 34, width: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors(context).white,
                          border: isSelected ? Border.all(color: colors(context).color083458, width: 1) : null,
                        ),
                        child: Center(
                          child: FractionallySizedBox(
                            heightFactor: 0.8,
                            widthFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors(context).primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      SmartText(
                        'White \nGold',
                        style: isSelected ? style.selectedMetalNameStyle : style.metalNameStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(type, style: style.settingTypeStyle,),
        SmartText(value, style: style.settingValueStyle,),
      ],
    );
  }
}