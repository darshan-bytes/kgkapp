import 'package:kgk/kgk.dart';

class StoneDetailScreen extends StatelessWidget {
  const StoneDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoneDetailBloc>(context);
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: bloc.productName,
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
      ),
      body: SmartSingleChildScrollView(
        child: BlocBuilder<StoneDetailBloc, StoneDetailState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY) const DiyProgressWidget(selectedStep: 1),
                SmartCarouselSlider(imgList: bloc.imgList, controller: bloc.controller),
                SizedBox(height: 40.h),
                _productDetail(context, bloc)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 17.w),
        decoration: BoxDecoration(
          color: style.colorWhite,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmartImage(path: bloc.imgList.isNotNullNorEmpty ? bloc.imgList.first : '', height: 55.w, width: 55.w),
              Expanded(
                flex: 4,
                child: SmartText(
                  bloc.productDetails?.displayPrice,
                  style: style.priceStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 4,
                child: SmartButton(
                  onTap: () {
                    bloc.add(StoneDetailSelectStoneForDIYEvent(context: context));
                  },
                  padding: EdgeInsets.zero,
                  title: APPStrings.selectDiamond.tr,
                  height: 55.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productDetail(BuildContext context, StoneDetailBloc bloc) {
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bloc.productDetails?.lotCode != null) ...[
            SmartText(
              bloc.productDetails?.lotCode,
              style: style.skuStyle,
            ),
            SizedBox(height: 8.h),
          ],
          SmartText(
            bloc.productName,
            style: style.diamondNameStyle,
          ),
          SizedBox(height: 14.h),
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
          _diamondDetails(bloc),
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

  Widget _diamondDetails(StoneDetailBloc diamondDetailsBloc) {
    return BlocBuilder<StoneDetailBloc, StoneDetailState>(
      buildWhen: (previous, current) => current is StoneDetailsToggleState,
      builder: (context, state) {
        final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
        return Padding(
          padding: diamondDetailsBloc.isStoneDetailsOpen ? const EdgeInsets.only(bottom: 28) : EdgeInsets.zero,
          child: SmartExpansionTile(
            initiallyExpanded: diamondDetailsBloc.isStoneDetailsOpen,
            key: diamondDetailsBloc.stoneDetailsKey,
            title: SmartText(
              APPStrings.diamondDetails.tr,
              style: style.settingSelectionTitleStyle,
            ),
            trailing: Icon(
              diamondDetailsBloc.isStoneDetailsOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 24.w,
              color: style.ratingGlowColor,
            ),
            onExpansionChanged: (value) {
              diamondDetailsBloc.add(const StoneDetailsToggleEvent());
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
