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
      bottomNavigationBar: BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
        buildWhen: (previous, current) => current is ChangeExhibitionTabsState,
        builder: (context, state) {
          return bloc.currentIndex == 0 ? _buildBottomNavigationBar(bloc, context) : const SizedBox();
        },
      ),
      body: SafeArea(
        child: BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
          buildWhen: (previous, current) =>
              current is ExhibitionDetailsLoadedState ||
              current is ExhibitionChangeListingTypeState ||
              current is ChangeExhibitionTabsState,
          builder: (context, state) {
            if (state is ExhibitionDetailsLoadedState || state is ChangeExhibitionTabsState || state is ExhibitionChangeListingTypeState) {
              return SmartSingleChildScrollView(
                controller: bloc.scrollController,
                child: Column(
                  children: [
                    _buildImageAndText(bloc, style),
                    SizedBox(
                      height: 24.h,
                    ),
                    SmartTabBar(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      isExpanded: false,
                      length: bloc.tabs.length,
                      onTabInitialized: (tabController) {
                        bloc.tabController = tabController;
                      },
                      onTapTab: (int index) => bloc.add(const ChangeExhibitionTabsEvent()),
                      tabs: bloc.tabs,
                      tabBarView: _buildTabBarView(bloc),
                    ),
                  ],
                ),
              );
            } else {
              return const SmartCircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  SmartAppBar _buildAppBar(ExhibitionDetailsBloc bloc, BuildContext context) {
    return SmartAppBar(
      title: bloc.appbarTitle,
      onSearch: () {
        context.pushNamed(AppRoutes.searchPage);
      },
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
    );
  }

  Widget _buildImageAndText(ExhibitionDetailsBloc bloc, ExhibitionDetailsItemStyle style) {
    return Container(
      decoration: BoxDecoration(
        color: style.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
        child: Column(
          children: [
            SmartImage(
              path: 'https://i.ibb.co/RQj8JGk/Rectangle-651.png',
              width: 356.w,
              height: 200.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                SmartText(
                  'Sparkling Splendour: The Jewellery Spectacle',
                  style: style.titleStyle,
                ),
                SizedBox(
                  height: 16.h,
                ),
                SmartText(
                  'Lorem ipsum dolor sit amet consectetur. Enim quis phasellus sapien posuere dignissim mauris scelerisque in. Porttitor quis mauris viverra blandit arcu aenean amet hendrerit libero. Ut euismod accumsan eget massa nunc ac sed.',
                  style: style.subTitleStyle,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    SmartImage(
                      path: AppImages.icCalendar,
                      height: 16.h,
                      width: 16.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SmartText(
                      '25 - 28 Jul, 2023',
                      style: style.listTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SmartImage(
                      path: AppImages.icClock,
                      height: 16.h,
                      width: 16.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SmartText(
                      '10 AM - 10 PM',
                      style: style.listTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SmartImage(
                      path: AppImages.icMapPin,
                      height: 16.h,
                      width: 16.w,
                      color: style.iconColor,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SmartText(
                      'D.K Patel Hall, Ahmedabad',
                      style: style.listTextStyle,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(ExhibitionDetailsBloc bloc) {
    return [
      ExhibitionDetailsProductsTabViewList(bloc: bloc),
      ExhibitionDetailsOrdersScreen(bloc: bloc),
    ];
  }

  Widget _buildBottomNavigationBar(ExhibitionDetailsBloc bloc, BuildContext context) {
    return FilterBottomActionBar(
      onFilterTap: () {},
      onSortTap: () {
        Utils.showSmartModalBottomSheet(
          context: context,
          builder: (context) => const SortScreen(),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(ExhibitionDetailsBloc bloc) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) => current is ExhibitionChangeListingTypeState || current is ChangeExhibitionTabsState,
      builder: (context, state) {
        if (bloc.currentIndex == 0) {
          return ScrollToTopFAB(
            canScrollToTop:
                bloc.isGrid ? bloc.gridPaginationScrollController.canScrollToTop : bloc.listPaginationScrollController.canScrollToTop,
            onTap: bloc.isGrid ? bloc.gridPaginationScrollController.scrollToTop : bloc.listPaginationScrollController.scrollToTop,
          );
        } else {
          return ScrollToTopFAB(
            canScrollToTop: bloc.orderScrollController.canScrollToTop,
            onTap: bloc.orderScrollController.scrollToTop,
          );
        }
      },
    );
  }
}
