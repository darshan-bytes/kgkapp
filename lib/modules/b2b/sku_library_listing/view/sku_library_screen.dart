import 'package:kgk/kgk.dart';

class SkuLibraryScreen extends StatelessWidget {
  const SkuLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SkuLibraryBloc bloc = BlocProvider.of<SkuLibraryBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.skuLibrary.tr,
        onSearch: () => context.pushNamed(AppRoutes.searchPage),
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
      ),
      body: buildBody(bloc, context),
      bottomNavigationBar: _buildBottomNavigationBar(context, bloc),
      floatingActionButton: _buildScrollToTopFab(bloc),
    );
  }

  Widget buildBody(SkuLibraryBloc bloc, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w, vertical: 24.h),
        child: BlocBuilder<SkuLibraryBloc, SkuLibraryState>(
          buildWhen: (previous, current) => current is SkuLibraryLoadedState || current is SkuLibraryLoadingState,
          builder: (context, state) {
            if (state is SkuLibraryLoadingState) {
              return const SmartCircularProgressIndicator();
            }
            if (state is SkuLibraryLoadedState) {
              return Column(children: [_buildFilterCount(bloc, context), SizedBox(height: 16.h), _buildList(bloc)]);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildFilterCount(SkuLibraryBloc bloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<SkuLibraryBloc, SkuLibraryState>(
      buildWhen: (previous, current) => current is SkuLibraryChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(
                APPStrings.showingListLengthX.tr.interpolate([bloc.totalFilteredRecords]),
                style: diamondListingStyle.filterProductCountTextStyle,
              ),
              _buildListStyleSwitch(bloc, diamondListingStyle),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListStyleSwitch(SkuLibraryBloc bloc, DiamondListingStyle diamondListingStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SelectionButton(
          width: 48.w,
          isSelected: bloc.isGrid,
          image: AppImages.icGrid,
          selectedButtonColor: diamondListingStyle.gridBackgroundColor,
          selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
          selectedButtonIconColor: diamondListingStyle.gridIconColor,
          unselectedButtonIconColor: diamondListingStyle.listIconColor,
          unselectedButtonColor: diamondListingStyle.listBackgroundColor,
          unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
          borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(4.r), bottomStart: Radius.circular(4.r)),
          onTap: () {
            bloc.add(const SkuLibraryChangeListingTypeEvent(isGrid: true));
          },
        ),
        SelectionButton(
          width: 48.w,
          isSelected: !bloc.isGrid,
          image: AppImages.icList,
          selectedButtonColor: diamondListingStyle.gridBackgroundColor,
          selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
          selectedButtonIconColor: diamondListingStyle.gridIconColor,
          unselectedButtonIconColor: diamondListingStyle.listIconColor,
          unselectedButtonColor: diamondListingStyle.listBackgroundColor,
          unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
          borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
          onTap: () {
            bloc.add(const SkuLibraryChangeListingTypeEvent(isGrid: false));
          },
        ),
      ],
    );
  }

  Widget _buildList(SkuLibraryBloc bloc) {
    return BlocBuilder<SkuLibraryBloc, SkuLibraryState>(
      buildWhen:
          (previous, current) =>
              current is SkuLibraryChangeListingTypeState || current is SkuLibraryLoadedMoreState || current is SkuLibraryLoadingMoreState,
      builder: (context, state) {
        if (bloc.skuLibraryList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noSkuLibraryFound.tr);
        }
        return _buildListOrGridView(bloc, state, context);
      },
    );
  }

  Widget _buildListOrGridView(SkuLibraryBloc bloc, SkuLibraryState state, BuildContext context) {
    return Expanded(child: bloc.isGrid ? _buildGridView(bloc, state, context) : _buildListView(bloc, state, context));
  }

  Widget _buildGridView(SkuLibraryBloc bloc, SkuLibraryState state, BuildContext context) {
    return SmartSingleChildScrollView(
      key: bloc.paginationScrollController.gridKey,
      controller: bloc.paginationScrollController.scrollController,
      onRefresh: () async {
        bloc.add(SkuLibraryPullToRefreshEvent(context: context));
      },
      child: SmartGridView(
        items: List.generate(
          bloc.skuLibraryList.length,
          (index) => DesignListingGridItem.designGridItem(
            designModel: bloc.skuLibraryList[index],
            onTap: () {
              context.pushNamed(
                AppRoutes.productDetailsPage,
                arguments: {
                  RoutesData.isPageFor: ScreenIdentifier.productForLibrarySKU,
                  RoutesData.productId: bloc.skuLibraryList[index].id,
                },
              );
            },
            onAddToBagTap: () {},
          ),
        ),
        isLoadingMore: state is SkuLibraryLoadingMoreState,
      ),
    );
  }

  Widget _buildListView(SkuLibraryBloc bloc, SkuLibraryState state, BuildContext context) {
    return RefreshIndicator.adaptive(
      child: ListView.builder(
        key: bloc.paginationScrollController.listKey,
        shrinkWrap: true,
        controller: bloc.paginationScrollController.controller,
        itemCount: bloc.skuLibraryList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CadLibraryListItem.designListItem(
                margin: EdgeInsetsDirectional.only(bottom: 24.h),
                designModel: bloc.skuLibraryList[index],
                onTap: () {
                  context.pushNamed(
                    AppRoutes.productDetailsPage,
                    arguments: {
                      RoutesData.isPageFor: ScreenIdentifier.productForLibrarySKU,
                      RoutesData.productId: bloc.skuLibraryList[index].id,
                    },
                  );
                },
                onAddToBagTap: () {},
              ),
              if (state is SkuLibraryLoadingMoreState && index == bloc.skuLibraryList.length - 1) const SmartCircularProgressIndicator(),
            ],
          );
        },
      ),
      onRefresh: () async {
        bloc.add(SkuLibraryPullToRefreshEvent(context: context));
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, SkuLibraryBloc bloc) {
    return BlocBuilder<SkuLibraryBloc, SkuLibraryState>(
      buildWhen: (previous, current) => current is SkuLibraryLoadedState || current is SkuLibraryChangeListingTypeState,
      builder: (context, state) {
        if (state is SkuLibraryLoadedState || state is SkuLibraryChangeListingTypeState) {
          return FilterBottomActionBar(
            controller: bloc.paginationScrollController.controller,
            onFilterTap: () {
              BlocProvider.of<SortFilterBloc>(context).add(AddSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
              Utils.showSmartModalBottomSheet(
                context: context,
                builder:
                    (context) => FilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {
                          bloc.add(SkuLibraryFilterEvent(context: context, filterData: value));
                        }
                      },
                    ),
              );
            },
            onSortTap: () async {
              bloc.onTapSortOption(context);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildScrollToTopFab(SkuLibraryBloc bloc) {
    return BlocBuilder<SkuLibraryBloc, SkuLibraryState>(
      buildWhen: (previous, current) => current is SkuLibraryLoadedState || current is SkuLibraryChangeListingTypeState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: bloc.paginationScrollController.canScrollToTop,
          onTap: bloc.paginationScrollController.scrollToTop,
        );
      },
    );
  }
}
