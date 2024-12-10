import 'package:kgk/kgk.dart';

class HomeWidgets {
  // ignore: unused_element
  static Widget buildShopByBrandsSection(HomeBloc homeBloc, HomeScreenStyle style) {
    return SmartHorizontalItemBuilder(
      title: APPStrings.shopByBrands.tr,
      scrollController: homeBloc.shopByBrandsScrollController,
      isScrollbarVisible: true,
      titleStyle: style.bannerTitleStyle,
      itemCount: homeBloc.shopByBrands.length,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w, bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 22.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = homeBloc.shopByBrands[index];
        return SmartImageTitleColumn(
          onTap: () {},
          imageWidth: 72.w,
          title: item.name ?? '',
          titleStyle: style.shopGemstoneTitleStyle,
          imageBetweenSpacing: 8.h,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == homeBloc.jewelleryList.length - 1 ? 17.w : 0,
          ),
          titleMaxLines: 1,
          fit: BoxFit.fill,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  static Widget buildJewelleryList(HomeBloc homeBloc, HomeScreenStyle style) {
    return SmartHorizontalItemBuilder(
      itemCount: homeBloc.jewelleryList.length,
      itemBetweenSpace: 16.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      padding: EdgeInsets.only(top: 16.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = homeBloc.jewelleryList[index];
        return SmartImageTitleColumn(
          onTap: () {
            homeBloc.handleRedirection(
                context: context,
                redirectTo: getRedirectionToFromString(item.redirectTo ?? ''),
                redirectionType: getRedirectionTypeFromString(item.redirectionType ?? ""));
          },
          imageUrl: item.imageUrl ?? '',
          title: item.name ?? '',
          imageWidth: 80.w,
          imageHeight: 80.w,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == homeBloc.jewelleryList.length - 1 ? 17.w : 0,
          ),
          imageBorderRadius: BorderRadius.circular(50.r),
          fit: BoxFit.fitWidth,
          imageBorder: Border.all(color: style.borderColor, width: 1.w),
        );
      },
    );
  }

  static Widget buildEngagementImageSlider(HomeBloc homeBloc, List<AuctionListModel> dataList) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (_, current) => current is HomeJewelleryImagePageChangeState || current is HomeReloadState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
          child: Column(
            children: [
              CarouselSlider(
                items: dataList
                    .map((e) => GestureDetector(
                        onTap: () {
                          homeBloc.handleRedirection(
                              context: context,
                              redirectTo: getRedirectionToFromString(e.redirectTo ?? ''),
                              redirectionType: getRedirectionTypeFromString(e.redirectionType ?? ""));
                        },
                        child: SmartImage(path: e.imageUrl ?? '', fit: BoxFit.fitWidth)))
                    .toList(),
                carouselController: homeBloc.engagementListCarouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  aspectRatio: 2,
                  onPageChanged: (index, reason) => homeBloc.add(HomeJewelleryImagePageChangeEvent(index: index)),
                ),
              ),
              SizedBox(height: 16.h),
              buildImageIndicator(
                homeBloc,
                context: context,
                itemList: dataList,
                carouselController: homeBloc.engagementListCarouselController,
                currentIndex: homeBloc.currentCarouselIndex,
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget buildShopBySpacificCategory(
    HomeBloc homeBloc,
    HomeScreenStyle style, {
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        SmartText(APPStrings.shopByCategory.tr, style: style.bannerTitleStyle),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final spacing = 6.0.w;

              List<Widget> imageWidgets = [];
              for (int i = 0; i < homeBloc.shopBySpacificCategory.length; i++) {
                double width;
                if (i < 3) {
                  width = (screenWidth - 2 * spacing) / 3;
                } else {
                  width = (screenWidth - spacing) / 2;
                }

                imageWidgets.add(SizedBox(
                  width: width,
                  height: 130.h,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SmartImage(
                        path: homeBloc.shopBySpacificCategory[i].imageUrl ?? '',
                        fit: BoxFit.fill,
                        imageBorderRadius: BorderRadius.circular(8.r),
                      ),
                      if (homeBloc.shopBySpacificCategory[i].name.isNotNullNorEmpty)
                        Positioned(
                          bottom: 4.h,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: style.whiteColor,
                                ),
                                child: SmartText(
                                  homeBloc.shopBySpacificCategory[i].name ?? '',
                                  style: style.dropDownTextStyle.merge(TextStyle(fontSize: 12.sp)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ));
              }

              return Wrap(
                spacing: spacing, // space between items
                runSpacing: spacing, // space between rows
                children: imageWidgets,
              );
            },
          ),
        )
      ],
    );
  }

  static Widget buildTrendingView(HomeBloc homeBloc, HomeScreenStyle style) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20.h),
      Padding(
        padding: EdgeInsets.only(left: 6.w),
        child: SmartText(APPStrings.trendingNow.tr, style: style.bannerTitleStyle),
      ),
      SizedBox(height: 20.h),
      SizedBox(
        height: 170.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeBloc.trendingList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130.h,
                width: 180.w,
                margin: EdgeInsets.only(left: 6.w, right: index == homeBloc.trendingList.length - 1 ? 6.w : 0),
                child: SmartImage(
                    path: homeBloc.trendingList[index].imageUrl ?? '', fit: BoxFit.cover, imageBorderRadius: BorderRadius.circular(8.r)),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SmartText(homeBloc.trendingList[index].name,
                    style: style.dropDownTextStyle.merge(TextStyle(fontSize: 14.sp)), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20.h),
    ]);
  }

  static Widget buildPopularView(
    HomeBloc homeBloc,
    HomeScreenStyle style, {
    required String title,
    required List<AuctionListModel> popularList,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20.h),
      Padding(
        padding: EdgeInsets.only(left: 6.w),
        child: SmartText(title, style: style.bannerTitleStyle),
      ),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 160.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: popularList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160.h,
                width: 130.w,
                margin: EdgeInsets.only(left: 6.w, right: index == popularList.length - 1 ? 6.w : 0),
                child: Stack(
                  children: [
                    SmartImage(
                        path: popularList[index].imageUrl ?? '',
                        fit: BoxFit.cover,
                        height: 160.h,
                        imageBorderRadius: BorderRadius.circular(8.r)),
                    if (popularList[index].name.isNotNullNorEmpty)
                      Container(
                          width: 100.w,
                          height: 24.h,
                          margin: EdgeInsets.only(top: 6.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                            gradient: LinearGradient(
                                colors: [
                                  style.primaryColor.withOpacity(0.6),
                                  style.primaryColor.withOpacity(0.9),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: const [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Center(
                            child: SmartText(
                              popularList[index].name,
                              style: style.dropDownTextStyle.merge(TextStyle(fontSize: 12.sp, color: Colors.white)),
                            ),
                          )),
                    if (popularList[index].percentageOff.isNotNullNorEmpty)
                      Positioned(
                        bottom: 6.h,
                        left: 6.w,
                        right: 6.w,
                        child: SmartText(popularList[index].percentageOff,
                            style: style.getInspiredTitleStyle.merge(TextStyle(fontSize: 20.sp))),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 20.h),
    ]);
  }

  static Widget buildHorizontalSlider(HomeBloc homeBloc, HomeScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: SmartText(APPStrings.shopLatestCollection.tr, style: style.bannerTitleStyle),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: homeBloc.latestCollectionList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.only(left: 6.w, right: index == homeBloc.latestCollectionList.length - 1 ? 6.w : 0),
              child: SmartImage(
                path: homeBloc.latestCollectionList[index].imageUrl ?? '',
                fit: BoxFit.fitHeight,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  static Widget buildImageIndicator(HomeBloc homeBloc,
      {required List itemList,
      CarouselSliderController? carouselController,
      required int currentIndex,
      required BuildContext context,
      VoidCallback? onTap}) {
    final ImageCarouselStyle style = AppTheme.of(context).imageCarouselStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: itemList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: onTap ?? () => carouselController?.animateToPage(entry.key),
          child: Container(
            width: 8.0.w,
            height: 8.0.w,
            margin: EdgeInsets.only(right: 6.0.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == entry.key ? style.selectedDotColor : style.dotColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget buildShopDiamondSection(HomeBloc homeBloc, HomeScreenStyle style) {
    return SmartHorizontalItemBuilder(
      title: APPStrings.shopDiamonds.tr,
      scrollController: homeBloc.shopDiamondsScrollController,
      isScrollbarVisible: false,
      titleStyle: style.bannerTitleStyle,
      itemCount: homeBloc.shopDiamondsList.length,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w, bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 22.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = homeBloc.shopDiamondsList[index];
        return SmartImageTitleColumn(
          onTap: () {
            context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault});
          },
          width: 72.w,
          title: item.name ?? '',
          titleStyle: style.shopGemstoneTitleStyle,
          imageBetweenSpacing: 8.h,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == homeBloc.jewelleryList.length - 1 ? 17.w : 0,
          ),
          imagePadding: EdgeInsets.all(12.w),
          titleMaxLines: 1,
          fit: BoxFit.fill,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  static Widget buildShopGemstoneSection(HomeBloc homeBloc, HomeScreenStyle style,
      {required List<AuctionListModel> imgList, required double width, required String title}) {
    return SmartHorizontalItemBuilder(
      title: title,
      titleStyle: style.bannerTitleStyle,
      isScrollbarVisible: false,
      scrollController: homeBloc.shopGemstonesScrollController,
      itemCount: imgList.length,
      //homeBloc.shopGemstonesList
      backgroundColor: style.shopGemstoneBgColor,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w, bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 22.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = imgList[index];
        return SmartImageTitleColumn(
          onTap: () {
            context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones});
          },
          width: width,
          title: item.name ?? '',
          titleStyle: style.shopGemstoneTitleStyle,
          imageBetweenSpacing: 8.h,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == homeBloc.jewelleryList.length - 1 ? 17.w : 0,
          ),
          titleMaxLines: 1,
          fit: BoxFit.fill,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }

  static Widget buildTopSellingEligence(
    HomeBloc homeBloc,
    HomeScreenStyle style, {
    required BuildContext context,
    required List<AuctionListModel> imgList,
    Color? bgColor,
    String? title,
    double? height,
    BoxFit? fit,
  }) {
    return Container(
      color: bgColor ?? style.topSellingEleganceColor,
      padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 32.h, bottom: 22.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SmartText(title ?? APPStrings.eligance.tr, style: style.bannerTitleStyle),
        SizedBox(height: 16.h),
        SmartGridView(
            columns: 2,
            spacing: 12.w,
            runSpacing: 12.h,
            items: imgList
                .map((AuctionListModel field) => SmartImage(
                      height: height,
                      path: field.imageUrl ?? '',
                      fit: fit ?? BoxFit.fill,
                      onTap: () {
                        homeBloc.handleRedirection(
                            context: context,
                            redirectTo: getRedirectionToFromString(field.redirectTo ?? ''),
                            redirectionType: getRedirectionTypeFromString(field.redirectionType ?? ""));
                      },
                    ))
                .toList())
      ]),
    );
  }

  static Widget buildTopSellingCategories(HomeBloc homeBloc, HomeScreenStyle style, List<AuctionListModel> dataList,
      {required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 32.h, bottom: 22.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SmartText(APPStrings.topSellingCategories.tr, style: style.bannerTitleStyle),
        SizedBox(height: 16.h),
        SmartGridView(
            columns: 2,
            spacing: 12.w,
            runSpacing: 12.h,
            items: dataList
                .map((AuctionListModel field) => SmartImage(
                      height: 132.w,
                      path: field.imageUrl ?? '',
                      fit: BoxFit.contain,
                      onTap: () {
                        homeBloc.handleRedirection(
                            context: context,
                            redirectTo: getRedirectionToFromString(field.redirectTo ?? ''),
                            redirectionType: getRedirectionTypeFromString(field.redirectionType ?? ""));
                      },
                    ))
                .toList())
      ]),
    );
  }

  static Widget buildViewAllCollectionsSection(
    HomeBloc homeBloc,
    HomeScreenStyle style, {
    required BuildContext context,
    required String url,
    required String redirectTo,
    required String redirectionType,
  }) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          SmartImage(
            path: url,
            height: 396.w,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            onTap: () {
              context.pushNamed(AppRoutes.collectionPage);
              // homeBloc.handleRedirection(
              //     context: context,
              //     redirectTo: getRedirectionToFromString(redirectTo),
              //     redirectionType: getRedirectionTypeFromString(redirectionType));
            },
          ),
          Positioned(
            bottom: 0.w,
            left: 0.w,
            right: 0.w,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutes.collectionPage);
                // homeBloc.handleRedirection(
                //     context: context,
                //     redirectTo: getRedirectionToFromString(redirectTo),
                //     redirectionType: getRedirectionTypeFromString(redirectionType));
              },
              child: Container(
                height: 60.h,
                color: style.viewAllCollectionsBgColor,
                alignment: Alignment.center,
                child: SmartText(
                  APPStrings.viewAllCollections.tr,
                  style: style.viewAllCollectionsTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildKGKCoutureTabBarSection(HomeBloc homeBloc, HomeScreenStyle style, {required BuildContext context}) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartText(
              APPStrings.kgkCouture.tr,
              style: style.bannerTitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            SmartHorizontalItemBuilder(
              itemCount: homeBloc.kgkCoutureButtonsTitle.length,
              itemBuilder: (context, index) {
                return BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      current is HomeKgkCoutureSelectionChangeState && (index == current.oldIndex || index == current.selectedIndex),
                  builder: (context, state) {
                    bool isSelected = index == homeBloc.kgkCoutureSelectedIndex;
                    return SelectionButton(
                      constraints: BoxConstraints(minWidth: 50.w),
                      margin: index == 0
                          ? EdgeInsets.only(left: 17.w)
                          : (index == homeBloc.kgkCoutureButtonsTitle.length - 1)
                              ? EdgeInsets.only(right: 17.w)
                              : null,
                      borderRadius: BorderRadius.circular(50.r),
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      isSelected: isSelected,
                      onTap: () {
                        homeBloc.add(HomeKgkCoutureSelectionChangeEvent(index: index, context: context));
                      },
                      title: homeBloc.kgkCoutureButtonsTitle[index].tr,
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16.h),
            SmartHorizontalItemBuilder(
              itemCount: homeBloc.luminousProductViewList.length > 8 ? 8 : homeBloc.luminousProductViewList.length,
              itemBuilder: (context, index) {
                return ProductGridItem(
                  margin: index == 0
                      ? EdgeInsets.only(left: 17.w)
                      : (index == (homeBloc.luminousProductViewList.length > 8 ? 8 : homeBloc.luminousProductViewList.length) - 1)
                          ? EdgeInsets.only(right: 17.w)
                          : EdgeInsets.zero,
                  productDetails: homeBloc.luminousProductViewList[index],
                  onEyeTap: () async {
                    ProductDetailsModel? productDetails = homeBloc.luminousProductViewList[index];

                    BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.add(productDetails, context));
                    await Utils.showSmartModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      useRootNavigator: true,
                      builder: (context) => const AddWatchlistScreen(),
                    );
                  },
                  onFavTap: () {
                    BlocProvider.of<AppBloc>(context).add(ProductAddToFavoriteEvent(
                      homeBloc.luminousProductViewList[index],
                      context,
                      onFavTap: () {},
                    ));
                  },
                  onTap: () {
                    context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                      RoutesData.productId: homeBloc.luminousProductViewList[index].productId ?? '',
                      RoutesData.isPageFor: ScreenIdentifier.productForRing
                    });
                  },
                );
              },
            ),
            if (homeBloc.luminousProductViewList.length > 8) ...[
              SizedBox(height: 16.h),
              SelectionButton(
                height: 40.h,
                width: 120.w,
                unselectedButtonBorderColor: style.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                isSelected: false,
                onTap: () {},
                title: APPStrings.viewAll.tr,
              ),
            ],
          ],
        ));
  }

  static Widget buildCategoryGridPageView(HomeBloc homeBloc, HomeScreenStyle style, {required BuildContext context}) {
    final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
    double imgWidth = (context.width - 46.w) / 3;
    return Column(
      children: [
        SmartText(APPStrings.shopByX.tr.interpolate([APPStrings.categories.tr]), style: style.bannerTitleStyle),
        SizedBox(height: 16.h),
        ExpandablePageView(
          onPageChanged: (index) {
            homeBloc.add(HomeCategoryPageChangeEvent(index));
          },
          controller: homeBloc.categoryPageController,
          children: List.generate(
            homeBloc.categoryPageLength,
            (index) {
              int start = index * HomeBloc.categoryPerPageLength;
              int end =
                  (index == homeBloc.categoryPageLength - 1) ? homeBloc.categoryList.length : (start + HomeBloc.categoryPerPageLength);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: SmartGridView(
                  columns: 3,
                  runSpacing: 10.h,
                  items: homeBloc.categoryList
                      .sublist(start, end)
                      .map((AuctionListModel item) => SmartImageTitleColumn(
                            imageUrl: item.imageUrl ?? '',
                            title: item.name ?? '',
                            imageWidth: imgWidth,
                            imageHeight: imgWidth,
                            fit: BoxFit.fitWidth,
                            titleMaxLines: 1,
                            imageBorder: Border.all(color: style.borderColor, width: 1.w),
                          ))
                      .toList(),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => current is HomeCategoryPageChangeState || current is HomeInitial,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                homeBloc.categoryPageLength,
                (index) {
                  bool isCurrentPage = homeBloc.currentPageIndex == index;
                  return Container(
                    width: 6.0.w,
                    height: 6.0.w,
                    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: isCurrentPage ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  static Widget buildCreateYourOwnSignaturePiece(HomeBloc homeBloc, HomeScreenStyle style,
      {required BuildContext context, required String title, required String subTitle}) {
    return Container(
      color: style.primaryColor,
      width: context.width,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const SmartImage(
            path: AppImages.icPrimaryBgLine,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmartText(title, style: style.createOwnSignatureTitleStyle),
                SizedBox(height: 8.h),
                SmartText(subTitle, style: style.createOwnSignatureSubTitleStyle),
                SizedBox(height: 24.h),
                buildOwnSignaturePieceSteps(AppImages.icHomeRing, APPStrings.stepX.tr.interpolate(["1"]), APPStrings.selectStone.tr, style),
                SizedBox(height: 24.h),
                buildOwnSignaturePieceSteps(
                    AppImages.icHomeDiamondRingThin, APPStrings.stepX.tr.interpolate(["2"]), APPStrings.selectJewellery.tr, style),
                SizedBox(height: 24.h),
                buildOwnSignaturePieceSteps(
                    AppImages.icCustomizeThin, APPStrings.stepX.tr.interpolate(["3"]), APPStrings.customiseViewPrice.tr, style),
                SizedBox(height: 24.h),
                Container(
                  color: style.whiteColor,
                  padding: EdgeInsets.all(24.w),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        current is HomeSelectStoneTypeChangeState || current is HomeSelectJewelleryTypeChangeState,
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SmartText(APPStrings.stepX.tr.interpolate(["1"]),
                                  style: style.stepTextStyle.copyWith(color: style.textStyleColor)),
                              SizedBox(width: 19.w),
                              Flexible(child: buildStep1DropDownField(homeBloc, style))
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 12.h), child: const Divider()),
                          Row(
                            children: [
                              SmartText(APPStrings.stepX.tr.interpolate(["2"]),
                                  style: style.stepTextStyle.copyWith(color: style.textStyleColor)),
                              SizedBox(width: 19.w),
                              Expanded(child: buildStep2DropDownField(homeBloc, style))
                            ],
                          ),
                          SizedBox(height: 12.h),
                          SmartButton(onTap: () {}, title: APPStrings.getStarted.tr)
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildStep1DropDownField(HomeBloc homeBloc, HomeScreenStyle style) {
    return SmartDropDown<OrderStoneTypeModel>(
      contentPadding: EdgeInsets.zero,
      buttonHeight: 40.h,
      textStyle: style.dropDownTextStyle,
      border: const Border.symmetric(vertical: BorderSide.none, horizontal: BorderSide.none),
      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
      items: homeBloc.arrStoneType.map((OrderStoneTypeModel type) {
        return SmartDropDownItem<OrderStoneTypeModel>(
          value: type,
          title: type.name,
        );
      }).toList(),
      onChanged: (type) {
        if (type != null) {
          homeBloc.add(HomeSelectStoneChangeTypeEvent(selectedStep1StoneType: type));
        }
      },
      selectedItem: homeBloc.selectedStep1StoneType,
    );
  }

  static Widget buildStep2DropDownField(HomeBloc homeBloc, HomeScreenStyle style) {
    return SmartDropDown<OrderStoneTypeModel>(
      contentPadding: EdgeInsets.zero,
      buttonHeight: 40.h,
      textStyle: style.dropDownTextStyle,
      border: const Border.symmetric(vertical: BorderSide.none, horizontal: BorderSide.none),
      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
      items: homeBloc.arrRingType.map((OrderStoneTypeModel type) {
        return SmartDropDownItem<OrderStoneTypeModel>(
          value: type,
          title: type.name,
        );
      }).toList(),
      onChanged: (type) {
        if (type != null) {
          homeBloc.add(HomeSelectJewelleryChangeTypeEvent(selectedStep2RingType: type));
        }
      },
      selectedItem: homeBloc.selectedStep2RingType,
    );
  }

  static Widget buildOwnSignaturePieceSteps(String image, String steps, String title, HomeScreenStyle style) {
    return Row(
      children: [
        SmartImage(path: image, color: style.whiteColor),
        SizedBox(width: 16.w),
        SmartText(steps, style: style.stepTextStyle),
        SizedBox(width: 8.w),
        Expanded(child: SmartText(title, style: style.stepValueStyle)),
      ],
    );
  }

  static Widget buildDealOfTheDaySection(HomeBloc homeBloc, HomeScreenStyle style, {required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 20.h),
      child: SmartSuggestionProductList(
          title: APPStrings.dealOfTheDay.tr,
          onViewAllTap: () {
            context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing});
          },
          suggestedProductList: homeBloc.dealOfTheDayList,
          onEyeTap: () {},
          onFavTap: () {},
          scrollController: homeBloc.dealOfTheDayScrollController),
    );
  }

// Widget _buildGetInspiredSection(HomeBloc homeBloc, HomeScreenStyle style) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       SmartText(APPStrings.getInspired.tr, style: style.bannerTitleStyle),
//       SizedBox(height: 16.h),
//       SmartGridView(
//           columns: 2,
//           spacing: 12.w,
//           runSpacing: 24.h,
//           items: homeBloc.getInspiredList
//               .map((AuctionListModel field) => SmartImageTitleColumn(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     topWidget: SmartImage(height: 188.w, path: field.imageUrl ?? '', fit: BoxFit.fill),
//                     title: field.name ?? '',
//                     titleStyle: style.getInspiredTitleStyle,
//                   ))
//               .toList())
//     ]),
//   );
// }

  static Widget buildGetInspiredSection(BuildContext context, HomeBloc homeBloc, HomeScreenStyle style, List<AuctionListModel> dataList) {
    return Container(
      color: style.getInspiredSectionColor,
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SmartText(APPStrings.getInspired.tr, style: style.bannerTitleStyle),
        SizedBox(height: 16.h),
        SmartGridView(
            columns: 2,
            spacing: 12.w,
            runSpacing: 12.h,
            items: dataList
                .map((AuctionListModel field) => SmartImageTitleColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      onTap: () {
                        homeBloc.handleRedirection(
                            context: context,
                            redirectTo: getRedirectionToFromString(field.redirectTo ?? ''),
                            redirectionType: getRedirectionTypeFromString(field.redirectionType ?? ""));
                      },
                      topWidget: SmartImage(
                        // height: 188.w,
                        path: field.imageUrl ?? '',
                        // fit: BoxFit.fitWidth,
                      ),
                      title: field.name ?? '',
                      titleStyle: style.getInspiredTitleStyle,
                    ))
                .toList())
      ]),
    );
  }

  static Widget buildShopByStyleSection(HomeBloc homeBloc, HomeScreenStyle style, List<AuctionListModel> dataList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SmartText(APPStrings.shopByStyle.tr, style: style.bannerTitleStyle),
        SizedBox(height: 16.h),
        SmartGridView(
            columns: 2,
            spacing: 12.w,
            runSpacing: 24.h,
            items: dataList
                .map((AuctionListModel field) => SmartImageTitleColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      topWidget: SmartImage(height: 188.w, path: field.imageUrl ?? '', fit: BoxFit.fill),
                      title: field.name ?? '',
                      titleStyle: style.getInspiredTitleStyle,
                    ))
                .toList())
      ]),
    );
  }

  static Widget buildRecentlyViewedSection(HomeBloc homeBloc, HomeScreenStyle style, {required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 20.h),
      child: SmartSuggestionProductList(
        title: APPStrings.recentlyViewed.tr,
        onViewAllTap: () {
          context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing});
        },
        suggestedProductList: homeBloc.recentlyViewList,
        onEyeTap: () {},
        onFavTap: () {},
        scrollController: homeBloc.recentlyViewedScrollController,
      ),
    );
  }
}
