import 'package:kgk/kgk.dart';

class DiamondLandingScreen extends StatelessWidget {
  final StonesLandingBloc bloc;
  final StonesLandingScreenStyle style;
  final HomeScreenStyle homeScreenStyle;

  const DiamondLandingScreen({
    super.key,
    required this.bloc,
    required this.style,
    required this.homeScreenStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StonesLandingBloc, StonesLandingState>(
      buildWhen: (previous, current) => current is DiamondStrapiDataFetchedState,
      builder: (context, state) {
        if (bloc.diamondStrapiList.isEmpty) {
          return const Center(child: SmartCircularProgressIndicator());
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await bloc.pullToRefresh(context);
          },
          child: ListView.builder(
              itemCount: bloc.diamondStrapiList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = bloc.diamondStrapiList[index];
                return bloc.getDiamondWidgetsFromSlug(
                    context, getLandingSlugFromString(item.slug?.slug ?? ''), bloc, style, homeScreenStyle, index);
              }),
        );
        // return Column(
        //   children: [
        //     StoneBannerView(
        //       imagePath: "https://i.ibb.co/7v98ZZF/Image-1.png",
        //       title: "Sparkle and shine",
        //       subTitle: "Cherished for their unique beauty, diamonds are the ultimate way to mark your moment and create a sparkling memory.",
        //       naturalDiamondsButtonTitle: APPStrings.shopNaturalDiamonds.tr,
        //       onTapShopNaturalDiamonds: () {},
        //       labDiamondsButtonTitle: APPStrings.shopLabDiamonds.tr,
        //       onTapShopLabDiamonds: () {},
        //     ),
        //     ShopStoneByShapeSection(
        //       title: APPStrings.shopDiamondsByShape.tr,
        //       itemList: bloc.shopDiamondsByStyleList,
        //       onTap: (context, item) {},
        //       homeScreenStyle: homeScreenStyle,
        //       style: style,
        //       scrollController: bloc.shopDiamondsScrollController,
        //     ),
        //     CraftedForYourSpecialMomentSection(
        //       style: style,
        //       title: "Crafted for your special moment",
        //       buttonCallBack: () {},
        //       buttonTitle: APPStrings.shopDiamonds.tr,
        //       description:
        //       "Every occasion deserves its tribute. Our lab grown diamonds are a high-quality, affordable way to mark your moment.",
        //       backgroundImage: "https://i.ibb.co/NnpfYJW/Image.png",
        //     ),
        //     _buildOriginOfDiamondsSection(bloc, style, homeScreenStyle),
        //     GetInspiredSection(
        //       title: APPStrings.getInspired.tr,
        //       onTap: (context, auctionModel) {},
        //       itemList: bloc.getInspiredList,
        //       bloc: bloc,
        //       homeScreenStyle: homeScreenStyle,
        //       style: style,
        //     ),
        //     DesignYourOwnStoneSection(
        //       style: style,
        //       mainBannerTitle: "Design your own diamond ring",
        //       mainBannerDescription:
        //       "Select your ideal ring setting, and let it embrace the brilliance of our handpicked diamonds, creating a timeless and exquisite symbol of love.",
        //       mainBannerForegroundImagePath: "https://i.ibb.co/hZ4YjSR/Image-3.png",
        //       mainBannerFirstButtonTitle: APPStrings.startWithANaturalDiamond.tr,
        //       mainBannerFirstButtonCallback: () {},
        //       mainBannerSecondButtonTitle: APPStrings.startWithALabDiamond.tr,
        //       mainBannerSecondButtonCallback: () {},
        //       firstBannerTitle: "Design your own earrings",
        //       firstBannerDescription: "Select your setting and diamonds to get exactly what you're looking for.",
        //       firstBannerBackgroundImagePath: "https://i.ibb.co/1J2wWPr/Image-4.png",
        //       firstBannerButtonTitle: APPStrings.getStarted.tr,
        //       firstBannerButtonCallback: () {},
        //       secondBannerTitle: "Design your own necklace",
        //       secondBannerDescription: "Customize a solitaire necklace with a setting and gemstone that suit your style.",
        //       secondBannerBackgroundImagePath: "https://i.ibb.co/FVJDbvp/Image323.png",
        //       secondBannerButtonTitle: APPStrings.getStarted.tr,
        //       secondBannerButtonCallback: () {},
        //     ),
        //     AboutOurStoneSection(
        //       style: style,
        //       title: APPStrings.aboutOurDiamonds.tr,
        //       imagePath: "https://i.ibb.co/M6TZT3y/image-304.png",
        //       subTitle: "All diamonds are hand-picked and calibrated to 100th of an mm when selecting the diamonds for all settings.",
        //     ),
        //     StonesFAQSection(
        //       title: APPStrings.diamondFAQs.tr,
        //       style: style,
        //       faqs: bloc.diamondFAQS,
        //     ),
        //   ],
        // );
      },
    );
  }

  Widget _buildOriginOfDiamondsSection(StonesLandingBloc bloc, StonesLandingScreenStyle style, HomeScreenStyle homeScreenStyle) {
    return SmartHorizontalItemBuilder(
      title: APPStrings.originOfDiamonds.tr,
      widgetBetweenTitleAndItems: SmartText(
        "Billions of years ago, carbon atoms formed in Earth's mantle under intense heat and pressure, later surfacing through volcanic activity for mining.",
        optionalPadding: EdgeInsets.only(left: 17.w, top: 12.h, right: 17.w, bottom: 16.h),
        style: style.originSectionSubTitleStyle,
      ),
      titleStyle: style.sectionLabelStyle,
      backgroundColor: style.originSectionBgColor,
      itemCount: bloc.originOfDiamondsList.length,
      itemBetweenSpace: 17.w,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w),
      padding: EdgeInsets.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = bloc.originOfDiamondsList[index];
        return SmartImageTitleColumn(
          onTap: () {},
          width: 88.w,
          title: item.name ?? '',
          titleStyle: homeScreenStyle.shopGemstoneTitleStyle,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == bloc.originOfDiamondsList.length - 1 ? 17.w : 0,
          ),
          titleMaxLines: 1,
          fit: BoxFit.fill,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }
}
