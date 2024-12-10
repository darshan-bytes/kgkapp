import 'package:kgk/kgk.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiamondListingStyle diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    final ProductListBloc bloc = BlocProvider.of<ProductListBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<ProductListBloc, ProductListState>(
          buildWhen: (previous, current) => current is ProductListLoadedState,
          builder: (context, state) {
            return SmartAppBar(
              title: bloc.appbarTitle,
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
              onSearch: () {
                context.pushNamed(AppRoutes.searchPage);
              },
            );
          },
        ),
      ),
      floatingActionButton: ScrollToTopFAB(
          canScrollToTop: bloc.paginationScrollController.canScrollToTop, onTap: bloc.paginationScrollController.scrollToTop),
      bottomNavigationBar: BlocBuilder<ProductListBloc, ProductListState>(
        buildWhen: (previous, current) => current is ProductListLoadedState,
        builder: (context, state) {
          if (state is ProductListLoadedState) {
            return FilterBottomActionBar(
              controller: bloc.paginationScrollController.controller,
              onFilterTap: () {
                BlocProvider.of<SortFilterBloc>(context).add(AddSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (_) => FilterScreen(
                    onApply: (value) {
                      if (value != null && value is List<FilterData>) {
                        bloc.add(ProductFilterEvent(context: context, filterData: value));
                      }
                    },
                  ),
                );
              },
              onSortTap: () async {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (context) => SortScreen(sortData: bloc.sortOptions),
                ).then((onValue) {
                  if (onValue != null) {
                    bloc.add(ProductSortEvent(context: context, sortData: onValue[RoutesData.sortData]));
                  }
                });
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        buildWhen: (previous, current) => current is ProductListLoadedState,
        builder: (context, state) {
          if (state is ProductListLoadedState) {
            return SmartSingleChildScrollView(
              controller: bloc.paginationScrollController.scrollController,
              onRefresh: () async {
                bloc.add(ProductListPullToRefreshEvent(context));
              },
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      _buildProductFilterCount(diamondListingStyle, bloc),
                      SizedBox(height: 24.h),
                      _buildProductList(diamondListingStyle, bloc),
                      SizedBox(height: 7.h),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, ProductListBloc bloc) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (previous, current) => current is ProductChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24", 100]), style: style.filterProductCountTextStyle),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectionButton(
                      width: 48.w,
                      isSelected: bloc.isGrid,
                      image: AppImages.icGrid,
                      selectedButtonColor: style.gridBackgroundColor,
                      selectedButtonBorderColor: style.gridBorderColor,
                      selectedButtonIconColor: style.gridIconColor,
                      unselectedButtonIconColor: style.listIconColor,
                      unselectedButtonColor: style.listBackgroundColor,
                      unselectedButtonBorderColor: style.listBorderColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const ProductChangeListingTypeEvent(isGrid: true));
                      },
                    ),
                    SelectionButton(
                      width: 48.w,
                      isSelected: !bloc.isGrid,
                      image: AppImages.icList,
                      selectedButtonColor: style.gridBackgroundColor,
                      selectedButtonBorderColor: style.gridBorderColor,
                      selectedButtonIconColor: style.gridIconColor,
                      unselectedButtonIconColor: style.listIconColor,
                      unselectedButtonColor: style.listBackgroundColor,
                      unselectedButtonBorderColor: style.listBorderColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const ProductChangeListingTypeEvent(isGrid: false));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList(DiamondListingStyle style, ProductListBloc bloc) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (previous, current) =>
          current is ProductChangeListingTypeState ||
          current is ProductListInitial ||
          current is ProductListLoadedMoreState ||
          current is ProductListLoadingMoreState ||
          current is ProductListLoadedState ||
          current is ProductAddToFavoriteState ||
          current is ProductRemoveFromFavoriteState,
      builder: (context, state) {
        return bloc.isGrid ? _buildGridView(bloc, state, context: context) : _buildListView(bloc, state);
      },
    );
  }

  Widget _buildGridView(ProductListBloc bloc, ProductListState state, {required BuildContext context}) {
    return Column(
      children: [
        SmartGridView(
          items: bloc.productList.map((productDetails) {
            return ProductGridItem(
              productDetails: productDetails,
              isCustomisable: _isCustomisable(bloc, productDetails),
              isOutOfStock: productDetails.isOutOfStock,
              onAddToBagTap: _getAddToBagTap(bloc),
              onEyeTap: () => _onEyeTap(context, bloc, productDetails),
              isFavourite: productDetails.isFavourite,
              onFavTap: () {
                /// We have implemented this feature in the ProductGridItem
                /// so that we can use the same widget for both grid and list view and here we don't need to implement it
              },
              prefixImage: AppImages.icShoppingBag,
              imageSize: 16.w,
              isStoneWithPrice: _isStoneWithPrice(bloc),
              onTap: () => _onProductTap(context, bloc, productDetails),
            );
          }).toList(),
        ),
        if (state is ProductListLoadingMoreState) const SmartCircularProgressIndicator(),
        SizedBox(height: 17.h),
      ],
    );
  }

  Widget _buildListView(ProductListBloc bloc, ProductListState state) {
    return ListView.builder(
      itemCount: bloc.productList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ProductDetailsModel productDetails = bloc.productList[index];
        return Column(
          children: [
            ProductListItem(
              boxHeight: 190.h,
              margin: EdgeInsets.only(bottom: 17.h),
              productDetails: productDetails,
              isCustomisable: _isCustomisable(bloc, productDetails, index),
              isOutOfStock: productDetails.isOutOfStock,
              onAddToBagTap: _getAddToBagTap(bloc),
              isFavourite: productDetails.isFavourite,
              onEyeTap: () => _onEyeTap(context, bloc, productDetails),
              onFavTap: () {
                /// We have implemented this feature in the ProductGridItem
                /// so that we can use the same widget for both grid and list view and here we don't need to implement it
              },
              onTap: () => _onProductTap(context, bloc, productDetails),
            ),
            if (index == 13)
              SmartImage(
                path: "https://i.ibb.co/PN51B9q/Banner.png",
                fit: BoxFit.fitWidth,
                padding: EdgeInsets.symmetric(vertical: 32.h),
              ),
            if (index == bloc.productList.length - 1 && state is ProductListLoadingMoreState) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  bool _isCustomisable(ProductListBloc bloc, ProductDetailsModel productDetails, [int index = 0]) {
    return bloc.screenIdentifier == ScreenIdentifier.productForRing &&
        (bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey ||
            bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) &&
        (index == 0 || bloc.productList[0] == productDetails);
  }

  bool _isStoneWithPrice(ProductListBloc bloc) {
    return bloc.screenIdentifier != ScreenIdentifier.productForRing &&
        bloc.screenIdentifier != ScreenIdentifier.productForLibraryGrey &&
        bloc.screenIdentifier != ScreenIdentifier.productForLibraryPlatinum;
  }

  Function()? _getAddToBagTap(ProductListBloc bloc) {
    return (bloc.screenIdentifier == ScreenIdentifier.productForRing ||
            bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey ||
            bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum)
        ? () {}
        : null;
  }

  void _onEyeTap(BuildContext context, ProductListBloc bloc, ProductDetailsModel productDetails) {
    if (productDetails.productId != null) {
      bloc.add(ProductListAddToWatchListEvent(productDetails.productId!, context));
    }
  }

  void _onProductTap(BuildContext context, ProductListBloc bloc, ProductDetailsModel productDetails) {
    if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
      context.pushNamed(AppRoutes.productDetailsPage, arguments: {
        RoutesData.productId: productDetails.productId ?? '',
        RoutesData.isPageFor: bloc.screenIdentifier,
      });
    } else if (bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey ||
        bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      // Navigation to product details page
    } else {
      context.pushNamed(AppRoutes.stoneDetailPage, arguments: {
        RoutesData.isPageFor: bloc.screenIdentifier,
      });
    }
  }
}
