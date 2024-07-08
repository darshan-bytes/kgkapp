import 'package:kgk/kgk.dart';

class RetailerJewelleryTabView extends StatelessWidget {
  final RetailerOrderListingBloc bloc;

  const RetailerJewelleryTabView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    return Column(
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
                      controller: bloc.jewellerySearchController,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      customFocusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: style.dividerColor),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      ),
                      customDisabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: style.dividerColor),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      ),
                      customErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: style.dividerColor),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      ),
                      customFocusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: style.dividerColor),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      ),
                    ),
                  ),
                  _buildStoneDropDownField(bloc, style),
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
            builder: (context, state) {
              return ListView.builder(
                itemCount: bloc.retailerDiamondOrdersList.length,
                itemBuilder: (context, index) {
                  return B2BListingItem(
                    margin: EdgeInsets.only(bottom: 16.0.h),
                    listingItemModel: bloc.retailerJewelleryOrdersList[index],
                    type: B2BListingType.retailerOrderListingJewelleryType,
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 17.0.h),
      ],
    );
  }

  Widget _buildStoneDropDownField(RetailerOrderListingBloc bloc, FilterBottomActionBarStyle style) {
    return BlocBuilder<RetailerOrderListingBloc, RetailerOrderListingState>(
      buildWhen: (previous, current) => current is RetailerChangeOrdersTypeState,
      builder: (context, state) {
        return SizedBox(
          width: 120.w,
          child: SmartDropDown<RetailerOrderModel>(
            border: Border(
                right: BorderSide(color: style.dividerColor),
                top: BorderSide(color: style.dividerColor),
                bottom: BorderSide(color: style.dividerColor)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
            items: bloc.arrStoneType.map((RetailerOrderModel type) {
              return SmartDropDownItem<RetailerOrderModel>(
                value: type,
                title: type.name,
              );
            }).toList(),
            onChanged: (type) {
              if (type != null) {
                bloc.add(RetailerChangeOrdersTypeEvent(type));
              }
            },
            selectedItem: bloc.selectedStoneType,
          ),
        );
      },
    );
  }
}
