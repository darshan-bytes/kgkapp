import 'package:kgk/kgk.dart';

class RetailerOrderListingScreen extends StatelessWidget {
  const RetailerOrderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerOrderListingBloc retailerOrderListingBloc = BlocProvider.of<RetailerOrderListingBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.orderManagement.tr),
      bottomNavigationBar: _buildBottomNavigationBar(retailerOrderListingBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: Column(
            children: [
              SizedBox(height: 17.0.h),
              Expanded(
                child: SmartTabBar(
                  length: retailerOrderListingBloc.tabs.length,
                  onTabInitialized: (tabController) {
                    // Here TabController is initialized
                    retailerOrderListingBloc.tabController = tabController;
                  },
                  onTapTab: (int index) => retailerOrderListingBloc.add(const ChangeRetailerOrderTabsEvent()),
                  tabs: retailerOrderListingBloc.tabs,
                  tabBarView: _buildTabBarView(retailerOrderListingBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(RetailerOrderListingBloc retailerOrderListingBloc) {
    return [
      RetailerDiamondTabView(retailerOrderListingBloc: retailerOrderListingBloc),
      RetailerGemstoneTabView(retailerOrderListingBloc: retailerOrderListingBloc),
      RetailerJewelleryTabView(retailerOrderListingBloc: retailerOrderListingBloc),
    ];
  }

  Widget _buildBottomNavigationBar(RetailerOrderListingBloc retailerOrderListingBloc) {
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
