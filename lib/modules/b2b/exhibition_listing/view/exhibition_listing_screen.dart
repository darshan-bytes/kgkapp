import 'package:kgk/kgk.dart';

class ExhibitionListingScreen extends StatelessWidget {
  const ExhibitionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExhibitionListingBloc exhibitionListingBloc = BlocProvider.of<ExhibitionListingBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(exhibitionListingBloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
          child: Column(
            children: [
              Expanded(
                child: SmartTabBar(
                  length: exhibitionListingBloc.tabs.length,
                  onTabInitialized: (tabController) {
                    // Here TabController is initialized
                    exhibitionListingBloc.tabController = tabController;
                  },
                  onTapTab: (int index) => exhibitionListingBloc.add(ChangeExhibitionTabsEvent(index: index, context: context)),
                  tabs: exhibitionListingBloc.tabs,
                  tabBarView: _buildTabBarView(exhibitionListingBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(ExhibitionListingBloc exhibitionListingBloc) {
    return [
      ExhibitionTabView(exhibitionListingBloc: exhibitionListingBloc),
      ExhibitionPlacesTabView(exhibitionListingBloc: exhibitionListingBloc),
    ];
  }

  SmartAppBar _buildAppBar(BuildContext context) {
    return SmartAppBar(
      title: APPStrings.exhibition.tr,
      onSearch: () {
        context.pushNamed(AppRoutes.searchPage);
      },
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
    );
  }

  Widget _buildBottomNavigationBar(ExhibitionListingBloc bloc, BuildContext context) {
    return BlocBuilder<ExhibitionListingBloc, ExhibitionListingState>(
      buildWhen: (previous, current) => current is ExhibitionFilterListLoadedState,
      builder: (context, state) {
        if (state is ExhibitionFilterListLoadedState && bloc.filterData.isNotNullNorEmpty && bloc.tabController.index == 0) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: bloc.paginationScrollController.controller,
              onFilterTap: () {
                BlocProvider.of<AdvanceSortFilterBloc>(
                  context,
                ).add(AddAdvanceSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder:
                      (context) => AdvanceFilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            bloc.add(ExhibitionListingFilterEvent(filterData: value, context: context));
                          }
                        },
                      ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
