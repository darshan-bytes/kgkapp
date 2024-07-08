import 'package:kgk/kgk.dart';

class RetailerOrderListBuilder extends StatelessWidget {
  final void Function(int)? onTap;
  final void Function(int)? onTapMenuButton;
  final List<B2BCustomListingDataModel> ordersList;
  final SmartPaginationScrollController currentScrollController;
  final B2BListingType currentListType;

  const RetailerOrderListBuilder({
    super.key,
    this.onTap,
    this.onTapMenuButton,
    required this.ordersList,
    required this.currentScrollController,
    required this.currentListType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ordersList.length,
      controller: currentScrollController.scrollController,
      itemBuilder: (context, index) {
        return BlocBuilder<RetailerOrderListingBloc, RetailerOrderListingState>(
          buildWhen: (previous, current) =>
              current is RetailerOrderListingListLoadedMoreState || current is RetailerOrderListingLoadingMoreState,
          builder: (context, state) {
            return Column(
              children: [
                B2BListingItem(
                  onTap: () {
                    onTap?.call(index);
                  },
                  margin:
                      EdgeInsets.only(bottom: (state is RetailerOrderListingLoadingMoreState && index == ordersList.length - 1) ? 0 : 16.h),
                  listingItemModel: ordersList[index],
                  type: currentListType,
                ),
                if (state is RetailerOrderListingLoadingMoreState && index == ordersList.length - 1) const SmartCircularProgressIndicator(),
              ],
            );
          },
        );
      },
    );
  }
}
