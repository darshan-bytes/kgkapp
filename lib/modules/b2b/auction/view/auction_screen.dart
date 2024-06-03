import 'package:kgk/kgk.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionBloc bloc = BlocProvider.of<AuctionBloc>(context);
    final AuctionScreenStyle style = AppTheme.of(context).auctionScreenStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: '1.01 Carat Round Diamond',
        onFavorite: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageSlider(bloc),
            SizedBox(height: 39.h),
            _productDetail(context),
          ],
        ),
      ),
    );
  }

  Widget _imageSlider(AuctionBloc bloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (_, current) => current is AuctionDiamondImagePageChangeState,
      builder: (context, state) {
        final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
        return Column(
          children: [
            CarouselSlider(
              items: bloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: bloc.controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.5,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    bloc.add(AuctionDiamondImagePageChangeEvent(index: index));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bloc.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => bloc.controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0.w,
                    height: 8.0.w,
                    margin: EdgeInsets.only(right: 6.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _productDetail(BuildContext context) {
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
              SizedBox(width: 8.w),
              SmartText(
                APPStrings.reviews.interpolate([120]).tr,
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
