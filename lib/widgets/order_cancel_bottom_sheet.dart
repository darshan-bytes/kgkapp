import 'package:kgk/kgk.dart';

class OrderCancelBottomSheet extends StatelessWidget {
  final OrderDetailBloc orderDetailBloc;

  const OrderCancelBottomSheet({super.key, required this.orderDetailBloc});

  @override
  Widget build(BuildContext context) {
    OrderCancelPopupStyle style = AppTheme.of(context).orderCancelPopupStyle;

    return Container(
      decoration: BoxDecoration(color: style.whiteColor, borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SmartSingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: style.whiteColor, borderRadius: BorderRadius.all(Radius.circular(16.r))),
                      padding: EdgeInsetsDirectional.all(18.w),
                      child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
                        bloc: orderDetailBloc,
                        buildWhen: (previous, current) =>
                            current is CancellationFieldErrorState && current.fieldType == FieldTypeValidationEnum.firstName,
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SmartText(
                                APPStrings.areYouSure.tr,
                                style: style.headerTitleStyle,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              SmartText(
                                APPStrings.orderWillBeCancelledX.tr.interpolate([orderDetailBloc.placeOrderResponse?.uniqueId]),
                                style: style.subTitleStyle,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: context.width,
                                padding: EdgeInsetsDirectional.all(14.w),
                                decoration: BoxDecoration(color: style.refundBgColor, borderRadius: BorderRadius.all(Radius.circular(6.r))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmartText(
                                      APPStrings.refundAmount.tr,
                                      style: style.refundTitleStyle,
                                    ),
                                    SizedBox(
                                      height: 6.w,
                                    ),
                                    SmartText(
                                      orderDetailBloc.placeOrderResponse?.totalPrice?.setCurrency ?? '',
                                      style: style.amountTitleStyle,
                                    ),

                                    /// TODO : temporarily unused
                                    // SizedBox(
                                    //   height: 10.w,
                                    // ),
                                    // SmartText(
                                    //   APPStrings.refundTo.tr,
                                    //   style: style.refundTitleStyle,
                                    // ),
                                    // SizedBox(
                                    //   height: 6.w,
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     SmartImage(path: AppImages.icVisa, height: 24.w, width: 38.w),
                                    //     SizedBox(
                                    //       width: 10.w,
                                    //     ),
                                    //     SmartText(
                                    //       "**** **** **** 1234",
                                    //       style: style.amountTitleStyle,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SmartText(
                                APPStrings.cancellationReason.tr,
                                style: style.cancelReasonTitleStyle,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SmartTextField(
                                controller: orderDetailBloc.cancellationOrderController,
                                errorText: orderDetailBloc.cancelOrderError,
                                hintText: APPStrings.cancellationReason.tr,
                                onTapOutside: (value) => FocusScope.of(context).unfocus(),
                                onValueChanges: (value) {
                                  if (value.isNotNullNorEmpty) {
                                    orderDetailBloc.add(CancelOrderCommentChangeEvent(fieldType: FieldTypeValidationEnum.firstName));
                                  }
                                },
                              ),

                              SizedBox(
                                height: 10.h,
                              ),

                              /// TODO : temporarily unused
                              // BlocBuilder<OrderDetailBloc, OrderDetailState>(
                              //   buildWhen: (previous, current) =>
                              //       current is OrderCancellationReasonsChangeState || current is OrderDetailsLoadedState,
                              //   builder: (context, state) {
                              //     return SmartDropDown<CancellationReasonModel>(
                              //       selectedItem: orderDetailBloc.selectedReason,
                              //       items: orderDetailBloc.cancellationReasonsList
                              //           .map((e) => SmartDropDownItem<CancellationReasonModel>(value: e, title: e.name ?? ''))
                              //           .toList(),
                              //       hintText: APPStrings.cancellationReason.tr,
                              //       onChanged: (newValue) {
                              //         if (newValue == null) return;
                              //         orderDetailBloc.add(OrderCancellationReasonsEvent(newValue));
                              //       },
                              //     );
                              //   },
                              // ),
                              // BlocBuilder<OrderDetailBloc, OrderDetailState>(
                              //   buildWhen: (previous, current) => current is OrderCancellationReasonsChangeState,
                              //   builder: (context, state) {
                              //     return state is OrderCancellationReasonsChangeState && state.cancellationReasonModel.id == 2
                              //         ? Column(
                              //             children: [
                              //               SizedBox(
                              //                 height: 10.h,
                              //               ),
                              //               SmartTextField(
                              //                 hintText: APPStrings.addReason.tr,
                              //                 keyboardType: TextInputType.text,
                              //                 textInputAction: TextInputAction.done,
                              //               ),
                              //             ],
                              //           )
                              //         : const SizedBox.shrink();
                              //   },
                              // ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SmartButton(
                                  onTap: () {
                                    orderDetailBloc.add(OrderCancellationEvent(
                                        context: context, placeOrderResponse: orderDetailBloc.placeOrderResponse!, isFromFullOrder: true));
                                  },
                                  title: APPStrings.submit.tr)
                            ],
                          );
                        },
                      ),
                    ),
                    PositionedDirectional(
                      top: 16.w,
                      end: 16.w,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: SmartImage(
                          path: AppImages.icCross,
                          height: 24.w,
                          width: 24.w,
                          color: style.crossColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
