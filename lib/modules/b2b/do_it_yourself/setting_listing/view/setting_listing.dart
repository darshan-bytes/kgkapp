import 'package:kgk/kgk.dart';

class SettingListingScreen extends StatelessWidget {
  const SettingListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final SettingListingBloc settingListingBloc = BlocProvider.of<SettingListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppConst.appBarHeight),
        child: BlocBuilder<SettingListingBloc, SettingListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: settingListingBloc.settingListingAppbarTitle,
              onFilter: () {},
              onFavorite: () {},
            );
          },
        ),
      ),
      bottomNavigationBar: FilterBottomActionBar(onFilterTap: () {}, onSortTap: () {}),
      body: SingleChildScrollView(
          child: BlocBuilder<SettingListingBloc, SettingListingState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 2),
                const SizedBox(height: 24),
                _buildProductFilterCount(style, settingListingBloc),
                const SizedBox(height: 24),
                _buildProductList(style, settingListingBloc),
                const SizedBox(height: 7),
                SmartPagination(
                  pageNumbers: settingListingBloc.pageNumbers,
                  currentPage: settingListingBloc.selectedPageNumber,
                  onPageChanged: (int index, String newValue) {
                    debugPrint("Checking index $index and value $newValue");
                    settingListingBloc.add(SettingProductChangePageNumberEvent(newValue));
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

  Widget _buildProductFilterCount(DiamondListingStyle style, SettingListingBloc settingListingBloc) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO: Here count manage using pagination value so currently this string remains static
          SmartText('Showing 1-24 of 100', style: style.filterProductCountTextStyle),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SelectionButton(
                  width: 48,
                  isSelected: settingListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                  onTap: () {
                    settingListingBloc.add(const SettingChangeListingTypeEvent(true));
                  },
                ),
                SelectionButton(
                  width: 48,
                  isSelected: !settingListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                  onTap: () {
                    settingListingBloc.add(const SettingChangeListingTypeEvent(false));
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
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (settingListingBloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.add));
        } else {
          if (settingListingBloc.isGrid) {
            return Column(
              children: [
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: settingListingBloc.productList.map((ProductDetails productDetails) {
                    return ProductGridItem(
                      productDetails: productDetails,
                      onEyeTap: () {},
                      onFavTap: () {},
                    );
                  }).toList(),
                ),
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
