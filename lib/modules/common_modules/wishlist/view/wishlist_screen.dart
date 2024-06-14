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

      /// Hide Filter/Sort And Smart Pagination
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     BlocBuilder<WishlistBloc, WishlistState>(
      //       buildWhen: (previous, current) => current is ChangeWishlistPageNumberState,
      //       builder: (context, state) {
      //         return SmartPagination(
      //           pageNumbers: bloc.pageNumbers,
      //           currentPage: bloc.selectedPageNumber,
      //           onPageChanged: (int index, String newValue) {
      //             bloc.add(ChangeWishlistPageNumberEvent(newValue));
      //           },
      //         );
      //       },
      //     ),
      //     FilterBottomActionBar(
      //       onFilterTap: () {
      //         Utils.showSmartModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           useSafeArea: true,
      //           builder: (context) => FilterScreen(
      //             onApply: () {},
      //           ),
      //         );
      //       },
      //       onSortTap: () {
      //         Utils.showSmartModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           useSafeArea: true,
      //           builder: (context) => const SortScreen(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: SmartSingleChildScrollView(
        child: BlocBuilder<WishlistBloc, WishlistState>(
          buildWhen: (previous, current) => current is WishlistDataFetchedState,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h),

                  /// Hide Header Details As per JD Suggestion
                  // SmartText(
                  //   APPStrings.productX.tr.interpolate(["12"]),
                  //   style: wishlistStyle.numberOfItemsStyle,
                  // ),
                  // SizedBox(height: 14.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SmartText(
                  //       APPStrings.total.tr,
                  //       style: wishlistStyle.totalAmountStyle,
                  //     ),
                  //     SmartText(
                  //       "\$35,700.00",
                  //       style: wishlistStyle.totalAmountStyle,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 14.h),
                  _buildWishlistCount(bloc),
                  SizedBox(height: 14.h),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWishlistCount(WishlistBloc bloc) {
    return SmartGridView(
        items: bloc.productList.map((ProductDetails productDetails) {
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
    }).toList());
  }
}
