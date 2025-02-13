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
          buildWhen: (previous, current) => current is WishlistDataFetchedState || current is WishlistLoadingState,
          builder: (context, state) {
            if (state is WishlistLoadingState) {
              return const SmartCircularProgressIndicator();
            }
            if (state is WishlistDataFetchedState) {
              if (bloc.productList.isEmpty) {
                return NoDataFoundWidget();
              }
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
            }
            return SizedBox.shrink();
          },
        ),
        bottomNavigationBar: BlocBuilder<WishlistBloc, WishlistState>(
          buildWhen: (previous, current) => current is WishlistDataFetchedState,
          builder: (context, state) {
            if (state is WishlistDataFetchedState) {
              return FilterBottomActionBar(
                controller: bloc.paginationScrollController.controller,
                onFilterTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder: (_) => AdvanceFilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {
                          bloc.add(WishlistFilterEvent(filterData: value, context: context));
                        }
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
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: SmartGridView(
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
                    _onProductTap(context, productDetails);
                  },
                );
              }).toList()),
            ),
            if (state is WishlistLoadingMoreState) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  void _onProductTap(BuildContext context, ProductDetailsModel productDetails) {
    if (productDetails.commodity == null) {
      return;
    }
    context.pushNamed(AppRoutes.productDetailsPage, arguments: {
      RoutesData.productId: productDetails.suid ?? '',
      RoutesData.isPageFor: Utils.getScreenIdentifierFromCommodity(productDetails.commodity!)
    });
  }
}
