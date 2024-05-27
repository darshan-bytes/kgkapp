import 'package:kgk/kgk.dart';

class DiamondListingScreen extends StatelessWidget {
  const DiamondListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final DiamondListingBloc diamondListingBloc = BlocProvider.of<DiamondListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: diamondListingBloc.diamondListingAppbarTitle,
              onFilter: () {},
              onFavorite: () {},
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<DiamondListingBloc, DiamondListingState>(
                builder: (context, state) {
              return SmartPagination(
                pageNumbers: diamondListingBloc.pageNumbers,
                currentPage: diamondListingBloc.selectedPageNumber,
                onPageChanged: (int index, String newValue) {
                  diamondListingBloc
                      .add(DiamondProductChangePageNumberEvent(newValue));
                },
              );
            }),
            FilterBottomActionBar(onFilterTap: () {}, onSortTap: () {}),
          ],
        );
      }),
      body: SingleChildScrollView(child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 1),
                const SizedBox(height: 24),
                _buildSelectionDiamond(diamondListingBloc),
                const SizedBox(height: 24),
                _buildProductFilterCount(style, diamondListingBloc),
                const SizedBox(height: 24),
                _buildProductList(style, diamondListingBloc),
                const SizedBox(height: 7),
              ],
            ),
          ));
        },
      )),
    );
  }

  Widget _buildSelectionDiamond(DiamondListingBloc diamondListingBloc) {
    return Row(
      children: [
        Expanded(
          child: SelectionButton(
            isSelected: diamondListingBloc.isIndividual,
            title: APPStrings.naturalDiamond.tr,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(true));
            },
          ),
        ),
        Expanded(
          child: SelectionButton(
            isSelected: !diamondListingBloc.isIndividual,
            title: APPStrings.looseDiamond.tr,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(false));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, DiamondListingBloc diamondListingBloc) {
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
                  isSelected: diamondListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(true));
                  },
                ),
                SelectionButton(
                  width: 48,
                  isSelected: !diamondListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(false));
                  },
                ),
                const SizedBox(width: 16),
                SelectionButton(
                  width: 48,
                  isSelected: true,
                  selectedButtonColor: style.menuBackgroundColor,
                  selectedButtonBorderColor: style.menuBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  image: AppImages.icMenu,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductList(DiamondListingStyle style, DiamondListingBloc diamondListingBloc) {
    return BlocBuilder<DiamondListingBloc, DiamondListingState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (diamondListingBloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.add));
        } else {
          if (diamondListingBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: diamondListingBloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    isStoneWithPrice: true,
                    onEyeTap: () {},
                    onFavTap: () {},
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
                productDetails: diamondListingBloc.productList[index],
              ),
              itemCount: diamondListingBloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          }
        }
      },
    );
  }
}
