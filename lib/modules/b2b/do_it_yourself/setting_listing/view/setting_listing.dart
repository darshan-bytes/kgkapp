import 'package:kgk/kgk.dart';

class SettingListingScreen extends StatelessWidget {
  const SettingListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final SettingListingBloc settingListingBloc = BlocProvider.of<SettingListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<SettingListingBloc, SettingListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: settingListingBloc.settingListingAppbarTitle,
              onSearch: () {
                context.pushNamed(AppRoutes.searchPage);
              },
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<SettingListingBloc, SettingListingState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilterBottomActionBar(
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterScreen(
                    onApply: () {},
                  ),
                );
              },
              onSortTap: () {
                Utils.showSmartModalBottomSheet(
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
      body: SmartSingleChildScrollView(child: BlocBuilder<SettingListingBloc, SettingListingState>(
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 2),
                SizedBox(height: 24.h),
                _buildProductFilterCount(style, settingListingBloc),
                SizedBox(height: 24.h),
                _buildProductList(style, settingListingBloc),
                SizedBox(height: 7.h),
              ],
            ),
          ));
        },
      )),
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, SettingListingBloc settingListingBloc) {
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
                  isSelected: settingListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                  onTap: () {
                    settingListingBloc.add(const SettingChangeListingTypeEvent());
                  },
                ),
                SelectionButton(
                  width: 48.w,
                  isSelected: !settingListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                  onTap: () {
                    settingListingBloc.add(const SettingChangeListingTypeEvent());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductList(DiamondListingStyle style, SettingListingBloc settingListingBloc) {
    return BlocBuilder<SettingListingBloc, SettingListingState>(
      builder: (context, state) {
        if (state is StoneLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (settingListingBloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.emptyProducts));
        } else {
          if (settingListingBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: settingListingBloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    onEyeTap: () {},
                    onFavTap: () {},
                    onTap: () {
                      context.pushNamed(AppRoutes.settingDetailPage);
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
                productDetails: settingListingBloc.productList[index],
              ),
              itemCount: settingListingBloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          }
        }
      },
    );
  }
}
