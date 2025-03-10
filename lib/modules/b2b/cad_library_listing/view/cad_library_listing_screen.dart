import 'package:kgk/kgk.dart';

class CadLibraryListingScreen extends StatelessWidget {
  const CadLibraryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CadLibraryListingBloc cadLibraryListingBloc = BlocProvider.of<CadLibraryListingBloc>(context);
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) => current is CadAppBarTitleChangedState,
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, cadLibraryListingBloc),
          bottomNavigationBar: _buildBottomNavigationBar(cadLibraryListingBloc, context),
          floatingActionButton: _buildFloatingActionButton(cadLibraryListingBloc),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
                buildWhen: (previous, current) => current is CadListingLoadedState || current is CadPullToRefreshState,
                builder: (context, state) {
                  if (state is CadListingLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 24.h),
                        _buildCadFilterCount(cadLibraryListingBloc, context),
                        _buildSearchTextField(cadLibraryListingBloc),
                        _buildCadList(cadLibraryListingBloc),
                        SizedBox(height: 16.h),
                      ],
                    );
                  } else {
                    return const SmartCircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  SmartAppBar _buildAppBar(BuildContext context, CadLibraryListingBloc bloc) {
    return SmartAppBar(
      title: bloc.appBarTitle,
      onSearch: () {
        context.pushNamed(AppRoutes.searchPage);
      },
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
    );
  }

  Widget _buildSearchTextField(CadLibraryListingBloc bloc) {
    return SmartTextField(
      hintText: APPStrings.searchCAD.tr,
      controller: bloc.cadLibrarySearchController,
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      textInputAction: TextInputAction.search,
      onTapOutside: (event) {},
    );
  }

  Widget _buildCadFilterCount(CadLibraryListingBloc bloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) => current is CadChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate([100]), style: diamondListingStyle.filterProductCountTextStyle),
              Expanded(
                child: Row(
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
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const CadChangeListingTypeEvent(isGrid: true));
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
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const CadChangeListingTypeEvent(isGrid: false));
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

  Widget _buildCadList(CadLibraryListingBloc bloc) {
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) =>
          current is CadChangeListingTypeState || current is CadListLoadedMoreState || current is CadListLoadingMoreState,
      builder: (context, state) {
        if (bloc.cadList.isEmpty) {
          return _buildEmptyState();
        }
        return _buildListOrGridView(bloc, state, context: context);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noCadLibraryFound.tr);
  }

  Widget _buildListOrGridView(CadLibraryListingBloc bloc, CadLibraryListingState state, {required BuildContext context}) {
    return Expanded(
      child: bloc.isGrid ? _buildGridView(bloc, state, context) : _buildListView(bloc, state, context),
    );
  }

  Widget _buildGridView(CadLibraryListingBloc bloc, CadLibraryListingState state, BuildContext context) {
    return SmartSingleChildScrollView(
      key: bloc.gridPaginationScrollController.gridKey,
      controller: bloc.gridPaginationScrollController.controller,
      onRefresh: () async {
        await bloc.pullToRefresh(context: context);
      },
      child: SmartGridView(
        items: bloc.cadList.map((item) => DesignListingGridItem.cadLibrary(designModel: item)).toList(),
        isLoadingMore: state is CadListLoadingMoreState,
      ),
    );
  }

  Widget _buildListView(CadLibraryListingBloc bloc, CadLibraryListingState state, BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await bloc.pullToRefresh(context: context);
      },
      child: ListView.builder(
        shrinkWrap: true,
        key: bloc.gridPaginationScrollController.listKey,
        controller: bloc.gridPaginationScrollController.controller,
        itemCount: bloc.cadList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CadLibraryListItem(
                margin: EdgeInsets.only(bottom: 24.h),
                designModel: bloc.cadList[index],
                onTap: () {},
              ),
              if (state is CadListLoadingMoreState && index == bloc.cadList.length - 1) const SmartCircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(CadLibraryListingBloc bloc, BuildContext context) {
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) => current is CadListingLoadedState || current is CadChangeListingTypeState,
      builder: (context, state) {
        if (state is CadListingLoadedState || state is CadChangeListingTypeState) {
          return FilterBottomActionBar(
            controller: bloc.gridPaginationScrollController.controller,
            onFilterTap: () async {
              await Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
            onSortTap: () async {
              await Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => SortScreen(sortData: bloc.sortOptions),
              ).then((onValue) {
                if (onValue != null) {
                  bloc.add(CadSortEvent(context: context, sortData: onValue[RoutesData.sortData]));
                }
              });
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFloatingActionButton(CadLibraryListingBloc bloc) {
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) => current is CadChangeListingTypeState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: bloc.gridPaginationScrollController.canScrollToTop,
          onTap: bloc.gridPaginationScrollController.scrollToTop,
        );
      },
    );
  }
}
