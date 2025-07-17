import 'package:kgk/kgk.dart';

class StoneDetailScreen extends StatelessWidget {
  const StoneDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoneDetailBloc>(context);
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    ProductDetailsStyle productDetailsStyle = AppTheme.of(context).productDetailsStyle;
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
                if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY || bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY)
                  DiyProgressWidget(
                    diyType: bloc.diyType,
                    selectedStep: bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ? 1 : 2,
                    screenIdentifier: bloc.screenIdentifier,
                  ),
                SmartCarouselSlider(imgList: bloc.imgList, controller: bloc.controller),
                SizedBox(height: 10.h),
                _productDetail(context, bloc),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 14.h, horizontal: 17.w),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SmartImage(path: bloc.imgList.isNotEmpty ? bloc.imgList.first : '', height: 54.w, width: 54.w),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SmartText(
                              bloc.productDetails?.finalPrice.isNotNullNorEmpty == true
                                  ? "${bloc.productDetails?.finalPrice}\n"
                                  : bloc.productDetails?.originalPrice,
                              style: style.priceStyle,
                              maxLines: 1,
                              isAutoSizeText: true,
                            ),
                            if (bloc.productDetails?.finalPrice.isNotNullNorEmpty == true &&
                                (bloc.productDetails?.finalPrice != bloc.productDetails?.originalPrice)) ...[
                              SmartText(
                                bloc.productDetails?.originalPrice,
                                style: productDetailsStyle.originalPriceStyle.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              SmartText(
                                bloc.productDetails?.discountPercentageString,
                                style: productDetailsStyle.discountStyle,
                                maxLines: 1,
                              ),
                            ],
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
                  onTap: () {
                    bloc.add(StoneDetailSelectStoneForDIYEvent(context: context));
                  },
                  title: bloc.diyType == DIYType.gemstone ? APPStrings.selectGemstone.tr : APPStrings.selectDiamond.tr,
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bloc.productDetails?.lotCode != null) ...[
            SmartText(bloc.productDetails?.lotCode, style: style.skuStyle),
            SizedBox(height: 8.h),
          ],
          SmartText(bloc.productName, style: style.diamondNameStyle),
          SizedBox(height: 14.h),
          Row(
            children: [
              SmartImage(path: AppImages.icDiamond, height: 24.w, width: 24.w),
              SizedBox(width: 16.w),
              SmartText(APPStrings.diamondPurityYouCanTrust.tr, style: style.diamondPurityStyle),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              SizedBox(width: 16.w),
              SmartText(APPStrings.shippingAcrossAllCountries.tr, style: style.shippingStyle),
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(),
          ProductDetailsComponentsView(commodity: Commodity.diamond, components: [], stoneElements: bloc.productDetails?.stoneElements),
          Divider(height: 1.h),
          SizedBox(height: 24.h),
          const InquiryWidget(email: 'enquiry.diaind@kgkmail.com', phone: '+91 - 1234567830'),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [SmartText(type, style: style.settingTypeStyle), SmartText(value, style: style.settingValueStyle)],
    );
  }
}
