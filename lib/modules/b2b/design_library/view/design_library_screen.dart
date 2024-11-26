import 'package:kgk/kgk.dart';

class DesignLibraryScreen extends StatelessWidget {
  const DesignLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DesignLibraryBloc bloc = BlocProvider.of<DesignLibraryBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.designLibrary.tr,
        onSearch: () => context.pushNamed(AppRoutes.searchPage),
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
      ),
      body: buildBody(bloc, context),
      bottomNavigationBar: _buildBottomNavigationBar(context, bloc),
      floatingActionButton: _buildScrollToTopFab(bloc),
    );
  }

  Widget buildBody(DesignLibraryBloc bloc, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.h),
        child: BlocBuilder<DesignLibraryBloc, DesignLibraryState>(
          buildWhen: (previous, current) => current is DesignLibraryLoadedState,
          builder: (context, state) {
            if (state is DesignLibraryLoadedState) {
              return Column(
                children: [
                  _buildFilterCount(bloc, context),
                  _buildSearchTextField(bloc),
                  _buildList(bloc),
                ],
              );
            } else {
              return const SmartCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildFilterCount(DesignLibraryBloc bloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<DesignLibraryBloc, DesignLibraryState>(
      buildWhen: (previous, current) => current is DesignLibraryChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24", 100]),
                  style: diamondListingStyle.filterProductCountTextStyle),
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
                        bloc.add(const DesignLibraryChangeListingTypeEvent(isGrid: true));
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
                        bloc.add(const DesignLibraryChangeListingTypeEvent(isGrid: false));
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

  Widget _buildSearchTextField(DesignLibraryBloc bloc) {
    return SmartTextField(
      hintText: APPStrings.searchDesign.tr,
      controller: bloc.designSearchController,
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      textInputAction: TextInputAction.search,
      onTapOutside: (event) {},
    );
  }

  Widget _buildList(DesignLibraryBloc bloc) {
    return BlocBuilder<DesignLibraryBloc, DesignLibraryState>(
      buildWhen: (previous, current) =>
          current is DesignLibraryChangeListingTypeState ||
          current is DesignLibraryLoadedMoreState ||
          current is DesignLibraryLoadingMoreState,
      builder: (context, state) {
        if (bloc.designLibraryList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDesignLibraryFound.tr);
        }
        return _buildListOrGridView(bloc, state, context);
      },
    );
  }

  Widget _buildListOrGridView(DesignLibraryBloc bloc, DesignLibraryState state, BuildContext context) {
    return Expanded(child: bloc.isGrid ? _buildGridView(bloc, state, context) : _buildListView(bloc, state, context));
  }

  Widget _buildGridView(DesignLibraryBloc bloc, DesignLibraryState state, BuildContext context) {
    return SmartSingleChildScrollView(
      key: bloc.paginationScrollController.gridKey,
      controller: bloc.paginationScrollController.scrollController,
      onRefresh: () async {
        await bloc.pullToRefresh(context: context);
      },
      child: SmartGridView(
        items: List.generate(
          bloc.designLibraryList.length,
          (index) => DesignListingGridItem.designGridItem(
            designModel: bloc.designLibraryList[index],
            onTap: () {
              context.pushNamed(AppRoutes.designLibraryFeedbackPage);
            },
          ),
        ),
        isLoadingMore: state is DesignLibraryLoadingMoreState,
      ),
    );
  }

  Widget _buildListView(DesignLibraryBloc bloc, DesignLibraryState state, BuildContext context) {
    return RefreshIndicator.adaptive(
      child: ListView.builder(
        key: bloc.paginationScrollController.listKey,
        shrinkWrap: true,
        controller: bloc.paginationScrollController.secondaryScrollController,
        itemCount: bloc.designLibraryList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CadLibraryListItem.designListItem(
                margin: EdgeInsets.only(bottom: 24.h),
                designModel: bloc.designLibraryList[index],
                onTap: () {
                  context.pushNamed(AppRoutes.designLibraryFeedbackPage);
                },
              ),
              if (state is DesignLibraryLoadingMoreState && index == bloc.designLibraryList.length - 1)
                const SmartCircularProgressIndicator(),
            ],
          );
        },
      ),
      onRefresh: () async {
        await bloc.pullToRefresh(context: context);
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, DesignLibraryBloc bloc) {
    return BlocBuilder<DesignLibraryBloc, DesignLibraryState>(
      buildWhen: (previous, current) => current is DesignLibraryLoadedState || current is DesignLibraryChangeListingTypeState,
      builder: (context, state) {
        if (state is DesignLibraryLoadedState || state is DesignLibraryChangeListingTypeState) {
          return FilterBottomActionBar(
            controller: bloc.paginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
            onSortTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => const SortScreen(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildScrollToTopFab(DesignLibraryBloc bloc) {
    return BlocBuilder<DesignLibraryBloc, DesignLibraryState>(
      buildWhen: (previous, current) => current is DesignLibraryLoadedState || current is DesignLibraryChangeListingTypeState,
      builder: (context, state) {
        return ScrollToTopFAB(
            canScrollToTop: bloc.paginationScrollController.canScrollToTop, onTap: bloc.paginationScrollController.scrollToTop);
      },
    );
  }
}
