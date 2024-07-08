import 'package:kgk/kgk.dart';

class OrderListBuilder extends StatelessWidget {
  final void Function(int)? onTap;
  final void Function(int)? onTapMenuButton;
  final List<MyOrderDetailsModel> ordersList;
  final SmartPaginationScrollController currentScrollController;

  const OrderListBuilder({
    super.key,
    this.onTap,
    this.onTapMenuButton,
    required this.ordersList,
    required this.currentScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ordersList.length,
      controller: currentScrollController.scrollController,
      itemBuilder: (context, index) {
        return BlocBuilder<OrdersBloc, OrdersState>(
          buildWhen: (previous, current) => current is OrdersListLoadedMoreState || current is OrdersLoadingMoreState,
          builder: (context, state) {
            return Column(
              children: [
                MyOrderItem(
                  margin: EdgeInsets.only(bottom: (state is OrdersLoadingMoreState && index == ordersList.length - 1) ? 0 : 16.h),
                  onTap: () {
                    if (onTap != null) {
                      onTap!(index);
                    }
                  },
                  onTapMenuButton: () {
                    if (onTapMenuButton != null) {
                      onTapMenuButton!(index);
                    }
                  },
                  myOrderDetailsModel: ordersList[index],
                ),
                if (state is OrdersLoadingMoreState && index == ordersList.length - 1) const SmartCircularProgressIndicator(),
              ],
            );
          },
        );
      },
    );
  }
}
