import 'package:kgk/kgk.dart';

class CadLibraryListingScreen extends StatelessWidget {
  const CadLibraryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CadLibraryListingBloc cadLibraryListingBloc = BlocProvider.of<CadLibraryListingBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(cadLibraryListingBloc, context),
      floatingActionButton: _buildFloatingActionButton(cadLibraryListingBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
            buildWhen: (previous, current) => current is CadListingLoadedState,
            builder: (context, state) {
              if (state is CadListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    _buildCadFilterCount(cadLibraryListingBloc, context),
                    SizedBox(height: 24.h),
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
  }

  SmartAppBar _buildAppBar(BuildContext context) {
    return SmartAppBar(
      title: APPStrings.cadLibrary.tr,
      onSearch: () {
        context.pushNamed(AppRoutes.searchPage);
      },
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
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
        return _buildListOrGridView(bloc, state);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noCadLibraryFound.tr);
  }

  Widget _buildListOrGridView(CadLibraryListingBloc bloc, CadLibraryListingState state) {
    return Expanded(
      child: bloc.isGrid ? _buildGridView(bloc, state) : _buildListView(bloc, state),
    );
  }

  Widget _buildGridView(CadLibraryListingBloc bloc, CadLibraryListingState state) {
    return SmartSingleChildScrollView(
      controller: bloc.gridPaginationScrollController.scrollController,
      child: SmartGridView(
        items: bloc.cadList.map((item) => DesignListingGridItem.cadLibrary(designModel: item)).toList(),
        isLoadingMore: state is CadListLoadingMoreState,
      ),
    );
  }

  Widget _buildListView(CadLibraryListingBloc bloc, CadLibraryListingState state) {
    return ListView.builder(
      shrinkWrap: true,
      controller: bloc.listPaginationScrollController.scrollController,
      itemCount: bloc.cadList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CadLibraryListItem(
              margin: EdgeInsets.only(bottom: 24.h),
              b2bCustomListingDataModel: bloc.cadList[index],
              onTap: () {},
            ),
            if (state is CadListLoadingMoreState && index == bloc.cadList.length - 1) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(CadLibraryListingBloc bloc, BuildContext context) {
    return FilterBottomActionBar(
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
  }

  Widget _buildFloatingActionButton(CadLibraryListingBloc bloc) {
    return BlocBuilder<CadLibraryListingBloc, CadLibraryListingState>(
      buildWhen: (previous, current) => current is CadChangeListingTypeState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop:
              bloc.isGrid ? bloc.gridPaginationScrollController.canScrollToTop : bloc.listPaginationScrollController.canScrollToTop,
          onTap: bloc.isGrid ? bloc.gridPaginationScrollController.scrollToTop : bloc.listPaginationScrollController.scrollToTop,
        );
      },
    );
  }
}
