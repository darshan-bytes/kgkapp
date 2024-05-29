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
            const DiyProgressWidget(
              selectedStep: 1,
            ),
            _imageSlider(diamondBloc),
            const SizedBox(
              height: 40,
            ),
            _productDetail(context, diamondBloc)
          ],
        ),
      ),
      bottomNavigationBar: SmartButton(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
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
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            'SKU 14178065',
            style: style.skuStyle,
          ),
          const SizedBox(height: 8),
          SmartText(
            '1.01 Carat Round Diamond',
            style: style.diamondNameStyle,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingBar(
                itemCount: 5,
                glowColor: colors(context).primary,
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
              const SizedBox(width: 8),
              SmartText(
                APPStrings.reviews.interpolate([120]).tr,
                style: style.reviewStyle,
              )
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 24),
          SmartText(
            '\$3,020',
            style: style.priceStyle,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SmartText(
                APPStrings.wantToSeeProductPhysically.tr,
                style: style.seeProductStyle,
              ),
              const SizedBox(width: 8),
              SmartText(
                APPStrings.orderSample.tr,
                style: style.orderSampleStyle,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 24),
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
                style: style.shippingStyle,
              )
            ],
          ),
          const SizedBox(height: 24),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
