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
    return BlocBuilder<StonesLandingBloc, StonesLandingState>(
      buildWhen: (previous, current) => current is JewelleryStrapiDataFetchedState,
      builder: (context, state) {
        if (bloc.jewelleryStrapiList.isEmpty) {
          return const Center(child: SmartCircularProgressIndicator());
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await bloc.pullToRefresh(context);
          },
          child: ListView.builder(
              itemCount: bloc.jewelleryStrapiList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = bloc.jewelleryStrapiList[index];
                return bloc.getJewelleriesWidgetsFromSlug(
                    context, (item.slug)?.landingSlug ?? LandingSlug.unknown, bloc, style, homeScreenStyle, index);
              }),
        );
      },
    );
    // return Column(
    //   children: [
    //     StoneBannerView(
    //       imagePath: "https://i.ibb.co/SXyxfBq/Image-7.png",
    //       title: "Exquisite jewellery for  every occasion",
    //       subTitle: "Jewelry pieces hand-crafted to make your everyday special,your special days even more memorable.",
    //       naturalDiamondsButtonTitle: APPStrings.exploreNow.tr,
    //       onTapShopNaturalDiamonds: () {},
    //     ),
    //     _buildNewlyLaunchedSection(bloc, style),
    //     _buildShopByMetalSection(bloc: bloc, homeScreenStyle: homeScreenStyle, style: style),
    //     GetInspiredSection(
    //       title: APPStrings.topSellingCategories.tr,
    //       onTap: (context, auctionModel) {},
    //       itemList: bloc.topSellingCategoriesList,
    //       bloc: bloc,
    //       homeScreenStyle: homeScreenStyle,
    //       style: style,
    //       backgroundColor: style.designYourOwnStoneBgColor,
    //     ),
    //     _buildJewelleryBannerSection(style: style),
    //     _buildJewelleryCreateOwnSection(style: style)
    //   ],
    // );
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
      scrollController: bloc.shopByMetalScrollController,
      isScrollbarVisible: true,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsetsDirectional.only(start: 17.w),
      listPadding: EdgeInsetsDirectional.only(end: 17.w),
      padding: EdgeInsetsDirectional.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = bloc.shopByMetalList[index];
        return SmartImageTitleColumn(
          onTap: () {},
          imageWidth: 80.w,
          imagePadding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          title: item.name ?? '',
          titleStyle: style.sparkleSubTitleStyle,
          titleOptionalPadding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
          imageBetweenSpacing: 8.h,
          margin: EdgeInsetsDirectional.only(
            start: index == 0 ? 17.w : 0,
            end: index == bloc.shopByMetalList.length - 1 ? 17.w : 0,
            bottom: 10.h,
          ),
          titleMaxLines: 1,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  Widget _buildJewelleryBannerSection({required StonesLandingScreenStyle style}) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(
        children: [
          StonesBannerView(
            backgroundImagePath: "https://i.ibb.co/1J2wWPr/Image-4.png",
            bannerTitleText: "Design your own earrings",
            bannerSubTitleText: "Select your setting and diamonds to get exactly what you're looking for.",
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            padding: EdgeInsetsDirectional.all(16.w),
            backgroundImageHeight: 200.h,
            spaceBetweenTitleAndSubTitle: 4.h,
            buttonList: [
              SmartButton(onTap: () {}, title: APPStrings.getStarted.tr),
            ],
          ),
          SizedBox(height: 24.h),
          StonesBannerView(
            backgroundImagePath: "https://i.ibb.co/FVJDbvp/Image323.png",
            bannerTitleText: "Design your own necklace",
            bannerSubTitleText: "Customize a solitaire necklace with a setting and gemstone that suit your style.",
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            padding: EdgeInsetsDirectional.all(16.w),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
      child: StonesBannerView(
        crossAxisAlignment: CrossAxisAlignment.center,
        titleTextAlign: TextAlign.center,
        subTitleTextAlign: TextAlign.center,
        backgroundImagePath: "https://i.ibb.co/4VSsw5B/Image-8.png",
        bannerTitleText: "Create your own \nsignature piece",
        bannerSubTitleText: "Unleash your creativity and design your own exquisite jewelry piece that truly reflects your unique style.",
        bannerTitleStyle: style.sectionLabelStyle,
        bannerSubTitleStyle: style.jewelleryCreateOwnSubTitleStyle,
        padding: EdgeInsetsDirectional.all(16.w),
        backgroundImageHeight: 448.h,
        spaceBetweenTitleAndSubTitle: 4.h,
        buttonList: [
          SmartButton(onTap: () {}, title: APPStrings.startWithSetting.tr),
          SmartText(
            APPStrings.or.tr,
            optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 4.h),
          ),
          SmartButton(onTap: () {}, title: APPStrings.startWithDiamond.tr)
        ],
      ),
    );
  }
}
