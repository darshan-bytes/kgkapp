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
      }),
      body: SingleChildScrollView(child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 1),
                SizedBox(height: 24.h),
                _buildSelectionDiamond(diamondListingBloc),
                SizedBox(height: 24.h),
                _buildProductFilterCount(style, diamondListingBloc),
                SizedBox(height: 24.h),
                _buildProductList(style, diamondListingBloc),
                SizedBox(height: 7.h),
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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(true));
            },
          ),
        ),
        Expanded(
          child: SelectionButton(
            isSelected: !diamondListingBloc.isIndividual,
            title: APPStrings.looseDiamond.tr,
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
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
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24"]), style: style.filterProductCountTextStyle),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SelectionButton(
                  width: 48.w,
                  isSelected: diamondListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(true));
                  },
                ),
                SelectionButton(
                  width: 48.w,
                  isSelected: !diamondListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(false));
                  },
                ),
                SizedBox(width: 16.w),
                SelectionButton(
                  width: 48.w,
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
