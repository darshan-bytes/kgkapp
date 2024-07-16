import 'package:kgk/kgk.dart';

class NewsletterScreen extends StatelessWidget {
  const NewsletterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsletterBloc bloc = BlocProvider.of<NewsletterBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.newsletter.tr,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onNotification: () => context.pushNamed(AppRoutes.notificationPage),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: Column(
            children: [
              SizedBox(height: 17.0.h),
              Expanded(
                child: SmartTabBar(
                  labelPadding: EdgeInsets.zero,
                  indicatorHeight: 4.0.h,
                  length: bloc.tabs.length,
                  onTabInitialized: (tabController) {
                    // Here TabController is initialized
                    bloc.tabController = tabController;
                  },
                  onTapTab: (int index) => bloc.add(const ChangeNewsletterTabsEvent()),
                  tabs: bloc.tabs,
                  tabBarView: bloc.buildTabBarView(bloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(NewsletterBloc bloc, BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SelectionButton(
            borderRadius: BorderRadius.zero,
            isSelected: false,
            onTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
            image: AppImages.icFilter,
            title: APPStrings.filter.tr,
          ),
        ],
      ),
    );
  }
}
