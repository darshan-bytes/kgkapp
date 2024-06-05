import 'package:kgk/kgk.dart';

class DiamondDetailScreen extends StatelessWidget {
  const DiamondDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diamondBloc = context.read<DiamondDetailBloc>();
    return Scaffold(
      appBar: SmartAppBar(
        title: '1.01 Carat Round Diamond',
        onFavorite: () {},
        onFilter: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (diamondBloc.screenIdentifier == ScreenIdentifier.diamondDetailForDIY)
              const DiyProgressWidget(
                selectedStep: 1,
              ),
            _imageSlider(diamondBloc),
            SizedBox(
              height: 40.h,
            ),
            _productDetail(context, diamondBloc)
          ],
        ),
      ),
      bottomNavigationBar: SmartButton(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
        onTap: () {
          context.pushNamed(AppRoutes.settingListingPage);
        },
        title: APPStrings.selectDiamond.tr,
      ),
    );
  }

  Widget _imageSlider(DiamondDetailBloc diamondBloc) {
    return BlocBuilder<DiamondDetailBloc, DiamondDetailState>(
      buildWhen: (_, current) => current is DiamondImagePageChangeState,
      builder: (context, state) {
        final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
        return Column(
          children: [
            CarouselSlider(
              items: diamondBloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: diamondBloc.controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.5,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    diamondBloc.add(DiamondImagePageChangeEvent(index: index));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: diamondBloc.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => diamondBloc.controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0.w,
                    height: 10.0.w,
                    margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: diamondBloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
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
          Divider(height: 1.h),
          SizedBox(height: 24.h),
          SmartText(
            '\$3,020',
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
          Divider(height: 1.h),
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
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 24.h),
          Divider(height: 1.h),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
