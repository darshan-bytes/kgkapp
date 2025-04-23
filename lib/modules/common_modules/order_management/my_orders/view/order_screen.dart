import 'package:kgk/kgk.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersBloc ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.myOrders.tr),
      bottomNavigationBar: _buildBottomNavigationBar(ordersBloc),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
          child: Column(
            children: [
              SizedBox(height: 17.0.h),
              Expanded(
                child: SmartTabBar(
                  length: ordersBloc.tabs.length,
                  onTabInitialized: (tabController) {
                    // Here TabController is initialized
                    ordersBloc.tabController = tabController;
                  },
                  onTapTab: (int index) => ordersBloc.add(ChangeOrderTabsEvent(index: index, context: context)),
                  tabs: ordersBloc.tabs,
                  tabBarView: _buildTabBarView(ordersBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarView(OrdersBloc ordersBloc) {
    return [DiamondTabView(ordersBloc: ordersBloc), GemstoneTabView(ordersBloc: ordersBloc), JewelleryTabView(ordersBloc: ordersBloc)];
  }

  Widget _buildBottomNavigationBar(OrdersBloc ordersBloc) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) => current is OrdersListLoadedState || current is ChangeOrderTabsState,
      builder: (context, state) {
        if (state is OrdersListLoadedState || state is ChangeOrderTabsState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: ordersBloc.orderPaginationScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder:
                      (context) => AdvanceFilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            ordersBloc.add(OrdersListFilterEvent(filterData: value, context: context));
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
