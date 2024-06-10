import 'package:kgk/kgk.dart';

class DiamondDetailScreen extends StatelessWidget {
  const DiamondDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diamondBloc = context.read<DiamondDetailBloc>();
    return Scaffold(
      appBar: SmartAppBar(
        title: '1.01 Carat Round Diamond',
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DiamondDetailBloc, DiamondDetailState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (diamondBloc.screenIdentifier == ScreenIdentifier.diamondForDIY)
                  const DiyProgressWidget(
                    selectedStep: 1,
                  ),
                SmartCarouselSlider(
                  imgList: diamondBloc.imgList,
                  controller: diamondBloc.controller,
                ),
                SizedBox(
                  height: 40.h,
                ),
                _productDetail(context, diamondBloc)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SmartButton(
          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
          onTap: () {
            context.pushNamed(AppRoutes.settingListingPage);
          },
          title: APPStrings.selectDiamond.tr,
        ),
      ),
    );
  }

  Widget _productDetail(BuildContext context, DiamondDetailBloc diamondBloc) {
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            'SKU 14178065',
            style: style.skuStyle,
          ),
          SizedBox(height: 8.h),
          SmartText(
            '1.01 Carat Round Diamond',
            style: style.diamondNameStyle,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SmartRatingBar(initialRating: 4, itemSize: 16.w, onRatingUpdate: (double value) {}),
              SizedBox(width: 8.w),
              SmartText(
                APPStrings.reviewsX.tr.interpolate([4]),
                style: style.reviewStyle,
              )
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(),
          SizedBox(height: 24.h),
          SmartText(
            '\$3,020.00',
            style: style.priceStyle,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SmartText(
                APPStrings.wantToSeeProductPhysically.tr,
                style: style.seeProductStyle,
              ),
              SizedBox(width: 8.w),
              SmartText(
                APPStrings.orderSample.tr,
                style: style.orderSampleStyle,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(),
          SizedBox(height: 24.h),
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
                style: style.shippingStyle,
              )
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(),
          _diamondDetails(diamondBloc),
          Divider(height: 1.h),
          SizedBox(height: 24.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _diamondDetails(DiamondDetailBloc diamondDetailsBloc) {
    return BlocBuilder<DiamondDetailBloc, DiamondDetailState>(
      buildWhen: (previous, current) => current is DiamondDetailsToggleState,
      builder: (context, state) {
        final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
        return Padding(
          padding: diamondDetailsBloc.isDiamondDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: diamondDetailsBloc.isDiamondDetailsOpen,
            key: diamondDetailsBloc.diamondDetailsKey,
            title: SmartText(
              APPStrings.diamondDetails.tr,
              style: style.settingSelectionTitleStyle,
            ),
            trailing: Icon(
              diamondDetailsBloc.isDiamondDetailsOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 24.w,
              color: style.ratingGlowColor,
            ),
            onExpansionChanged: (value) {
              diamondDetailsBloc.add(const DiamondDetailsToggleEvent());
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
}
