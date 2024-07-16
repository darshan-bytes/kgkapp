import 'package:kgk/kgk.dart';

class ManufacturerOrderDetailsScreen extends StatelessWidget {
  const ManufacturerOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManufacturerOrderDetailsBloc bloc = BlocProvider.of<ManufacturerOrderDetailsBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.orderManagement.tr,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onNotification: () => context.pushNamed(AppRoutes.notificationPage),
      ),
      body: _getBody(context, bloc),
    );
  }

  Widget _getBody(BuildContext context, ManufacturerOrderDetailsBloc bloc) {
    final OrderDetailScreenStyle orderDetailScreenStyle = AppTheme.of(context).orderDetailScreenStyle;
    return SafeArea(
      child: SmartSingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildManufacturerOrderDetailsInfoCard(bloc, context, orderDetailScreenStyle),
            SizedBox(height: 24.h),
            _buildManufacturerOrderCreatorDetailsInfoCard(bloc, context, orderDetailScreenStyle),
            SizedBox(height: 32.h),
            _buildSearchTextField(bloc),
            SizedBox(height: 24.h),
            _buildManufacturerOrderList(bloc, context),
            SizedBox(height: 16.h),
            _buildOrderTotalDiamondItemsDetails(bloc, context),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildManufacturerOrderList(ManufacturerOrderDetailsBloc bloc, BuildContext context) {
    return BlocBuilder<ManufacturerOrderDetailsBloc, ManufacturerOrderDetailsState>(
      buildWhen: (prev, current) => current is ManufacturerOrderDataFetchedState,
      builder: (context, state) {
        if (state is ManufacturerOrderDataFetchedState) {
          if (bloc.orderList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noOrderListFound.tr);
          }
          return ListView.builder(
            itemCount: bloc.orderList.length,
            padding: EdgeInsets.symmetric(horizontal: 17.0.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildManufacturerOrderListItem(bloc, context, index);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildManufacturerOrderListItem(ManufacturerOrderDetailsBloc bloc, BuildContext context, int index) {
    final MyBagDiamondItemStyle style = AppTheme.of(context).myBagDiamondItemStyle;
    ManufacturerOrderDetailsModel model = bloc.orderList[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16.0.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: style.backgroundColor,
          border: Border.all(color: style.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SmartImage(path: model.orderProductImage ?? '', height: 32.w, width: 32.w),
                SizedBox(width: 8.w),
                Expanded(
                  child: SmartText(
                    model.orderId ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.headingStyle,
                  ),
                ),
                SizedBox(width: 8.w),
                SmartImage(path: AppImages.icMoreHorizontal, onTap: () {})
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.shape.tr, model.orderProductShape ?? '', style)),
                Expanded(
                    child:
                        _buildManufacturerDetailColumn(APPStrings.certificateNumber.tr, model.orderProductCertificateNumber ?? '', style)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.measurements.tr, model.orderProductMeasurements ?? '', style)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.lab.tr, model.orderProductLab ?? '', style)),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.ct.tr, model.orderProductCt ?? '', style)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.colour.tr, model.orderProductColour ?? '', style)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.clarity.tr, model.orderProductClarity ?? '', style)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.cut.tr, model.orderProductCut ?? '', style)),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.rap.tr, model.orderProductRap ?? '', style)),
                Expanded(
                    child:
                        _buildManufacturerDetailColumn(APPStrings.discount.tr, model.orderProductDiscount ?? '', style, isDiscount: true)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.kgkAmount.tr, model.orderProductKgkAmount ?? '', style)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: _buildManufacturerDetailColumn(APPStrings.yourPercentage.tr, model.orderProductYourPercentage ?? '', style,
                        isTextFormField: true)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.yourRate.tr, model.orderProductYourRate ?? '', style)),
                Expanded(child: _buildManufacturerDetailColumn(APPStrings.yourValue.tr, model.orderProductYourValue ?? '', style)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManufacturerDetailColumn(String title, String? value, MyBagDiamondItemStyle style,
      {bool isTextFormField = false, bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.titleStyle,
          ),
          SizedBox(height: 4.h),
          isTextFormField && value != null
              ? SizedBox(
                  width: 56.w,
                  child: SmartTextField(
                    height: 32.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    isEnabled: false,
                    cursorHeight: 16.h,
                    controller: TextEditingController(text: value),
                    disabledBorderColor: style.borderColor,
                    textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    style: style.subTitleStyle,
                  ),
                )
              : SmartText(
                  value.isNullOrEmpty ? APPStrings.dash.tr : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isDiscount ? style.richTextStyle : style.subTitleStyle,
                ),
        ],
      ),
    );
  }

  Widget _buildSearchTextField(ManufacturerOrderDetailsBloc bloc) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Row(
        children: [
          Expanded(
            child: SmartTextField.search(
              height: 48.h,
              onValueChanges: (value) => () {},
              onFieldSubmitted: (value) => () {},
              hintText: APPStrings.searchOrder.tr,
              controller: bloc.searchController,
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
    );
  }

  Widget _buildManufacturerOrderDetailsInfoCard(ManufacturerOrderDetailsBloc bloc, BuildContext context, OrderDetailScreenStyle style) {
    return Container(
      color: style.detailsTileColor,
      padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartText(
                      '#14567',
                      style: style.orderIdStyle,
                    ),
                    SizedBox(height: 4.h),
                    SmartText(
                      "Ordered on: 17/03/23 10:00 PM",
                      style: style.orderDateStyle,
                    )
                  ],
                ),
              ),
              SmartImage(
                path: AppImages.icMenu,
                onTap: () {
                  _showManufacturerOrderDetailPopup(context, bloc);
                },
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDetailColumn(APPStrings.orderStatus.tr, ProjectStatus.onTime.value, style, isStatus: true)),
              Expanded(child: _buildDetailColumn(APPStrings.purchaseOrder.tr, ProjectStatus.created.value, style, isStatus: true)),
              _buildDetailColumn(APPStrings.items.tr, "15", style, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(width: 47.w),
              _buildDetailColumn(APPStrings.qty.tr, "250", style, crossAxisAlignment: CrossAxisAlignment.end),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildManufacturerOrderCreatorDetailsInfoCard(
      ManufacturerOrderDetailsBloc bloc, BuildContext context, OrderDetailScreenStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreatorDetailItem(
              title: APPStrings.customerName.tr, iconImage: "https://i.ibb.co/MRrjy5G/image-466.png", value: "Entice", style: style),
          SizedBox(height: 24.h),
          _buildCreatorDetailItem(title: APPStrings.mobileNumber.tr, iconImage: AppImages.icPhone, value: "(406) 555-0120", style: style),
          SizedBox(height: 24.h),
          _buildCreatorDetailItem(
              title: APPStrings.billingAddress.tr, value: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ", style: style),
          SizedBox(height: 12.h),
          _buildCreatorDetailItem(
              title: APPStrings.shippingAddress.tr, value: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ", style: style),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String title, String? value, OrderDetailScreenStyle style,
      {bool isStatus = false, bool totalAmount = false, CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SmartText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.orderItemLabelStyle,
          ),
          SizedBox(height: 4.h),
          isStatus
              ? SmartStatusBadge(currentStatus: ProjectStatus.values.firstWhere((orderStatus) => orderStatus.value == value))
              : SmartText(
                  value.isNullOrEmpty ? APPStrings.dash.tr : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: totalAmount ? style.orderTotalStyle : style.orderItemValueStyle,
                ),
        ],
      ),
    );
  }

  Widget _buildCreatorDetailItem({String? title, String? value, required OrderDetailScreenStyle style, String? iconImage}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: SmartText(
            title,
            style: style.orderItemLabelStyle,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Row(
            children: [
              if (iconImage != null)
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      alignment: Alignment.center,
                      child: SmartImage(
                        path: iconImage,
                        fit: BoxFit.fill,
                        height: 24.w,
                        width: 24.w,
                      ),
                    ),
                  ),
                ),
              if (value != null)
                Flexible(
                  child: SmartText(
                    value.isNullOrEmpty ? APPStrings.dash.tr : value,
                    style: style.orderItemValueStyle,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showManufacturerOrderDetailPopup(BuildContext context, ManufacturerOrderDetailsBloc bloc) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(context).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
            color: orderPopupStyle.whiteColor,
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupOption(context, text: APPStrings.trackOrder.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                _showTrackBottomSheet(context, bloc);
              }),
              _buildPopupOption(context,
                  text: APPStrings.orderTimeline.tr.toLowerCase().capitalizeFirst, style: orderPopupStyle.optionTextStyle, onTap: () {
                context.popAndPushNamed(AppRoutes.orderTimelinePage);
              }),
              _buildPopupOption(context, text: APPStrings.cancelOrder.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                _showCancelBottomSheet(context, bloc);
              }),
            ],
          ),
        );
      },
    );
  }

  void _showTrackBottomSheet(BuildContext context, ManufacturerOrderDetailsBloc bloc) {
    context.pop();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => BlocProvider<ManufacturerOrderDetailsBloc>(
        create: (context) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
        child: const TrackManufacturerOrderBottomSheet(),
      ),
    );
  }

  void _showCancelBottomSheet(BuildContext context, ManufacturerOrderDetailsBloc bloc) {
    context.pop();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) {
        return BlocProvider<ManufacturerOrderDetailsBloc>(
          create: (context) => ManufacturerOrderDetailsBloc()..add(ManufacturerOrderDetailsInitialEvent(context: context)),
          child: _getCancelOrderScreen(bloc),
        );
      },
    );
  }

  Widget _getCancelOrderScreen(ManufacturerOrderDetailsBloc bloc) {
    if (bloc.screenIdentifier == ScreenIdentifier.cancelOrderForRetailer) {
      return const RetailerOrderCancelBottomSheet();
    } else if ((bloc.screenIdentifier == ScreenIdentifier.cancelOrderForManufacturer)) {
      return const ConfirmCancellationBottomSheet();
    }
    return const RetailerOrderCancelBottomSheet();
  }

  Widget _buildPopupOption(BuildContext context,
      {required String text, required TextStyle style, EdgeInsets? padding, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: Alignment.centerLeft,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }

  Widget _buildOrderTotalDiamondItemsDetails(ManufacturerOrderDetailsBloc bloc, BuildContext context) {
    MyBagScreenStyle style = AppTheme.of(context).myBagScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.totalStones.tr, '15', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.origTotalDiscount.tr, '-0.45%', style)
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.totalPriceAfterDiscount.tr, '\$3,00,540.00', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.originalRatePerCarat.tr, '14,937.38', style),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.avgPricePerCarat.tr, '\$14,937.38', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.totalWeight.tr, '20.120', style),
            ],
          ),
          SizedBox(height: 12.h),
          _buildTextInfoColumn(APPStrings.totalValueAfterDiscount.tr, '\$3,00,540.00', style, isExpanded: false),
          SizedBox(height: 12.h),
          _buildTextInfoColumn(APPStrings.commentQuestion.tr, 'Lorem ipsum dolor sit amet consectetur.', style, isExpanded: false),
        ],
      ),
    );
  }

  Widget _buildTextInfoColumn(String title, String value, MyBagScreenStyle style, {bool isExpanded = true}) {
    Widget view = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          title,
          style: style.bottomBarTotalTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        SmartText(
          value,
          style: style.textInfoValueStyle,
        ),
      ],
    );
    return isExpanded ? Expanded(child: view) : view;
  }
}
