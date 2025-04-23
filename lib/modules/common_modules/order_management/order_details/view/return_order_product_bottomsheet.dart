import 'package:kgk/kgk.dart';

class ReturnOrderProductBottomSheet extends StatelessWidget {
  const ReturnOrderProductBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc orderDetailBloc = BlocProvider.of<OrderDetailBloc>(context);
    final ReturnOrderStyle style = AppTheme.of(context).returnOrderStyle;
    return Container(
      decoration: BoxDecoration(color: style.whiteColor, borderRadius: BorderRadius.all(Radius.circular(8.r))),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          _buildAppBar(context, style),
          SizedBox(height: 24.h),
          _buildOrderDetailsInfoCard(style),
          SizedBox(height: 27.h),
          SmartText(APPStrings.cancellationReason.tr, style: style.cancelReasonTitleStyle),
          SizedBox(height: 10.h),
          BlocBuilder<OrderDetailBloc, OrderDetailState>(
            buildWhen: (previous, current) => current is OrderCancellationReasonsChangeState || current is OrderDetailsLoadedState,
            builder: (context, state) {
              return SmartDropDown<CancellationReasonModel>(
                selectedItem: orderDetailBloc.selectedReason,
                items:
                    orderDetailBloc.cancellationReasonsList
                        .map((e) => SmartDropDownItem<CancellationReasonModel>(value: e, title: e.name ?? ''))
                        .toList(),
                hintText: APPStrings.cancellationReason.tr,
                onChanged: (newValue) {
                  if (newValue == null) return;
                  orderDetailBloc.add(OrderCancellationReasonsEvent(newValue));
                },
              );
            },
          ),
          BlocBuilder<OrderDetailBloc, OrderDetailState>(
            buildWhen: (previous, current) => current is OrderCancellationReasonsChangeState,
            builder: (context, state) {
              return state is OrderCancellationReasonsChangeState && state.cancellationReasonModel.id == 2
                  ? Column(
                    children: [
                      SizedBox(height: 10.h),
                      SmartTextField(
                        hintText: APPStrings.addReason.tr,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  )
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(height: 36.h),
          _bottomNavigationBar(context, orderDetailBloc),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ReturnOrderStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(APPStrings.returnProduct.tr, style: style.titleStyle),
        SizedBox(width: 8.w),
        SmartImage(
          path: AppImages.icCross,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _buildOrderDetailsInfoCard(ReturnOrderStyle style) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: style.orderInfoBackgroundColor),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText("Order #14567", style: style.orderIdStyle),
          SizedBox(height: 8.h),
          Material(
            child: ListTile(
              contentPadding: EdgeInsetsDirectional.zero,
              isThreeLine: true,
              leading: SmartImage(path: "https://i.ibb.co/8xM4BxQ/image-7.png", height: 48.w, width: 48.w),
              dense: true,
              horizontalTitleGap: 12.w,
              title: SmartText("Diamond Vine Ring in 18k Gold", style: style.imageTitleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Row(
                children: [
                  Flexible(child: SmartText('Martin Flyer', style: style.imageSubTitleStyle)),
                  SizedBox(width: 16.w),
                  Flexible(child: SmartText('DERS01XXSRR', style: style.imageSubTitleStyle)),
                ],
              ),
              trailing: SmartText("x15", style: style.quantityStyle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context, OrderDetailBloc bloc) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: SmartButton.white(
              onTap: () {
                context.pop();
              },
              title: APPStrings.cancel.tr,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: SmartButton(
              onTap: () {
                context.pop();
              },
              title: APPStrings.xReturn.tr,
            ),
          ),
        ],
      ),
    );
  }
}
