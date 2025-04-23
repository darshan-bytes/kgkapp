import 'package:kgk/kgk.dart';

class ExhibitionDetailsScreen extends StatelessWidget {
  const ExhibitionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExhibitionDetailsBloc bloc = BlocProvider.of<ExhibitionDetailsBloc>(context);
    final ExhibitionDetailsItemStyle style = AppTheme.of(context).exhibitionDetailsItemStyle;

    return Scaffold(
      appBar: _buildAppBar(bloc, context),
      floatingActionButton: _buildFloatingActionButton(bloc),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      body: SafeArea(
        child: BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
          buildWhen:
              (previous, current) =>
                  current is ExhibitionDetailsLoadedState ||
                  current is ExhibitionChangeListingTypeState ||
                  current is ExhibitionChangeTabsState,
          builder: (context, state) {
            if (state is ExhibitionDetailsLoadedState || state is ExhibitionChangeTabsState || state is ExhibitionChangeListingTypeState) {
              return SmartSingleChildScrollView(
                controller: bloc.paginationScrollController.controller,
                child: Column(
                  children: <Widget>[
                    _buildImageAndText(bloc, style),
                    SizedBox(height: 24.h),
                    SmartTabBar(
                      key: bloc.tabTargetKey,
                      isExpanded: false,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                      length: bloc.tabs.length,
                      onTabInitialized: (tabController) {
                        bloc.tabController = tabController;
                      },
                      onTapTab: (int index) => bloc.add(ExhibitionChangeTabsEvent(index: index, context: context)),
                      tabs: bloc.tabs,
                      tabBarView: _buildTabBarView(bloc),
                    ),
                  ],
                ),
              );
            }
            return SmartCircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildImageAndText(ExhibitionDetailsBloc bloc, ExhibitionDetailsItemStyle style) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen:
          (previous, current) =>
              current is ExhibitionDetailsLoadedState ||
              current is ExhibitionChangeListingTypeState ||
              current is ExhibitionChangeTabsState,
      builder: (context, state) {
        if (state is ExhibitionDetailsLoadedState || state is ExhibitionChangeTabsState || state is ExhibitionChangeListingTypeState) {
          return Container(
            decoration: BoxDecoration(color: style.primaryColor),
            padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartImage(path: bloc.exhibitionDetails.fileUrl?.setMediaUrl ?? ''),
                SizedBox(height: 24.h),
                SmartText(bloc.exhibitionDetails.name ?? '', style: style.titleStyle),
                SizedBox(height: 16.h),
                SmartText(bloc.exhibitionDetails.description ?? '', style: style.subTitleStyle),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    SmartImage(path: AppImages.icCalendar, height: 16.h, width: 16.w),
                    SizedBox(width: 8.w),
                    SmartText(bloc.exhibitionDetails.fullDate, style: style.listTextStyle),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SmartImage(path: AppImages.icClock, height: 16.h, width: 16.w),
                    SizedBox(width: 8.w),
                    SmartText(bloc.exhibitionDetails.fullTime, style: style.listTextStyle),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SmartImage(path: AppImages.icMapPin, height: 16.h, width: 16.w, color: style.iconColor),
                    SizedBox(width: 8.w),
                    SmartText(bloc.exhibitionDetails.venue, style: style.listTextStyle),
                  ],
                ),
              ],
            ),
          );
        }
        return const SmartCircularProgressIndicator();
      },
    );
  }

  /// Here we are building the tab bar view with specific tabs
  List<Widget> _buildTabBarView(ExhibitionDetailsBloc bloc) {
    return [ExhibitionDetailsProductsTabViewList(bloc: bloc), ExhibitionDetailsOrdersScreen(bloc: bloc)];
  }

  /// Here we are building the appbar view
  PreferredSizeWidget _buildAppBar(ExhibitionDetailsBloc bloc, BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
        buildWhen: (previous, current) => current is ExhibitionDetailsLoadedState,
        builder: (context, state) {
          return SmartAppBar(
            title: bloc.appbarTitle,
            onSearch: () => context.pushNamed(AppRoutes.searchPage),
            onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
          );
        },
      ),
    );
  }

  /// Here we are building the bottom navigation bar
  Widget _buildBottomNavigationBar(ExhibitionDetailsBloc bloc, BuildContext context) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) => current is ExhibitionDetailsLoadedState || current is ExhibitionChangeTabsState,
      builder: (context, state) {
        if (bloc.currentTab != 1) return const SizedBox.shrink();
        if (state is ExhibitionDetailsLoadedState || state is ExhibitionChangeTabsState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: bloc.paginationScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder:
                      (context) => AdvanceFilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            bloc.add(ExhibitionOrdersListFilterEvent(filterData: value, context: context));
                          }
                        },
                      ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Here we are building the floating action button
  Widget _buildFloatingActionButton(ExhibitionDetailsBloc bloc) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen:
          (previous, current) =>
              current is ExhibitionChangeListingTypeState ||
              current is ExhibitionChangeTabsState ||
              current is ExhibitionDetailsLoadedState,
      builder: (context, state) {
        return ScrollToTopFAB(
          canScrollToTop: bloc.paginationScrollController.canScrollToTop,
          onTap: bloc.paginationScrollController.scrollToTop,
        );
      },
    );
  }
}
