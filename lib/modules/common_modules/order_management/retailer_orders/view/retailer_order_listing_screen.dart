import 'package:kgk/kgk.dart';

class RetailerOrderListingScreen extends StatelessWidget {
  const RetailerOrderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerOrderListingBloc bloc = BlocProvider.of<RetailerOrderListingBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.myOrders.tr),
      bottomNavigationBar: _buildBottomNavigationBar(bloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
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
                  onTapTab: (int index) => bloc.add(const RetailerChangeOrderTabsEvent()),
                  tabs: bloc.tabs,
                  tabBarView: _buildTabBarView(bloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(RetailerOrderListingBloc bloc) {
    return [
      RetailerDiamondTabView(bloc: bloc),
      RetailerGemstoneTabView(bloc: bloc),
      RetailerJewelleryTabView(bloc: bloc),
    ];
  }

  Widget _buildBottomNavigationBar(RetailerOrderListingBloc bloc) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SelectionButton(
            borderRadius: BorderRadius.zero,
            isSelected: false,
            onTap: () {},
            image: AppImages.icFilter,
            title: APPStrings.filter.tr,
          ),
        ],
      ),
    );
  }
}
