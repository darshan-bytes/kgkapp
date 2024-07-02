import 'package:kgk/kgk.dart';

class JewelleryLandingScreen extends StatelessWidget {
  final StonesLandingBloc bloc;
  final StonesLandingScreenStyle style;
  final HomeScreenStyle homeScreenStyle;

  const JewelleryLandingScreen({
    super.key,
    required this.bloc,
    required this.style,
    required this.homeScreenStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoneBannerView(
          imagePath: "https://i.ibb.co/SXyxfBq/Image-7.png",
          title: "Exquisite jewellery for  every occasion",
          subTitle: "Jewelry pieces hand-crafted to make your everyday special,your special days even more memorable.",
          naturalDiamondsButtonTitle: APPStrings.exploreNow.tr,
          onTapShopNaturalDiamonds: () {},
        ),
        _buildNewlyLaunchedSection(bloc, style),
        _buildShopByMetalSection(bloc: bloc, homeScreenStyle: homeScreenStyle, style: style),
        GetInspiredSection(
          title: APPStrings.topSellingCategories.tr,
          onTap: (context, auctionModel) {},
          itemList: bloc.topSellingCategoriesList,
          bloc: bloc,
          homeScreenStyle: homeScreenStyle,
          style: style,
          backgroundColor: style.designYourOwnStoneBgColor,
        ),
        _buildJewelleryBannerSection(style: style),
        _buildJewelleryCreateOwnSection(style: style)
      ],
    );
  }

  Widget _buildNewlyLaunchedSection(StonesLandingBloc bloc, StonesLandingScreenStyle style) {
    return Container(
      color: style.newlyLaunchedBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 32.h,
        horizontal: 17.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(APPStrings.newlyLaunched.tr, style: style.newlyLaunchedStyle),
          SizedBox(height: 4.h),
          SmartText(APPStrings.exploreNewlyLaunchedProducts.tr, style: style.sparkleSubTitleStyle),
          SizedBox(height: 24.h),
          SmartGridView(
            items: List.generate(
              bloc.newlyLaunchedItemsList.length > 4
                  ? 4
                  : (bloc.newlyLaunchedItemsList.length % 2 == 0
                      ? bloc.newlyLaunchedItemsList.length
                      : bloc.newlyLaunchedItemsList.length - 1),
              (index) => ProductGridItem(
                productDetails: bloc.newlyLaunchedItemsList[index],
                onEyeTap: () {},
                onFavTap: () {},
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SmartButton(
            onTap: () {},
            title: APPStrings.exploreNow.tr,
          )
        ],
      ),
    );
  }

  Widget _buildShopByMetalSection({
    required StonesLandingBloc bloc,
    required HomeScreenStyle homeScreenStyle,
    required StonesLandingScreenStyle style,
  }) {
    return SmartHorizontalItemBuilder(
      title: APPStrings.shopByMetal.tr,
      titleStyle: style.sectionLabelStyle,
      itemCount: bloc.shopByMetalList.length,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w),
      padding: EdgeInsets.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = bloc.shopByMetalList[index];
        return SmartImageTitleColumn(
          onTap: () {},
          imageWidth: 80.w,
          imagePadding: EdgeInsets.symmetric(horizontal: 20.w),
          title: item.name ?? '',
          titleStyle: style.sparkleSubTitleStyle,
          titleOptionalPadding: EdgeInsets.symmetric(horizontal: 4.w),
          imageBetweenSpacing: 8.h,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == bloc.shopByMetalList.length - 1 ? 17.w : 0,
          ),
          // imagePadding: EdgeInsets.all(12.w),
          titleMaxLines: 1,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  Widget _buildJewelleryBannerSection({required StonesLandingScreenStyle style}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(
        children: [
          StonesBannerView(
            backgroundImagePath: "https://i.ibb.co/1J2wWPr/Image-4.png",
            bannerTitleText: "Design your own earrings",
            bannerSubTitleText: "Select your setting and diamonds to get exactly what you're looking for.",
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            padding: EdgeInsets.all(16.w),
            backgroundImageHeight: 200.h,
            spaceBetweenTitleAndSubTitle: 4.h,
            buttonList: [
              SmartButton(onTap: () {}, title: APPStrings.getStarted.tr),
            ],
          ),
          SizedBox(height: 24.h),
          StonesBannerView(
            backgroundImagePath: "https://i.ibb.co/1J2wWPr/Image-4.png",
            bannerTitleText: "Design your own necklace",
            bannerSubTitleText: "Customize a solitaire necklace with a setting and gemstone that suit your style.",
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            padding: EdgeInsets.all(16.w),
            backgroundImageHeight: 200.h,
            spaceBetweenTitleAndSubTitle: 4.h,
            buttonList: [
              SmartButton(onTap: () {}, title: APPStrings.getStarted.tr),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildJewelleryCreateOwnSection({required StonesLandingScreenStyle style}) {
    return Container(
      color: style.designYourOwnStoneBgColor,
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      child: StonesBannerView(
        crossAxisAlignment: CrossAxisAlignment.center,
        titleTextAlign: TextAlign.center,
        subTitleTextAlign: TextAlign.center,
        backgroundImagePath: "https://i.ibb.co/4VSsw5B/Image-8.png",
        bannerTitleText: "Create your own \nsignature piece",
        bannerSubTitleText: "Unleash your creativity and design your own exquisite jewelry piece that truly reflects your unique style.",
        bannerTitleStyle: style.sectionLabelStyle,
        bannerSubTitleStyle: style.jewelleryCreateOwnSubTitleStyle,
        padding: EdgeInsets.all(16.w),
        backgroundImageHeight: 448.h,
        spaceBetweenTitleAndSubTitle: 4.h,
        buttonList: [
          SmartButton(onTap: () {}, title: APPStrings.startWithSetting.tr),
          SmartText(
            APPStrings.or.tr,
            optionalPadding: EdgeInsets.symmetric(vertical: 4.h),
          ),
          SmartButton(onTap: () {}, title: APPStrings.startWithDiamond.tr)
        ],
      ),
    );
  }
}
