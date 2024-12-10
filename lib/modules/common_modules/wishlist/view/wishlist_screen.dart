import 'package:kgk/kgk.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistBloc bloc = BlocProvider.of<WishlistBloc>(context);
    return Scaffold(
        appBar: SmartAppBar(
          title: APPStrings.myWishlist.tr,
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          buildWhen: (previous, current) => current is WishlistDataFetchedState,
          builder: (context, state) {
            if (state is WishlistDataFetchedState) {
              return SmartSingleChildScrollView(
                onRefresh: () async {
                  bloc.add(WishlistPullToRefreshEvent(context));
                },
                controller: bloc.paginationScrollController.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    _buildWishlistCount(bloc),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            } else {
              return const SmartCircularProgressIndicator();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<WishlistBloc, WishlistState>(
          buildWhen: (previous, current) => current is WishlistDataFetchedState,
          builder: (context, state) {
            if (state is WishlistDataFetchedState) {
              return FilterBottomActionBar(
                controller: bloc.paginationScrollController.controller,
                onFilterTap: () {
                  BlocProvider.of<SortFilterBloc>(context).add(AddSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder: (_) => FilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {}
                      },
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }

  Widget _buildWishlistCount(WishlistBloc bloc) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      buildWhen: (previous, current) =>
          current is WishlistDataFetchedState || current is WishlistLoadedMoreState || current is WishlistLoadingMoreState,
      builder: (context, state) {
        return Column(
          children: [
            SmartGridView(
                items: bloc.productList.map((ProductDetailsModel productDetails) {
              return ProductGridItem(
                productDetails: productDetails,
                isOutOfStock: productDetails.isOutOfStock,
                isFavourite: true,
                onAddToBagTap: () {},
                prefixImage: AppImages.icShoppingBag,
                imageSize: 16.w,
                onFavTap: () {
                  bloc.add(ProductRemoveFromWishlistEvent(productDetails));
                },
                onTap: () {
                  _onProductTap(context, bloc, productDetails);
                },
                isStoneWithPrice: true,
              );
            }).toList()),
            if (state is WishlistLoadingMoreState) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  void _onProductTap(BuildContext context, WishlistBloc bloc, ProductDetailsModel productDetails) {
    context.pushNamed(AppRoutes.productDetailsPage, arguments: {
      RoutesData.productId: productDetails.productId ?? '',
    });
  }
}
