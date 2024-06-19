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
      bottomNavigationBar: _buildBottomNavigationBar(searchResultBloc),
      body: _buildBody(diamondListingStyle, style, searchResultBloc),
    );
  }

  Widget _buildBody(DiamondListingStyle diamondListingStyle, SearchResultScreenStyle style, SearchResultBloc searchResultBloc) {
    return SmartSingleChildScrollView(
      child: BlocBuilder<SearchResultBloc, SearchResultState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  SmartText(APPStrings.searchResult.tr, style: style.titleStyle),
                  SizedBox(height: 6.h),
                  SmartRichText(spans: [
                    SmartTextSpan(
                      text: "120 ",
                      style: style.foundItemStyle,
                    ),
                    SmartTextSpan(
                      text: APPStrings.resultFoundFor.tr,
                      style: style.subTitleStyle,
                    ),
                    SmartTextSpan(
                      text: "''${searchResultBloc.appbarTitle}''",
                      style: style.appbarTextStyle,
                    ),
                  ]),
                  SizedBox(height: 24.h),
                  _buildProductFilterCount(diamondListingStyle, searchResultBloc),
                  SizedBox(height: 24.h),
                  _buildProductList(searchResultBloc),
                ],
              ),
            ),
          );
        },
      ),
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
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductList(SearchResultBloc searchResultBloc) {
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      builder: (context, state) {
        if (searchResultBloc.productList.isEmpty) {
          return Center(child: SmartText(APPStrings.emptyProducts.tr));
        } else {
          if (searchResultBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: searchResultBloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    onEyeTap: () {},
                    onFavTap: () {},
                    onTap: () {
                      context.pushNamed(AppRoutes.settingDetailPage);
                    },
                  );
                }).toList()),
                SizedBox(
                  height: 17.h,
                )
              ],
            );
          } else {
            return ListView.builder(
              itemCount: searchResultBloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ProductListItem(
                margin: EdgeInsets.only(bottom: 17.h),
                onEyeTap: () {},
                onFavTap: () {},
                onAddToBagTap: () {},
                productDetails: searchResultBloc.productList[index],
              ),
            );
          }
        }
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
            onFilter: () {
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

  Widget _buildBottomNavigationBar(SearchResultBloc searchResultBloc) {
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartPagination(
              pageNumbers: searchResultBloc.pageNumbers,
              currentPage: searchResultBloc.selectedPageNumber,
              onPageChanged: (int index, String newValue) {
                searchResultBloc.add(SearchResultProductChangePageNumberEvent(newValue));
              },
            ),
            FilterBottomActionBar(
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterScreen(
                    onApply: () {},
                  ),
                );
              },
              onSortTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => const SortScreen(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
