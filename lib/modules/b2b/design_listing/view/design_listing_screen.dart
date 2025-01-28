import 'package:kgk/kgk.dart';

class DesignListingScreen extends StatelessWidget {
  const DesignListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DesignListingBloc bloc = BlocProvider.of<DesignListingBloc>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: _buildFloatingActionButton(bloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<DesignListingBloc, DesignListingState>(
            buildWhen: (previous, current) => current is DesignListingLoadedState,
            builder: (context, state) {
              if (state is DesignListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchTextFieldWithSelectionButton(bloc, context),
                    _buildDesignList(bloc, context),
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
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: SmartAppBar(
        title: APPStrings.designs.tr,
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
      ),
    );
  }

  Widget _buildSearchTextFieldWithSelectionButton(DesignListingBloc bloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) => current is DesignChangeListingTypeState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SmartTextField(
                hintText: APPStrings.searchDesign.tr,
                controller: bloc.designSearchController,
                suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
                padding: EdgeInsets.symmetric(vertical: 24.w),
                onTapOutside: (val) {},
                textInputAction: TextInputAction.search,
              ),
            ),
            SizedBox(width: 16.w),
            Row(
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
                    bloc.add(const DesignChangeListingTypeEvent(isGrid: true));
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
                    bloc.add(const DesignChangeListingTypeEvent(isGrid: false));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesignList(DesignListingBloc bloc, BuildContext context) {
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) =>
          current is DesignChangeListingTypeState || current is DesignListLoadedMoreState || current is DesignListLoadingMoreState,
      builder: (context, state) {
        if (bloc.designList.isEmpty || bloc.designListForGrid.isEmpty) {
          return _buildEmptyState();
        }
        return _buildListOrGridView(bloc, state, context);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noDesignsFound.tr);
  }

  Widget _buildListOrGridView(DesignListingBloc bloc, DesignListingState state, BuildContext context) {
    return Expanded(
      child: bloc.isGrid ? _buildGridView(bloc, state, context) : _buildListView(bloc, state),
    );
  }

  Widget _buildGridView(DesignListingBloc bloc, DesignListingState state, BuildContext context) {
    return SmartSingleChildScrollView(
      key: bloc.paginationScrollController.gridKey,
      controller: bloc.paginationScrollController.controller,
      onRefresh: () async {
        await bloc.pullToRefresh();
      },
      child: SmartGridView(
        isLoadingMore: state is DesignListLoadingMoreState,
        items: List.generate(
            bloc.designListForGrid.length,
            (index) => DesignListingGridItem.designGridItem(
                designModel: bloc.designListForGrid[index],
                onTap: () {
                  context.pushNamed(AppRoutes.designLibraryFeedbackPage);
                })),
      ),
    );
  }

  Widget _buildListView(DesignListingBloc bloc, DesignListingState state) {
    return RefreshIndicator.adaptive(
      child: ListView.builder(
        shrinkWrap: true,
        key: bloc.paginationScrollController.listKey,
        controller: bloc.paginationScrollController.scrollController,
        itemCount: bloc.designList.length,
        itemBuilder: (context, index) {
          StyleDesignModel designItem = bloc.designList[index];
          return Column(
            children: [
              SmartStyleDesignListing(listingItemModel: designItem),
              if (index == bloc.designList.length - 1 && state is DesignListLoadingMoreState) const SmartCircularProgressIndicator(),
            ],
          );
        },
      ),
      onRefresh: () async {
        await bloc.pullToRefresh();
      },
    );
  }

  Widget _buildBottomNavigationBar(DesignListingBloc bloc, BuildContext context) {
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) => current is DesignListingLoadedState || current is DesignChangeListingTypeState,
      builder: (context, state) {
        if (state is DesignListingLoadedState || state is DesignChangeListingTypeState) {
          return SafeArea(
              child: FilterBottomActionBar(
            controller: bloc.paginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
          ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFloatingActionButton(DesignListingBloc bloc) {
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) => current is DesignChangeListingTypeState || current is DesignListingLoadedState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: bloc.paginationScrollController.canScrollToTop,
          onTap: bloc.paginationScrollController.scrollToTop,
        );
      },
    );
  }
}
