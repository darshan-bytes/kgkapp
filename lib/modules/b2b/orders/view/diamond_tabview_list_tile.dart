import 'package:kgk/kgk.dart';

class DiamondTabView extends StatelessWidget {
  final OrdersBloc ordersBloc;

  const DiamondTabView({super.key, required this.ordersBloc});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.0.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SmartTextField.search(
                        height: 48.h,
                        onValueChanges: (value) => ordersBloc.add(const FilterDiamondOrdersEvent()),
                        onFieldSubmitted: (value) => ordersBloc.add(const FilterDiamondOrdersEvent()),
                        hintText: APPStrings.searchOrder.tr,
                        controller: ordersBloc.diamondSearchController,
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
                    _buildStoneDropDownField(ordersBloc, style),
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
          BlocBuilder<OrdersBloc, OrdersState>(
            buildWhen: (previous, current) => current is FilterDiamondOrdersState,
            builder: (context, state) {
              return OrderListBuilder(
                ordersList: ordersBloc.filteredDiamondOrdersList,
                onTap: (p0) {
                  context.pushNamed(AppRoutes.orderDetailsPage);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStoneDropDownField(OrdersBloc ordersBloc, FilterBottomActionBarStyle style) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (previous, current) => current is ChangeOrdersStoneTypeState,
      builder: (context, state) {
        return SizedBox(
          width: 120.w,
          child: SmartDropDown<OrderStoneTypeModel>(
            border: Border(
                right: BorderSide(color: style.dividerColor),
                top: BorderSide(color: style.dividerColor),
                bottom: BorderSide(color: style.dividerColor)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
            items: ordersBloc.arrStoneType.map((OrderStoneTypeModel type) {
              return SmartDropDownItem<OrderStoneTypeModel>(
                value: type,
                title: type.name,
              );
            }).toList(),
            onChanged: (type) {
              if (type != null) {
                ordersBloc.add(ChangeOrdersStoneTypeEvent(type));
              }
            },
            selectedItem: ordersBloc.selectedStoneType,
          ),
        );
      },
    );
  }
}
