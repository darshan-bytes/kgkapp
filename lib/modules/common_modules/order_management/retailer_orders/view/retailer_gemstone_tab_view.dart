import 'package:kgk/kgk.dart';

class RetailerGemstoneTabView extends StatelessWidget {
  final RetailerOrderListingBloc retailerOrderListingBloc;

  const RetailerGemstoneTabView({super.key, required this.retailerOrderListingBloc});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: style.dividerColor),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
    );
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: retailerOrderListingBloc.currentScrollController.canScrollToTop,
        onTap: retailerOrderListingBloc.currentScrollController.scrollToTop,
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
                        controller: retailerOrderListingBloc.gemstoneSearchController,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                        customFocusedBorder: outlineInputBorder,
                        customDisabledBorder: outlineInputBorder,
                        customErrorBorder: outlineInputBorder,
                        customFocusedErrorBorder: outlineInputBorder,
                      ),
                    ),
                    _buildStoneDropDownField(retailerOrderListingBloc, style),
                  ],
                ),
              ),
              SizedBox(width: 16.0.w),
              SelectionButton(
                width: 48.w,
                imageHeight: 24.5.w,
                imageWidth: 24.5.w,
                isSelected: false,
                image: AppImages.icMenu,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: BlocBuilder<RetailerOrderListingBloc, RetailerOrderListingState>(
              buildWhen: (previous, current) =>
                  current is RetailerOrderListingListLoadedState ||
                  current is RetailerOrderListingListLoadedMoreState ||
                  current is RetailerOrderListingLoadingMoreState,
              builder: (context, state) {
                if (retailerOrderListingBloc.gemstoneList.isEmpty) {
                  return NoDataFoundWidget(text: APPStrings.noDataFound.tr); // Adjust text based on the selected tab if necessary
                }
                return RetailerOrderListBuilder(
                  currentScrollController: retailerOrderListingBloc.currentScrollController,
                  ordersList: retailerOrderListingBloc.gemstoneList,
                  currentListType: B2BListingType.retailerOrderListingDiamondType,
                  onTap: (index) {
                    context.pushNamed(AppRoutes.orderDetailsPage);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoneDropDownField(RetailerOrderListingBloc retailerOrderListingBloc, FilterBottomActionBarStyle style) {
    return BlocBuilder<RetailerOrderListingBloc, RetailerOrderListingState>(
      buildWhen: (previous, current) => current is ChangeRetailerOrderStoneTypeState,
      builder: (context, state) {
        return SizedBox(
          width: 120.w,
          child: SmartDropDown<OrderStoneTypeModel>(
            border: Border(
                right: BorderSide(color: style.dividerColor),
                top: BorderSide(color: style.dividerColor),
                bottom: BorderSide(color: style.dividerColor)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
            items: retailerOrderListingBloc.arrStoneType.map((OrderStoneTypeModel type) {
              return SmartDropDownItem<OrderStoneTypeModel>(
                value: type,
                title: type.name,
              );
            }).toList(),
            onChanged: (type) {
              if (type != null) {
                retailerOrderListingBloc.add(ChangeRetailerOrderStoneTypeEvent(type));
              }
            },
            selectedItem: retailerOrderListingBloc.selectedStoneType,
          ),
        );
      },
    );
  }
}
