import 'package:kgk/kgk.dart';

class PddListingScreen extends StatelessWidget {
  const PddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddListingBloc pddListingBloc = BlocProvider.of<PddListingBloc>(context);
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(pddListingBloc, context),
      floatingActionButton: _buildFloatingActionButton(pddListingBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<PddListingBloc, PddListingState>(
            buildWhen: (previous, current) => current is PddListingLoadedState || current is PddListingChangeListingTypeState,
            builder: (context, state) {
              if (state is PddListingLoadedState || state is PddListingChangeListingTypeState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    _buildSearchTextField(pddListingBloc, diamondListingStyle),
                    SizedBox(height: 24.h),
                    _buildPddList(pddListingBloc, state),
                    SizedBox(height: 16.h),
                  ],
                );
              }
              return const SmartCircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  SmartAppBar _buildAppBar(BuildContext context) {
    return SmartAppBar(title: APPStrings.presentations.tr);
  }

  Widget _buildSearchTextField(PddListingBloc pddListingBloc, DiamondListingStyle diamondListingStyle) {
    return Row(
      children: [
        Expanded(
          child: SmartTextField(
            hintText: APPStrings.searchPresentation.tr,
            controller: pddListingBloc.presentationSearchController,
            onValueChanges: (value) => pddListingBloc.add(const FilterPresentationEvent()),
            suffixIcon: SmartImage(
              path: AppImages.icSearchThin,
              padding: EdgeInsets.all(14.w),
            ),
            onTapOutside: (event) {},
          ),
        ),
        SizedBox(width: 16.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SelectionButton(
              width: 48.w,
              isSelected: pddListingBloc.isGrid,
              image: AppImages.icGrid,
              selectedButtonColor: diamondListingStyle.gridBackgroundColor,
              selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
              selectedButtonIconColor: diamondListingStyle.gridIconColor,
              unselectedButtonIconColor: diamondListingStyle.listIconColor,
              unselectedButtonColor: diamondListingStyle.listBackgroundColor,
              unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
              onTap: () {
                pddListingBloc.add(const PresentationChangeListingTypeEvent(isGrid: true));
              },
            ),
            SelectionButton(
              width: 48.w,
              isSelected: !pddListingBloc.isGrid,
              image: AppImages.icList,
              selectedButtonColor: diamondListingStyle.gridBackgroundColor,
              selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
              selectedButtonIconColor: diamondListingStyle.gridIconColor,
              unselectedButtonIconColor: diamondListingStyle.listIconColor,
              unselectedButtonColor: diamondListingStyle.listBackgroundColor,
              unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
              onTap: () {
                pddListingBloc.add(const PresentationChangeListingTypeEvent(isGrid: false));
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPddList(PddListingBloc bloc, PddListingState state) {
    return BlocBuilder<PddListingBloc, PddListingState>(
      buildWhen: (previous, current) =>
          current is PddListingChangeListingTypeState || current is PddListLoadingMoreState || current is PddListLoadedMoreState,
      builder: (context, state) {
        if (bloc.filteredPresentationList.isEmpty) {
          return _buildEmptyState();
        }
        return _buildListingView(bloc, state);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noPresentationFound.tr);
  }

  Widget _buildListingView(PddListingBloc bloc, PddListingState state) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await bloc.pullToRefresh();
        },
        child: ListView.builder(
          shrinkWrap: true,
          key: bloc.isGrid ? bloc.gridPaginationScrollController.gridKey : bloc.gridPaginationScrollController.listKey,
          controller: bloc.gridPaginationScrollController.controller,
          itemCount: bloc.filteredPresentationList.length,
          itemBuilder: (context, index) {
            return BlocBuilder<PddListingBloc, PddListingState>(
              buildWhen: (previous, current) => current is PddListLoadingMoreState || current is PddListLoadedMoreState,
              builder: (context, state) {
                return Column(
                  children: [
                    bloc.isGrid
                        ? PresentationGridItem(
                            margin: EdgeInsets.only(
                                bottom: state is PddListLoadingMoreState && index == bloc.filteredPresentationList.length - 1 ? 0.h : 24.h),
                            onTap: () {
                              bloc.add(NavigateToPddPreviewEvent(index: index, context: context));
                            },
                            b2bCustomListingDataModel: bloc.filteredPresentationList[index])
                        : B2BListingItem(
                            margin: EdgeInsets.only(
                                bottom: state is PddListLoadingMoreState && index == bloc.filteredPresentationList.length - 1 ? 0.h : 24.h),
                            onTapMenuButton: () {},
                            type: B2BListingType.presentationListingType,
                            listingItemModel: bloc.filteredPresentationList[index],
                            onTap: () {
                              bloc.add(NavigateToPddPreviewEvent(index: index, context: context));
                            },
                          ),
                    if (state is PddListLoadingMoreState && index == bloc.filteredPresentationList.length - 1)
                      const SmartCircularProgressIndicator(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(PddListingBloc pddListingBloc, BuildContext context) {
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

  Widget _buildFloatingActionButton(PddListingBloc pddListingBloc) {
    return BlocBuilder<PddListingBloc, PddListingState>(
      buildWhen: (previous, current) => current is PddListingChangeListingTypeState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: pddListingBloc.gridPaginationScrollController.canScrollToTop,
          onTap: pddListingBloc.gridPaginationScrollController.scrollToTop,
        );
      },
    );
  }
}
