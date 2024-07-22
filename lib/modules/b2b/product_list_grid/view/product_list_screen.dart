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
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (context) => FilterScreen(
                    onApply: () {},
                  ),
                );
              },
              onSortTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (context) => const SortScreen(),
                );
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
                await bloc.pullToRefresh();
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
            return const SmartCircularProgressIndicator();
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
                        bloc.add(const ProductChangeListingTypeEvent());
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
                        bloc.add(const ProductChangeListingTypeEvent());
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
          current is ProductListLoadedState,
      builder: (context, state) {
        if (bloc.isGrid) {
          return Column(
            children: [
              SmartGridView(
                  additionalWidgets: [
                    (
                      index: 13,
                      child: SmartImage(
                        path: "https://i.ibb.co/PN51B9q/Banner.png",
                        fit: BoxFit.fitWidth,
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                      )
                    ),
                  ],
                  items: bloc.productList.map((ProductDetails productDetails) {
                    /// If need to  product customization icon then remove onCancel voidCallback
                    bool isCustomisable = bloc.screenIdentifier == ScreenIdentifier.productForRing &&
                        bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey &&
                        bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum &&
                        bloc.productList[0] == productDetails;
                    bool isOutOfStock = bloc.screenIdentifier == ScreenIdentifier.productForRing &&
                        bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey &&
                        bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum &&
                        bloc.productList[0] == productDetails;
                    bool isStoneWithPrice = bloc.screenIdentifier != ScreenIdentifier.productForRing &&
                        bloc.screenIdentifier != ScreenIdentifier.productForLibraryGrey &&
                        bloc.screenIdentifier != ScreenIdentifier.productForLibraryPlatinum;

                    Function()? getAddToBagTap(ProductListBloc bloc) {
                      return (bloc.screenIdentifier == ScreenIdentifier.productForRing ||
                              bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey ||
                              bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum)
                          ? () {}
                          : null;
                    }

                    return ProductGridItem(
                      productDetails: productDetails,
                      isCustomisable: isCustomisable,
                      isOutOfStock: isOutOfStock,
                      onAddToBagTap: getAddToBagTap(bloc),
                      onEyeTap: () {
                        if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
                          BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.add(productDetails));
                          Utils.showSmartModalBottomSheet(
                            context: context,
                            enableDrag: false,
                            useRootNavigator: true,
                            builder: (context) => const AddWatchlistScreen(),
                          );
                        }
                      },
                      onFavTap: () {},
                      prefixImage: AppImages.icShoppingBag,
                      imageSize: 16.w,
                      isStoneWithPrice: isStoneWithPrice,
                      onTap: () {
                        if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
                          context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                            RoutesData.productId: productDetails.productId ?? '',
                            RoutesData.isPageFor: bloc.screenIdentifier
                          });
                        } else if (bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
                          // Navigation to product details page
                        } else if (bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
                          // Navigation to product details page
                        } else {
                          context.pushNamed(AppRoutes.stoneDetailPage, arguments: {RoutesData.isPageFor: bloc.screenIdentifier});
                        }
                      },
                    );
                  }).toList()),
              if (state is ProductListLoadingMoreState) const SmartCircularProgressIndicator(),
              SizedBox(
                height: 17.h,
              )
            ],
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return BlocBuilder<ProductListBloc, ProductListState>(
                buildWhen: (previous, current) =>
                    (current is ProductListLoadingMoreState && index == bloc.productList.length - 1) ||
                    current is ProductListLoadedMoreState,
                builder: (context, state) {
                  bool isCustomisable = bloc.screenIdentifier == ScreenIdentifier.productForRing &&
                      bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey &&
                      bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum &&
                      index == 0;
                  return Column(
                    children: [
                      ProductListItem(
                        margin: EdgeInsets.only(bottom: 17.h),
                        onEyeTap: () {},
                        onFavTap: () {},
                        onAddToBagTap: () {},
                        isCustomisable: isCustomisable,
                        onTap: () {
                          if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
                            context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                              RoutesData.productId: bloc.productList[index].productId ?? '',
                              RoutesData.isPageFor: bloc.screenIdentifier
                            });
                          } else if (bloc.screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
                            // Navigation to product details page
                          } else if (bloc.screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
                            // Navigation to product details page
                          } else {
                            context.pushNamed(AppRoutes.stoneDetailPage);
                          }
                        },
                        productDetails: bloc.productList[index],
                      ),
                      if (index == 13)
                        SmartImage(
                          path: "https://i.ibb.co/PN51B9q/Banner.png",
                          fit: BoxFit.fitWidth,
                          padding: EdgeInsets.symmetric(vertical: 32.h),
                        ),
                      if (index == bloc.productList.length - 1 && state is ProductListLoadingMoreState)
                        const SmartCircularProgressIndicator(),
                    ],
                  );
                },
              );
            },
            itemCount: bloc.productList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        }
      },
    );
  }
}
