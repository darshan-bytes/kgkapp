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
            _buildImageSlider(bloc),
            SizedBox(height: 39.h),
            _productDetail(context, bloc, style),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(AuctionBloc bloc) {
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
                },
              ),
            ),
            SizedBox(height: 16.h),
            _buildImageIndicator(bloc, imageCarouselStyle),
          ],
        );
      },
    );
  }

  Widget _buildImageIndicator(AuctionBloc bloc, ImageCarouselStyle style) {
    return Row(
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
              color: bloc.current == entry.key ? style.selectedDotColor : style.dotColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _productDetail(BuildContext context, AuctionBloc bloc, AuctionScreenStyle style) {
    final DiamondDetailScreenStyle diamondDetailScreenStyle = AppTheme.of(context).diamondDetailScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductHeader(diamondDetailScreenStyle),
          SizedBox(height: 8.h),
          _buildRatingSection(diamondDetailScreenStyle, style),
          SizedBox(height: 16.h),
          _compareWidget(bloc),
          SizedBox(height: 24.h),
          _priceSection(style),
          SizedBox(height: 12.h),
          _auctionRecentBidSection(),
          SizedBox(height: 24.h),
          _orderSampleSection(diamondDetailScreenStyle),
          SizedBox(height: 24.h),
          _additionalInfo(diamondDetailScreenStyle),
          SizedBox(height: 24.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 32.h),
          _buildYouMayAlsoLikeSection(bloc, context),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildProductHeader(DiamondDetailScreenStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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
            ],
          ),
        ),
        SizedBox(width: 17.w),
        SelectionButton(
          padding: EdgeInsets.all(12.w),
          isSelected: false,
          onTap: () {},
          image: AppImages.icHeart,
        ),
        SizedBox(width: 10.w),
        SelectionButton(
          padding: EdgeInsets.all(12.w),
          isSelected: false,
          onTap: () {},
          image: AppImages.icShare,
        ),
      ],
    );
  }

  Widget _buildRatingSection(DiamondDetailScreenStyle diamondDetailScreenStyle, AuctionScreenStyle style) {
    return Row(
      children: [
        RatingBar(
          itemCount: 5,
          glowColor: style.primaryColor,
          onRatingUpdate: (double value) {},
          initialRating: 4,
          allowHalfRating: false,
          itemSize: 16.sp,
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
          style: diamondDetailScreenStyle.reviewStyle,
        ),
      ],
    );
  }

  Widget _compareWidget(AuctionBloc bloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (previous, current) => current is AuctionProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: bloc.isCompare,
          onChanged: (value) {
            bloc.add(const AuctionProductCompareToggleEvent());
          },
          label: APPStrings.compareProduct.tr,
        );
      },
    );
  }

  Widget _priceSection(AuctionScreenStyle style) {
    return Row(
      children: [
        SmartText(APPStrings.subTotal.tr, style: style.bidPriceLableStyle),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            "\$1200.00",
            style: style.bidPriceStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _auctionRecentBidSection() {
    return const SizedBox();
  }

  Widget _orderSampleSection(DiamondDetailScreenStyle style) {
    return Row(
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
    );
  }

  Widget _additionalInfo(DiamondDetailScreenStyle style) {
    return Column(
      children: [
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
            ),
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYouMayAlsoLikeSection(AuctionBloc bloc, BuildContext context) {
    final MyBagScreenStyle myBagScreenStyle = AppTheme.of(context).myBagScreenStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          APPStrings.youMayAlsoLike.tr,
          style: myBagScreenStyle.productsTitleStyle,
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 12.w,
            runSpacing: 12.2,
            children: bloc.suggestedProductList.map((product) {
              return ProductGridItem(
                margin: EdgeInsets.only(bottom: 17.h),
                onEyeTap: () {},
                onFavTap: () {},
                productDetails: product,
                isStoneWithPrice: true,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
