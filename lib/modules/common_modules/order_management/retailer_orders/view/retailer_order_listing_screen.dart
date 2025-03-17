import 'package:kgk/kgk.dart';

class RetailerOrderListingScreen extends StatelessWidget {
  const RetailerOrderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerOrderListingBloc retailerOrderListingBloc = BlocProvider.of<RetailerOrderListingBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.orderManagement.tr,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onNotification: () => context.pushNamed(AppRoutes.notificationPage),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(retailerOrderListingBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
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
    return BlocBuilder<RetailerOrderListingBloc, RetailerOrderListingState>(
      buildWhen: (previous, current) =>
          current is RetailerOrderListingListLoadedState ||
          current is ChangeRetailerOrderTabsState ||
          current is ChangeRetailerOrderStoneTypeState,
      builder: (context, state) {
        if (state is RetailerOrderListingListLoadedState ||
            state is ChangeRetailerOrderTabsState ||
            state is ChangeRetailerOrderStoneTypeState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: retailerOrderListingBloc.currentScrollController.controller,
              onFilterTap: () {},
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
