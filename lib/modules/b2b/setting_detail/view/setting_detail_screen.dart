import 'package:kgk/kgk.dart';

class SettingDetailScreen extends StatelessWidget {
  const SettingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingDetailBloc = BlocProvider.of<SettingDetailBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: 'DIY',
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DiyProgressWidget(
              selectedStep: 2,
            ),
            SmartCarouselSlider(
              imgList: settingDetailBloc.imgList,
              controller: settingDetailBloc.controller,
            ),
            SizedBox(height: 40.h),
            _productDetail(context, settingDetailBloc)
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SmartButton(
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
          onTap: () {
            context.pushNamed(AppRoutes.completeProductPage);
          },
          title: APPStrings.selectSetting.tr,
        ),
      ),
    );
  }

  Widget _productDetail(BuildContext context, SettingDetailBloc settingDetailBloc) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return BlocBuilder<SettingDetailBloc, SettingDetailState>(
      buildWhen: (_, current) => current is SettingToggleState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SmartText('Martin Flyer', style: style.ringTypeStyle),
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
                  SmartText(
                    'DERC03RDA',
                    style: style.ringCodeStyle,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              SmartText(
                '1.01 Carat Round Diamond',
                style: style.ringNameStyle,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  SmartRatingBar(
                    initialRating: 3,
                    itemSize: 16.w,
                    onRatingUpdate: (double value) {},
                  ),
                  SizedBox(width: 8.w),
                  SmartText(APPStrings.reviewsX.tr.interpolate([120]), style: style.reviewStyle)
                ],
              ),
              SizedBox(height: 20.h),
              Divider(height: 1.h),
              SizedBox(height: 20.h),
              _metalSelectionWidget(context, settingDetailBloc),
              SizedBox(height: 10.h),
              Divider(height: 1.h),
              SizedBox(height: 16.h),
              Row(
                children: [
                  SmartText(
                    APPStrings.approxPrice.tr,
                    style: style.approxPriceLabelStyle,
                  ),
                  SizedBox(width: 12.w),
                  SmartText(
                    '\$1200.00',
                    style: style.priceStyle,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  SmartText(
                    APPStrings.buyingInBulk.tr,
                    style: style.buyInBulkStyle,
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap: () {},
                    child: SmartText(
                      APPStrings.askForQuotation.tr,
                      style: style.askQuestionStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              SmartText(
                APPStrings.approxPriceNote.tr,
                style: style.approxPriceNoteStyle,
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  const SmartImage(path: AppImages.icDiamond),
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
                    style: style.shippingStyle,
                  )
                ],
              ),
              SizedBox(height: 32.h),
              Divider(height: 1.h),
              _buildSettingDetails(settingDetailBloc, style),
              const Divider(),
              _buildDiamondDetails(settingDetailBloc, style),
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
      },
    );
  }

  Widget _metalSelectionWidget(BuildContext context, SettingDetailBloc settingDetailBloc) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.metal.tr, style: style.metalHeaderStyle),
        SizedBox(height: 12.h),
        Container(
          height: 100.w,
          alignment: Alignment.center,
          width: context.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: settingDetailBloc.metalCustomisation.values?.length ?? 0,
            itemBuilder: (context, index) {
              return BlocBuilder<SettingDetailBloc, SettingDetailState>(
                buildWhen: (previous, current) =>
                    current is MetalCustomizationChangeState && (current.index == index || current.previousIndex == index),
                builder: (context, state) {
                  ProductCustomizationOptionValues value = settingDetailBloc.metalCustomisation.values![index];
                  bool isSelected = settingDetailBloc.metalCustomisation.selectedValue == value;
                  return SizedBox(
                    width: 72.w,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () {
                        settingDetailBloc.add(MetalCustomizationChangeEvent(index: index));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 34.w,
                              width: 34.w,
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected ? Border.all(color: style.selectedSettingBorderColor) : null,
                              ),
                              child: SmartImage(
                                path: value.image ?? '',
                                color: isSelected ? style.selectedSettingBorderColor : null,
                              ),
                            ),
                            if (value.value.isNotNullNorEmpty) ...[
                              SizedBox(height: 8.h),
                              SmartText(
                                value.value,
                                style: isSelected ? style.selectedSettingStyle : style.settingSelectionValueStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _settingWidget(String type, String value, SettingDetailScreenStyle style) {
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

  Widget _buildSettingDetails(SettingDetailBloc settingDetailBloc, SettingDetailScreenStyle style) {
    return BlocBuilder<SettingDetailBloc, SettingDetailState>(
      buildWhen: (_, current) => current is SettingToggleState,
      builder: (context, state) {
        return SmartExpansionTile(
          initiallyExpanded: settingDetailBloc.isSettingOpen,
          key: settingDetailBloc.settingDetailsKey,
          title: SmartText(
            APPStrings.settingDetails.tr,
            style: style.settingHeaderStyle,
          ),
          trailing: (settingDetailBloc.isSettingOpen)
              ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.selectedSettingBorderColor)
              : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.selectedSettingBorderColor),
          onExpansionChanged: (value) {
            settingDetailBloc.add(const SettingToggleEvent());
          },
          children: [
            _settingWidget(APPStrings.productType.tr, 'Engagement Ring', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.brand.tr, 'Flyerfit', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.meleeWeight.tr, 'SA-.25cts Dia-0.28cts', style),
            SizedBox(height: 28.h),
          ],
        );
      },
    );
  }

  Widget _buildDiamondDetails(SettingDetailBloc settingDetailBloc, SettingDetailScreenStyle style) {
    return BlocBuilder<SettingDetailBloc, SettingDetailState>(
      buildWhen: (_, current) => current is SettingDiamondToggleState,
      builder: (context, state) {
        return SmartExpansionTile(
          initiallyExpanded: settingDetailBloc.isDiamondDetailsOpen,
          key: settingDetailBloc.diamondDetailsKey,
          title: SmartText(
            APPStrings.diamondDetails.tr,
            style: style.settingHeaderStyle,
          ),
          trailing: (settingDetailBloc.isDiamondDetailsOpen)
              ? Icon(Icons.keyboard_arrow_up, size: 24.w, color: style.selectedSettingBorderColor)
              : Icon(Icons.keyboard_arrow_down, size: 24.w, color: style.selectedSettingBorderColor),
          onExpansionChanged: (value) {
            settingDetailBloc.add(const SettingDiamondDetailsToggleEvent());
          },
          children: [
            _settingWidget(APPStrings.shape.tr, 'Round', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.quantity.tr, '1', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.totalCarat.tr, '1', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.color.tr, 'F-G', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.clarity.tr, 'VS2-SI1', style),
            SizedBox(height: 14.h),
            _settingWidget(APPStrings.setting.tr, 'TypeThree Stone', style),
            SizedBox(height: 14.h),
          ],
        );
      },
    );
  }
}
