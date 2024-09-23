import 'package:kgk/kgk.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiamondListingStyle diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    final style = AppTheme.of(context).searchResultScreenStyle;
    final SearchResultBloc searchResultBloc = BlocProvider.of<SearchResultBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(searchResultBloc),
      body: _buildBody(diamondListingStyle, style, searchResultBloc, context),
    );
  }

  Widget _buildBody(
      DiamondListingStyle diamondListingStyle, SearchResultScreenStyle style, SearchResultBloc searchResultBloc, BuildContext context) {
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      buildWhen: (_, current) => current is SearchResultLoadedState,
      builder: (context, state) {
        if (state is SearchResultLoadedState) {
          return SafeArea(
            child: SmartSingleChildScrollView(
              onRefresh: searchResultBloc.productList.isNotEmpty
                  ? () async {
                      await searchResultBloc.pullToRefresh();
                    }
                  : null,
              physics: const ClampingScrollPhysics(),
              controller: searchResultBloc.paginationScrollController.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 24.h),
                        SmartText(APPStrings.searchResult.tr, style: style.titleStyle),
                        SizedBox(height: 6.h),
                        SmartRichText(
                          spans: [
                            SmartTextSpan(text: searchResultBloc.productList.length.toString(), style: style.foundItemStyle),
                            SmartTextSpan(text: " ", style: style.foundItemStyle),
                            SmartTextSpan(text: APPStrings.resultFoundFor.tr, style: style.subTitleStyle),
                            SmartTextSpan(text: "\" ${searchResultBloc.appbarTitle} \"", style: style.appbarTextStyle),
                          ],
                        ),
                        if (searchResultBloc.productList.isNotNullNorEmpty) ...[
                          SizedBox(height: 24.h),
                          _buildProductFilterCount(diamondListingStyle, searchResultBloc),
                          SizedBox(height: 24.h),
                          _buildProductList(searchResultBloc),
                        ] else ...[
                          SizedBox(height: 12.h),
                          SmartText(APPStrings.searchResultNotFoundDesc.tr, style: style.subTitleStyle),
                          SizedBox(height: 24.h),
                          _buildNeedHelpSection(style),
                          SizedBox(height: 30.h),
                          _buildShopDiamondsByShapeList(searchResultBloc, style, context),
                          SizedBox(height: 30.h),
                        ],
                      ],
                    ),
                  ),
                  if (searchResultBloc.productList.isEmpty) ...[
                    _buildNewlyLaunchedItems(searchResultBloc, style, context),
                    _buildExploreDigitalCatalogue(style, context),
                  ]
                ],
              ),
            ),
          );
        } else {
          return const SmartCircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle diamondListingStyle, SearchResultBloc searchResultBloc) {
    return SizedBox(
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24", 100]), style: diamondListingStyle.filterProductCountTextStyle),
          Expanded(
            child: BlocBuilder<SearchResultBloc, SearchResultState>(
              buildWhen: (_, current) => current is SearchResultChangeListingTypeState,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectionButton(
                      width: 48.w,
                      isSelected: searchResultBloc.isGrid,
                      image: AppImages.icGrid,
                      selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                      selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                      selectedButtonIconColor: diamondListingStyle.gridIconColor,
                      unselectedButtonIconColor: diamondListingStyle.listIconColor,
                      unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                      unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      onTap: () {
                        searchResultBloc.add(const SearchResultChangeListingTypeEvent());
                      },
                    ),
                    SelectionButton(
                      width: 48.w,
                      isSelected: !searchResultBloc.isGrid,
                      image: AppImages.icList,
                      selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                      selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                      selectedButtonIconColor: diamondListingStyle.gridIconColor,
                      unselectedButtonIconColor: diamondListingStyle.listIconColor,
                      unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                      unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                      onTap: () {
                        searchResultBloc.add(const SearchResultChangeListingTypeEvent());
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductList(SearchResultBloc searchResultBloc) {
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      buildWhen: (_, current) => current is SearchResultLoadedMoreState || current is SearchResultLoadingMoreState,
      builder: (context, state) {
        return Column(
          children: [
            BlocBuilder<SearchResultBloc, SearchResultState>(
              buildWhen: (_, current) =>
                  current is SearchResultChangeListingTypeState ||
                  current is SearchResultLoadedState ||
                  current is SearchResultLoadedMoreState,
              builder: (context, state) {
                if (searchResultBloc.isGrid) {
                  return SmartGridView(
                      items: searchResultBloc.productList.map((ProductDetailsModel productDetails) {
                    return ProductGridItem(
                      productDetails: productDetails,
                      onEyeTap: () {},
                      onFavTap: () {},
                      onTap: () {},
                      onAddToBagTap: () {},
                      prefixImage: AppImages.icShoppingBag,
                      imageSize: 16.w,
                    );
                  }).toList());
                } else {
                  return ListView.separated(
                    itemCount: searchResultBloc.productList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProductListItem(
                      onEyeTap: () {},
                      onFavTap: () {},
                      onAddToBagTap: () {},
                      productDetails: searchResultBloc.productList[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 17.h),
                  );
                }
              },
            ),
            if (state is SearchResultLoadingMoreState) const SmartCircularProgressIndicator(),
            SizedBox(height: 17.h)
          ],
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(SearchResultBloc searchResultBloc) {
    return PreferredSize(
      preferredSize: AppConst.appBarHeight,
      child: BlocBuilder<SearchResultBloc, SearchResultState>(
        builder: (context, state) {
          return SmartAppBar(
            title: searchResultBloc.appbarTitle,
            onSearch: () {
              context.pushNamed(AppRoutes.searchPage);
            },
            onFavorite: () {
              context.pushNamed(AppRoutes.wishListPage);
            },
          );
        },
      ),
    );
  }

  Widget _buildNeedHelpSection(SearchResultScreenStyle style) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: style.needHelpColor, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SmartText(APPStrings.needHelp.tr, style: style.needHelpStyle),
          SizedBox(height: 4.h),
          SmartText(APPStrings.reachOutToOurCustomerService.tr, style: style.needHelpTitleStyle),
          SizedBox(height: 2.h),
          SmartText("+91 98765 43210", style: style.phoneNumberStyle),
        ],
      ),
    );
  }

  Widget _buildShopDiamondsByShapeList(SearchResultBloc bloc, SearchResultScreenStyle style, BuildContext context) {
    return SmartHorizontalItemBuilder(
      itemCount: bloc.shopDiamondsByShapeList.length,
      title: APPStrings.shopDiamondsByShape.tr,
      crossAxisAlignment: CrossAxisAlignment.center,
      titleStyle: style.shopDiamondsByShapeTitleStyle,
      titleOptionalPadding: EdgeInsets.symmetric(vertical: 16.h),
      listPadding: EdgeInsets.only(bottom: 16.h),
      itemBetweenSpace: 17.w,
      itemBuilder: (context, index) {
        AuctionListModel item = bloc.shopDiamondsByShapeList[index];
        return SmartImageTitleColumn(
          width: 72.w,
          title: item.name ?? '',
          imageBetweenSpacing: 8.h,
          imagePadding: EdgeInsets.all(12.w),
          titleMaxLines: 1,
          fit: BoxFit.contain,
          imageUrl: item.imageUrl ?? '',
          onTap: () {
            context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault});
          },
        );
      },
    );
  }

  Widget _buildNewlyLaunchedItems(SearchResultBloc bloc, SearchResultScreenStyle style, BuildContext context) {
    return Container(
      color: style.newlyLaunchedBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 40.h,
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmartText(APPStrings.newlyLaunched.tr, style: style.titleStyle),
          SizedBox(height: 8.h),
          SmartText(APPStrings.exploreNewlyLaunchedProducts.tr, style: style.needHelpTitleStyle),
          SizedBox(height: 24.h),
          SmartGridView(
            items: List.generate(
              bloc.newlyLaunchedItems.length > 4
                  ? 4
                  : (bloc.newlyLaunchedItems.length % 2 == 0 ? bloc.newlyLaunchedItems.length : bloc.newlyLaunchedItems.length - 1),
              (index) => ProductGridItem(
                productDetails: bloc.newlyLaunchedItems[index],
                onEyeTap: () {},
                onFavTap: () {},
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SmartButton(
            width: 142.w,
            onTap: () {
              context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing});
            },
            title: APPStrings.exploreNow.tr,
          )
        ],
      ),
    );
  }

  Widget _buildExploreDigitalCatalogue(SearchResultScreenStyle style, BuildContext context) {
    return Container(
      color: style.exploreDigitalCatalogBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
      child: Column(
        children: [
          SmartText(APPStrings.exploreOurDigitalJewelleryCatalog.tr, style: style.titleStyle, textAlign: TextAlign.center),
          SizedBox(height: 16.h),
          SmartText(APPStrings.browseOurDigitalJewelryCatalog.tr, style: style.needHelpTitleStyle, textAlign: TextAlign.center),
          SizedBox(height: 32.h),
          SmartButton(
            width: 142.w,
            onTap: () {
              context.pushNamed(AppRoutes.digitalCataloguePage);
            },
            title: APPStrings.viewNow.tr,
            suffixImage: AppImages.icRight,
            activeImageColor: style.whiteColor,
          ),
          SizedBox(height: 30.h),
          SmartImage(
            path: 'https://i.ibb.co/nQVVDJM/image-255.png',
            height: 242.h,
            width: 342.w,
          ),
        ],
      ),
    );
  }
}
