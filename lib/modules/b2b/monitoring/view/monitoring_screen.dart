import 'package:kgk/kgk.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MonitoringBloc bloc = BlocProvider.of<MonitoringBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.monitoring.tr,
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 17.0.h),
            Expanded(
              child: SmartTabBar(
                length: bloc.tabs.length,
                onTabInitialized: (tabController) {
                  // Here TabController is initialized
                  bloc.tabController = tabController;
                },
                padding: EdgeInsets.symmetric(horizontal: 17.0.w),
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                labelPadding: EdgeInsets.symmetric(horizontal: 13.5.w),
                onTapTab: (int index) => bloc.add(MonitoringOnTabChangedEvent(index: index)),
                tabs: bloc.tabs,
                tabBarView: _buildTabBarView(bloc),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(MonitoringBloc monitoringBloc) {
    return [
      PresentationsTabviewListTile(monitoringBloc: monitoringBloc),
      DbfTabviewListTile(monitoringBloc: monitoringBloc),
      DesignsTabviewListTile(monitoringBloc: monitoringBloc),
      StylesTabviewListTile(monitoringBloc: monitoringBloc),
    ];
  }
}
