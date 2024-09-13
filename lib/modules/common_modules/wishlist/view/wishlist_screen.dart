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
                await bloc.pullToRefresh(context);
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
    );
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
                onAddToBagTap: () {},
                prefixImage: AppImages.icShoppingBag,
                imageSize: 16.w,
                onEyeTap: () {},
                onFavTap: () {},
                onTap: () {},
                isFavourite: true,
              );
            }).toList()),
            if (state is WishlistLoadingMoreState) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
