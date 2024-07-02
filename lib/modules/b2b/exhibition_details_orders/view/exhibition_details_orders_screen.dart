import 'package:kgk/kgk.dart';

class ExhibitionDetailsOrdersScreen extends StatelessWidget {
  const ExhibitionDetailsOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExhibitionDetailsOrdersBloc exhibitionDetailsOrdersBloc = BlocProvider.of<ExhibitionDetailsOrdersBloc>(context);
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<ExhibitionDetailsOrdersBloc, ExhibitionDetailsOrdersState>(
              buildWhen: (previous, current) => current is ExhibitionDetailsOrdersLoadedState,
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: SmartTextField.search(
                              height: 48.h,
                              onValueChanges: (value) => {},
                              onFieldSubmitted: (value) => {},
                              hintText: APPStrings.searchOrder.tr,
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
                    ),
                    _ordersListing(exhibitionDetailsOrdersBloc, context),
                  ],
                );
              })),
    );
  }

  Widget _ordersListing(ExhibitionDetailsOrdersBloc exhibitionDetailsOrdersBloc, BuildContext context) {
    final style = AppTheme.of(context).exhibitionDetailsOrdersStyle;
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = exhibitionDetailsOrdersBloc.exhibitionOrders[index];
            return _orderItem(item, style);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          padding: EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
          itemCount: exhibitionDetailsOrdersBloc.exhibitionOrders.length),
    );
  }

  Widget _orderItem(ExhibitionDetailsOrdersModel item, ExhibitionDetailsOrdersStyle style) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: style.borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDetailColumn(APPStrings.orderId.tr, item.id.toString(), style)),
                  Expanded(child: _buildDetailColumn(APPStrings.orderName.tr, item.orderName, style)),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDetailColumn(APPStrings.market.tr, item.market, style, image: item.marketImageUrl)),
                  Expanded(child: _buildDetailColumn(APPStrings.items.tr, item.items, style)),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDetailColumn(APPStrings.totalAmount.tr, item.totalAmount, style)),
                  Expanded(child: _buildDetailColumn(APPStrings.approvedBy.tr, item.approvedBy, style, image: item.approvedByImageUrl)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 14.h,
          right: 14.w,
          child: SmartImage(
            path: AppImages.icMoreHorizontal,
            onTap: () {},
            padding: EdgeInsets.all(4.w),
            inkwellBorderRadius: BorderRadius.circular(4.0.r),
          ),
        ),
      ],
    );
  }
}

Widget _buildDetailColumn(String title, String? value, ExhibitionDetailsOrdersStyle style, {String? image}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SmartText(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style.titleStyle,
      ),
      SizedBox(height: 4.h),
      Row(
        children: [
          if (image != null)
            SmartImage(
              padding: EdgeInsets.only(right: 4.w),
              path: image,
              height: 24.w,
              width: 24.w,
            ),
          SmartText(
            value.isNullOrEmpty ? APPStrings.dash.tr : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.valueStyle,
          ),
        ],
      ),
    ],
  );
}
