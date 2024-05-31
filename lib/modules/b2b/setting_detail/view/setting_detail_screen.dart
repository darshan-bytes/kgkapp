import 'package:kgk/kgk.dart';

class SettingDetailScreen extends StatelessWidget {
  const SettingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ringBloc = context.read<SettingDetailBloc>();
    return Scaffold(
      appBar: SmartAppBar(
        title: 'DIY',
        onFavorite: () {},
        onFilter: () {},
      ),
      body: BlocBuilder<SettingDetailBloc, SettingDetailState>(
        buildWhen: (_, current) => current is SettingImagePageChangeState,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DiyProgressWidget(
                  selectedStep: 2,
                ),
                _imageSlider(context, ringBloc),
                SizedBox(
                  height: 40.h,
                ),
                _productDetail(context, ringBloc)
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SmartButton(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.completeProductPage);
        },
        title: APPStrings.selectSetting.tr,
      ),
    );
  }

  Widget _imageSlider(BuildContext context, SettingDetailBloc ringBloc) {
    final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
    return Column(
      children: [
        CarouselSlider(
          items: ringBloc.imgList.map((e) {
            return SmartImage(path: e);
          }).toList(),
          carouselController: ringBloc.controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.5,
              aspectRatio: 1,
              onPageChanged: (index, reason) {
                ringBloc.add(SettingImagePageChangeEvent(index: index));
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ringBloc.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => ringBloc.controller.animateToPage(entry.key),
              child: Container(
                width: 10.0.w,
                height: 10.0.w,
                margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ringBloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _productDetail(BuildContext context, SettingDetailBloc ringBloc) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    final ringDetailBloc = context.read<SettingDetailBloc>();
    return BlocBuilder<SettingDetailBloc, SettingDetailState>(
      buildWhen: (_, current) => current is SettingToggleState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 17.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SmartText(
                    'Martin Flyer',
                    style: style.ringTypeStyle,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
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
                  SizedBox(
                    width: 8.w,
                  ),
                  SmartText(
                    'DERC03RDA',
                    style: style.ringCodeStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              SmartText(
                '1.01 Carat Round Diamond',
                style: style.ringNameStyle,
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  RatingBar(
                    itemCount: 5,
                    glowColor: colors(context).primary,
                    onRatingUpdate: (double value) {},
                    allowHalfRating: false,
                    itemSize: 16,
                    itemPadding: EdgeInsets.only(right: 2.w, left: 2.w),
                    ratingWidget: RatingWidget(
                      empty: const SmartImage(path: AppImages.icEmptyStar),
                      full: const SmartImage(path: AppImages.icFullStar),
                      half: Container(),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SmartText(
                    APPStrings.reviews.tr.interpolate([120]),
                    style: style.reviewStyle,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                height: 1.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              _metalSelectionWidget(context, ringBloc),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 1.h,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  SmartText(
                    APPStrings.approxPrice.tr,
                    style: style.approxPriceLabelStyle,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  SmartText(
                    '\$1200.00',
                    style: style.priceStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  SmartText(
                    APPStrings.buyingInBulk.tr,
                    style: style.buyInBulkStyle,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SmartText(
                      APPStrings.askForQuotation.tr,
                      style: style.askQuestionStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              SmartText(
                APPStrings.approxPriceNote.tr,
                style: style.approxPriceNoteStyle,
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                children: [
                  const SmartImage(path: AppImages.icDiamond),
                  SizedBox(
                    width: 16.w,
                  ),
                  SmartText(
                    APPStrings.diamondPurityYouCanTrust.tr,
                    style: style.diamondPurityStyle,
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  const SmartImage(path: AppImages.icTruck),
                  SizedBox(
                    width: 16.w,
                  ),
                  SmartText(
                    APPStrings.shippingAcrossAllCountries.tr,
                    style: style.shippingStyle,
                  )
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Divider(
                height: 1.h,
              ),
              SizedBox(
                height: 32.h,
              ),
              GestureDetector(
                onTap: () {
                  ringDetailBloc.add(SettingToggleEvent(isSettingOpen: ringDetailBloc.isSettingOpen ? false : true));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmartText(
                      APPStrings.settingDetails.tr,
                      style: style.settingHeaderStyle,
                    ),
                    if (!ringDetailBloc.isSettingOpen) ...[
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 24.w,
                      ),
                    ] else ...[
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 24.w,
                      ),
                    ],
                  ],
                ),
              ),
              if (!ringDetailBloc.isSettingOpen) ...[
                SizedBox(
                  height: 16.h,
                ),
                _settingWidget(APPStrings.productType.tr, 'Engagement Ring', context),
                SizedBox(
                  height: 14.h,
                ),
                _settingWidget(APPStrings.brand, 'Flyerfit', context),
                SizedBox(
                  height: 14.h,
                ),
                _settingWidget(APPStrings.meleeWeight, 'SA-.25cts Dia-0.28cts', context),
              ],
              SizedBox(height: 28.h),
              Divider(height: 1.h),
              SizedBox(height: 28.h),
              _settingWidget('Shape', 'Round', context),
              SizedBox(height: 12.h),
              _settingWidget('Quantity', '1', context),
              SizedBox(height: 12.h),
              _settingWidget('Total carat (min)', '1', context),
              SizedBox(height: 12.h),
              _settingWidget('Color', 'F-G', context),
              SizedBox(height: 12.h),
              _settingWidget('Clarity', 'VS2-SI1', context),
              SizedBox(height: 12.h),
              _settingWidget('Setting', 'TypeThree Stone', context),
              SizedBox(height: 28.h),
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
      },
    );
  }

  Widget _metalSelectionWidget(BuildContext context, SettingDetailBloc ringBloc) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          APPStrings.metal.tr,
          style: style.metalHeaderStyle,
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          height: 100.h,
          alignment: Alignment.center,
          width: context.width,
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 34.w,
                        width: 34.w,
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
                      SizedBox(
                        height: 12.h,
                      ),
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
