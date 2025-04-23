import 'package:kgk/kgk.dart';

class JewelleryTabView extends StatelessWidget {
  final OrdersBloc ordersBloc;

  const JewelleryTabView({super.key, required this.ordersBloc});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: style.dividerColor),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
    );
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: ordersBloc.orderPaginationScrollController.canScrollToTop,
        onTap: ordersBloc.orderPaginationScrollController.scrollToTop,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SmartTextField.search(
                        height: 48.w,
                        hintText: APPStrings.searchOrder.tr,
                        controller: ordersBloc.orderSearchController,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                        customFocusedBorder: outlineInputBorder,
                        customDisabledBorder: outlineInputBorder,
                        customErrorBorder: outlineInputBorder,
                        customFocusedErrorBorder: outlineInputBorder,
                        onTapOutside: (value) => FocusScope.of(context).unfocus(),
                        onValueChanges: (value) {
                          ordersBloc.add(OrdersListSearchEvent(context: context));
                        },
                        onFieldSubmitted: (value) {
                          ordersBloc.add(OrdersListSearchEvent(context: context));
                        },
                      ),
                    ),

                    /// TODO: selected stone type for filter is currently not in use as discussed with JD.
                    // _buildStoneDropDownField(ordersBloc, style),
                  ],
                ),
              ),

              /// TODO: three dot button is currently not in use as discussed with JD.
              // SizedBox(width: 16.0.w),
              // SelectionButton(
              //   width: 48.w,
              //   imageHeight: 24.5.w,
              //   imageWidth: 24.5.w,
              //   isSelected: false,
              //   image: AppImages.icMenu,
              //   onTap: () {},
              // ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: BlocBuilder<OrdersBloc, OrdersState>(
              buildWhen:
                  (previous, current) =>
                      current is OrdersListLoadedState ||
                      current is OrdersListLoadedMoreState ||
                      current is OrdersLoadingMoreState ||
                      current is OrdersLoadingState,
              builder: (context, state) {
                if (state is OrdersLoadingState) {
                  return Center(child: const SmartCircularProgressIndicator());
                }
                if (ordersBloc.filteredOrderList.isEmpty) {
                  return NoDataFoundWidget(text: APPStrings.noDataFound.tr); // Adjust text based on the selected tab if necessary
                }
                return OrderListBuilder(
                  currentScrollController: ordersBloc.orderPaginationScrollController,
                  ordersList: ordersBloc.filteredOrderList,
                  onTap: (index) {
                    /// Navigates to the order details page
                    ordersBloc.add(NavigateToOrderDetailsEvent(context: context, uniqueId: ordersBloc.filteredOrderList[index].id ?? ""));
                  },
                  bloc: ordersBloc,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// TODO: selected stone type for filter is currently not in use as discussed with JD.
  // Widget _buildStoneDropDownField(OrdersBloc ordersBloc, FilterBottomActionBarStyle style) {
  //   return BlocBuilder<OrdersBloc, OrdersState>(
  //     buildWhen: (previous, current) => current is ChangeOrdersStoneTypeState,
  //     builder: (context, state) {
  //       return SizedBox(
  //         width: 120.w,
  //         child: SmartDropDown<OrderStoneTypeModel>(
  //           border: BorderDirectional(
  //               end: BorderSide(color: style.dividerColor),
  //               top: BorderSide(color: style.dividerColor),
  //               bottom: BorderSide(color: style.dividerColor)),
  //           borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
  //           items: ordersBloc.arrStoneType.map((OrderStoneTypeModel type) {
  //             return SmartDropDownItem<OrderStoneTypeModel>(
  //               value: type,
  //               title: type.name,
  //             );
  //           }).toList(),
  //           onChanged: (type) {
  //             if (type != null) {
  //               ordersBloc.add(ChangeOrdersStoneTypeEvent(type));
  //             }
  //           },
  //           selectedItem: ordersBloc.selectedStoneType,
  //         ),
  //       );
  //     },
  //   );
  // }
}
