import 'package:kgk/kgk.dart';

class GemstoneLandingScreen extends StatelessWidget {
  final StonesLandingBloc bloc;
  final StonesLandingScreenStyle style;
  final HomeScreenStyle homeScreenStyle;

  const GemstoneLandingScreen({super.key, required this.bloc, required this.style, required this.homeScreenStyle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StonesLandingBloc, StonesLandingState>(
      buildWhen: (previous, current) => current is GemstoneStrapiDataFetchedState,
      builder: (context, state) {
        if (bloc.gemstoneStrapiList.isEmpty) {
          return const Center(child: SmartCircularProgressIndicator());
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await bloc.pullToRefresh(context);
          },
          child: ListView.builder(
            itemCount: bloc.gemstoneStrapiList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = bloc.gemstoneStrapiList[index];
              return bloc.getGemStoneWidgetsFromSlug(
                context,
                (item.slug)?.landingSlug ?? LandingSlug.unknown,
                bloc,
                style,
                homeScreenStyle,
                index,
              );
            },
          ),
        );
      },
    );
    // return Column(
    //   children: [
    //     StoneBannerView(
    //       imagePath: "https://i.ibb.co/3cc2W14/Image-5.png",
    //       title: "Design your own \ngemstone ring",
    //       subTitle: "Show your true colours with a striking gemstone set in the perfect ring.",
    //       naturalDiamondsButtonTitle: APPStrings.startWithAGemstone.tr,
    //       onTapShopNaturalDiamonds: () {},
    //       labDiamondsButtonTitle: APPStrings.startWithASetting.tr,
    //       onTapShopLabDiamonds: () {},
    //     ),
    //     ShopStoneByShapeSection(
    //       title: APPStrings.shopByGemstones.tr,
    //       itemList: bloc.shopGemstonesList,
    //       onTap: (context, item) {},
    //       homeScreenStyle: homeScreenStyle,
    //       style: style,
    //       scrollController: bloc.shopGemstonesScrollController,
    //     ),
    //     CraftedForYourSpecialMomentSection(
    //       style: style,
    //       title: "Crafted for your special moment",
    //       buttonCallBack: () {},
    //       buttonTitle: APPStrings.shopGemstones.tr,
    //       description:
    //           "Every occasion deserves its tribute. Our lab grown diamonds are a high-quality, affordable way to mark your moment.",
    //       backgroundImage: "https://i.ibb.co/NnpfYJW/Image.png",
    //     ),
    //     GetInspiredSection(
    //       title: APPStrings.shopByStyle.tr,
    //       onTap: (context, auctionModel) {},
    //       itemList: bloc.shopByStyleList,
    //       bloc: bloc,
    //       homeScreenStyle: homeScreenStyle,
    //       style: style,
    //     ),
    //     DesignYourOwnStoneSection(
    //       style: style,
    //       mainBannerTitle: "Design your own gemstone ring",
    //       mainBannerDescription:
    //           "Select your ideal ring setting, and let it embrace the brilliance of our gemstones, creating a timeless and exquisite symbol of love.",
    //       mainBannerForegroundImagePath: "https://i.ibb.co/VQJg0qY/image-359.png",
    //       mainBannerFirstButtonTitle: APPStrings.startWithAGemstone.tr,
    //       mainBannerFirstButtonCallback: () {},
    //       mainBannerSecondButtonTitle: APPStrings.startWithASetting.tr,
    //       mainBannerSecondButtonCallback: () {},
    //       firstBannerTitle: "Gemstone earrings",
    //       firstBannerDescription: "Lovingly handcrafted in a range of natural gemstones including sapphires",
    //       firstBannerBackgroundImagePath: "https://i.ibb.co/PmbCP2P/Group-18436.png",
    //       firstBannerButtonTitle: APPStrings.exploreNow.tr,
    //       firstBannerButtonCallback: () {},
    //       secondBannerTitle: "Gemstone necklaces",
    //       secondBannerDescription: "Lovingly handcrafted in a range of natural gemstones including sapphires",
    //       secondBannerBackgroundImagePath: "https://i.ibb.co/TWp6yPg/Image-6.png",
    //       secondBannerButtonTitle: APPStrings.exploreNow.tr,
    //       secondBannerButtonCallback: () {},
    //     ),
    //     AboutOurStoneSection(
    //       style: style,
    //       title: APPStrings.aboutOurGemstones.tr,
    //       imagePath: "https://i.ibb.co/M6TZT3y/image-304.png",
    //       subTitle:
    //           "A gemstone is a mineral or rock that is cut and polished for use in jewellery or other decorative items. There are hundreds of gemstones, but the most common are diamonds, rubies, emeralds, sapphires, and pearls. Gemstones are formed deep within the Earth's crust under extreme heat and pressure. They are found in various locations around the world, including mines, riverbeds, and volcanic areas.\n\nThe rarest gemstone is painite, discovered in Myanmar in the 1950s.",
    //     ),
    //     StonesFAQSection(
    //       title: APPStrings.gemstonesFAQs.tr,
    //       style: style,
    //       faqs: bloc.gemstoneFAQS,
    //     ),
    //   ],
    // );
  }
}
