import 'package:kgk/kgk.dart';

class SettingListingScreen extends StatelessWidget {
  const SettingListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final SettingListingBloc settingListingBloc = BlocProvider.of<SettingListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.appBarHeight,
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
      bottomNavigationBar: BlocBuilder<SettingListingBloc, SettingListingState>(
        builder: (context, state) {
          if (state is SettingLoadedState) {
            return FilterBottomActionBar(
              controller: settingListingBloc.paginationScrollController.controller,
              onFilterTap: () {
                BlocProvider.of<SortFilterBloc>(
                  context,
                ).add(AddSortFilterDataEvent(filterOptionList: settingListingBloc.filterData, context: context));
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder:
                      (_) => FilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            settingListingBloc.add(SettingLibraryFilterEvent(context: context, filterData: value));
                          }
                        },
                      ),
                );
              },

              /// Below code is commented because sort functionality is not required in DIY
              /// Ref: https://thekgk.atlassian.net/browse/TA-775
              // onSortTap: () async {
              //   /// Fetch this from local and pass here as sortData based on commodity type
              //   Utils.showSmartModalBottomSheet(context: context, builder: (context) => SortScreen(sortData: []));
              // },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<SettingListingBloc, SettingListingState>(
        buildWhen: (_, current) => current is SettingLoadedState,
        builder: (context, state) {
          if (state is SettingLoadedState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    DiyProgressWidget(
                      padding: EdgeInsetsDirectional.zero,
                      selectedStep: settingListingBloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY ? 1 : 2,
                      screenIdentifier: settingListingBloc.screenIdentifier,
                    ),
                    SizedBox(height: 24.h),
                    _buildProductFilterCount(style, settingListingBloc),
                    SizedBox(height: 24.h),
                    _buildProductList(style, settingListingBloc),
                    SizedBox(height: 7.h),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, SettingListingBloc settingListingBloc) {
    return BlocBuilder<SettingListingBloc, SettingListingState>(
      buildWhen: (_, current) => current is SettingChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(
                APPStrings.showingListLengthX.tr.interpolate([settingListingBloc.totalFilteredRecords]),
                style: style.filterProductCountTextStyle,
              ),
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
                      borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                      onTap: () {
                        settingListingBloc.add(const SettingChangeListingTypeEvent());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList(DiamondListingStyle style, SettingListingBloc settingListingBloc) {
    return Expanded(
      child: BlocBuilder<SettingListingBloc, SettingListingState>(
        buildWhen: (_, current) => current is SettingLoadingMoreState || current is SettingProductLoadedMoreState,
        builder: (context, state) {
          return SmartSingleChildScrollView(
            controller: settingListingBloc.paginationScrollController.scrollController,
            onRefresh: () async {
              settingListingBloc.add(SettingListPullToRefreshEvent(context: context));
            },

            child: Column(
              children: [
                BlocBuilder<SettingListingBloc, SettingListingState>(
                  buildWhen:
                      (_, current) =>
                          current is SettingLoadedState ||
                          current is SettingProductLoadedMoreState ||
                          current is SettingChangeListingTypeState ||
                          current is SettingLoadingState,
                  builder: (context, state) {
                    if (state is SettingLoadingState) {
                      return const SizedBox.shrink();
                    } else if (settingListingBloc.productList.isEmpty) {
                      return NoDataFoundWidget(text: APPStrings.emptyProducts.tr);
                    } else {
                      if (settingListingBloc.isGrid) {
                        return Column(
                          children: [
                            SmartGridView(
                              items: List.generate(settingListingBloc.productList.length, (index) {
                                ProductDetailsModel productDetails = settingListingBloc.productList[index];
                                return ProductGridItem(
                                  productDetails: productDetails,
                                  onTap: () {
                                    context.pushNamed(
                                      AppRoutes.settingDetailPage,
                                      arguments: {
                                        RoutesData.settingId: productDetails.suid,
                                        RoutesData.isPageFor: settingListingBloc.screenIdentifier,
                                        RoutesData.type: settingListingBloc.diyType,
                                      },
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder:
                              (context, index) => ProductListItem(
                                onTap: () {
                                  context.pushNamed(
                                    AppRoutes.settingDetailPage,
                                    arguments: {
                                      RoutesData.settingId: settingListingBloc.productList[index].suid,
                                      RoutesData.isPageFor: settingListingBloc.screenIdentifier,
                                      RoutesData.type: settingListingBloc.diyType,
                                    },
                                  );
                                },
                                productDetails: settingListingBloc.productList[index],
                              ),
                          itemCount: settingListingBloc.productList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(height: 17.h),
                        );
                      }
                    }
                  },
                ),
                if (state is SettingLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 120.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
