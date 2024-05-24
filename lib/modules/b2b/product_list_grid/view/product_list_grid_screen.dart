import 'package:kgk/kgk.dart';

class ProductListGridScreen extends StatelessWidget {
  const ProductListGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiamondListingStyle diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    final ProductListGridBloc bloc = BlocProvider.of<ProductListGridBloc>(context);
    bloc.context = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: APPStrings.ring.tr,
              onFavorite: () {},
              onFilter: () {},
            );
          },
        ),
      ),
      bottomNavigationBar: FilterBottomActionBar(onFilterTap: () {}, onSortTap: () {}),
      body: SingleChildScrollView(
          child: BlocBuilder<ProductListGridBloc, ProductListGridState>(
        buildWhen: (previous, current) => current is ChangePageNumberState,
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildProductFilterCount(diamondListingStyle, bloc),
                const SizedBox(height: 24),
                _buildProductList(diamondListingStyle, bloc),
                const SizedBox(height: 7),
                SmartPagination(
                  pageNumbers: bloc.pageNumbers,
                  currentPage: bloc.selectedPageNumber,
                  onPageChanged: (int index, String newValue) {
                    bloc.add(ChangePageNumberEvent(newValue));
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ));
        },
      )),
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, ProductListGridBloc bloc) {
    return BlocBuilder<ProductListGridBloc, ProductListGridState>(
      builder: (context, state) {
        return SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24"]), style: style.filterProductCountTextStyle),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectionButton(
                      width: 48,
                      isSelected: bloc.isGrid,
                      image: AppImages.icGrid,
                      selectedButtonColor: style.gridBackgroundColor,
                      selectedButtonBorderColor: style.gridBorderColor,
                      selectedButtonIconColor: style.gridIconColor,
                      unselectedButtonIconColor: style.listIconColor,
                      unselectedButtonColor: style.listBackgroundColor,
                      unselectedButtonBorderColor: style.listBorderColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                      onTap: () {
                        bloc.add(const ProductChangeListingTypeEvent(true));
                      },
                    ),
                    SelectionButton(
                      width: 48,
                      isSelected: !bloc.isGrid,
                      image: AppImages.icList,
                      selectedButtonColor: style.gridBackgroundColor,
                      selectedButtonBorderColor: style.gridBorderColor,
                      selectedButtonIconColor: style.gridIconColor,
                      unselectedButtonIconColor: style.listIconColor,
                      unselectedButtonColor: style.listBackgroundColor,
                      unselectedButtonBorderColor: style.listBorderColor,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
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

  Widget _buildProductList(DiamondListingStyle style, ProductListGridBloc bloc) {
    return BlocBuilder<ProductListGridBloc, ProductListGridState>(
      builder: (context, state) {
        if (bloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.add));
        } else {
          if (bloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: bloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    onAddToBagTap: bloc.fromRing ? () {} : null,
                    onEyeTap: () {},
                    onFavTap: () {},
                    onTap: () {
                      context.pushNamed(AppRoutes.diamondDetailPage);
                    },
                  );
                }).toList()),
                const SizedBox(
                  height: 17,
                )
              ],
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ProductListItem(
                margin: const EdgeInsets.only(bottom: 17),
                onEyeTap: () {},
                onFavTap: () {},
                onAddToBagTap: () {},
                onTap: () {
                  context.pushNamed(AppRoutes.diamondDetailPage);
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
