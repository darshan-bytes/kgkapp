import 'package:kgk/kgk.dart';

class RetailerOrderListBuilder extends StatelessWidget {
  final void Function(int)? onTap;
  final Function(int)? onTapMenuButton;
  final List<B2BCustomListingDataModel> ordersList;
  final SmartPaginationScrollController currentScrollController;
  final B2BListingType currentListType;
  final RetailerOrderListingBloc bloc;

  const RetailerOrderListBuilder({
    super.key,
    this.onTap,
    this.onTapMenuButton,
    required this.ordersList,
    required this.currentScrollController,
    required this.currentListType,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefreshIndicator(
      onRefresh: () async {
        await bloc.pullToRefresh();
      },
      child: ListView.builder(
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
                    onTapMenuButton: onTapMenuButton != null ? () => onTapMenuButton!(index) : null,
                    margin: EdgeInsets.only(
                        bottom: (state is RetailerOrderListingLoadingMoreState && index == ordersList.length - 1) ? 0 : 16.h),
                    listingItemModel: ordersList[index],
                    type: currentListType,
                  ),
                  if (state is RetailerOrderListingLoadingMoreState && index == ordersList.length - 1)
                    const SmartCircularProgressIndicator(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
