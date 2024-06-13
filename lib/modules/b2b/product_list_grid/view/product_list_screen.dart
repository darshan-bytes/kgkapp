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
          builder: (context, state) {
            return SmartAppBar(
              title: bloc.appbarTitle,
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
              onFilter: () {},
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProductListBloc, ProductListState>(
        buildWhen: (previous, current) => current is ChangePageNumberState,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SmartPagination(
                pageNumbers: bloc.pageNumbers,
                currentPage: bloc.selectedPageNumber,
                onPageChanged: (int index, String newValue) {
                  bloc.add(ChangePageNumberEvent(newValue));
                },
              ),
              FilterBottomActionBar(
                onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => FilterScreen(
                      onApply: () {},
                    ),
                  );
                },
                onSortTap: () {
                  showModalBottomSheet(
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
      ),
      body: SingleChildScrollView(
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
      ))),
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
                        bloc.add(const ProductChangeListingTypeEvent(true));
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
                        bloc.add(const ProductChangeListingTypeEvent(false));
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
      builder: (context, state) {
        if (bloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.add));
        } else {
          if (bloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: bloc.productList.map((ProductDetails productDetails) {
                  /// If need to  product customization icon then remove onCancel voidCallback
                  return ProductGridItem(
                    productDetails: productDetails,
                    isCustomisable: bloc.screenIdentifier == ScreenIdentifier.productForRing && bloc.productList[0] == productDetails,
                    isOutOfStock: bloc.screenIdentifier == ScreenIdentifier.productForRing && bloc.productList[0] == productDetails,
                    onAddToBagTap: bloc.screenIdentifier == ScreenIdentifier.productForRing ? () {} : null,
                    onEyeTap: () {},
                    onFavTap: () {},
                    prefixImage: AppImages.icShoppingBag,
                    imageSize: 16.w,
                    isStoneWithPrice: bloc.screenIdentifier != ScreenIdentifier.productForRing,
                    onTap: () {
                      if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
                        context.pushNamed(AppRoutes.productDetailsPage,
                            arguments: {RoutesData.productId: productDetails.productId ?? '', RoutesData.isPageFor: bloc.screenIdentifier});
                      } else {
                        context.pushNamed(AppRoutes.diamondDetailPage, arguments: {RoutesData.isPageFor: bloc.screenIdentifier});
                      }
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
              itemBuilder: (context, index) => ProductListItem(
                margin: EdgeInsets.only(bottom: 17.h),
                onEyeTap: () {},
                onFavTap: () {},
                onAddToBagTap: () {},
                isCustomisable: bloc.screenIdentifier == ScreenIdentifier.productForRing && index == 0,
                onTap: () {
                  if (bloc.screenIdentifier == ScreenIdentifier.productForRing) {
                    context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                      RoutesData.productId: bloc.productList[index].productId ?? '',
                      RoutesData.isPageFor: bloc.screenIdentifier
                    });
                  } else {
                    context.pushNamed(AppRoutes.diamondDetailPage);
                  }
                },
                productDetails: bloc.productList[index],
              ),
              itemCount: bloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          }
        }
      },
    );
  }
}
