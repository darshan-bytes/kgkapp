import 'package:kgk/kgk.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc bloc = BlocProvider.of<OrderDetailBloc>(context);
    final OrderDetailScreenStyle style = AppTheme.of(context).orderDetailScreenStyle;

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.myOrders.tr),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        buildWhen: (previous, current) => current is OrderDetailsLoadedState || current is OrderDetailsLoadingState,
        builder: (context, state) {
          if (state is OrderDetailsLoadingState) {
            return const SmartCircularProgressIndicator();
          }
          if (state is OrderDetailsLoadedState) {
            return _OrderDetailBody(bloc: bloc, style: style);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  final OrderDetailBloc bloc;
  final OrderDetailScreenStyle style;

  const _OrderDetailBody({required this.bloc, required this.style});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartSingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrderDetailsInfoCard(style: style, placeOrderResponse: bloc.placeOrderResponse),
            _OrderCreatorDetailsCard(style: style, bloc: bloc, placeOrderResponse: bloc.placeOrderResponse),
            SizedBox(height: 24.h),
            _buildSearchTextField(bloc),
            SizedBox(height: 24.h),
            _buildOrderList(bloc, style)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField(OrderDetailBloc bloc) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
      child: Row(
        children: [
          Expanded(
            child: SmartTextField.search(
              height: 48.h,
              hintText: APPStrings.searchOrder.tr,
              controller: bloc.orderSearchController,
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
    );
  }

  Widget _buildOrderList(OrderDetailBloc bloc, OrderDetailScreenStyle style) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) => current is OrderDetailProductRemovedState || current is OrderDetailsLoadedState,
      builder: (context, state) {
        return ListView.separated(
          itemCount: bloc.userType == UserType.b2cUser ? bloc.orderProductList.length : bloc.orderProductDetailsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
          itemBuilder: (context, index) {
            if (bloc.userType == UserType.b2cUser) {
              final ProductDetailsModel product = bloc.orderProductList[index];
              return CartProductItem(
                isOutOfStock: false,
                boxHeight: 72.w,
                boxWidth: 72.w,
                isDropDownEnable: false,
                isCheckboxShow: false,
                isEnableAddToWishList: false,
                onRemoveTap: () {
                  bloc.add(OrderDetailRemoveProductEvent(index: index));
                },
                onMoveToWishListTap: null,
                productDetails: product,
                qualityOptionsList: product.cartProductQuality ?? [],
                quantityOptionsList: product.cartProductQuantity ?? [],
                priceTextStyle: style.priceTextStyle,
              );
            } else {
              final productDetails = bloc.orderProductDetailsList[index];
              return OrderDetailsProductItem(
                productDetails: productDetails,
                onTap: () {},
                onTapMenuButton: () {},
              );
            }
          },
          separatorBuilder: (context, index) => SizedBox(height: 24.h),
        );
      },
    );
  }

  void _showOrderDetailPopup(OrderDetailBloc bloc, BuildContext context) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(context).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
            color: orderPopupStyle.whiteColor,
          ),
          padding: EdgeInsetsDirectional.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupOption(context, text: APPStrings.trackOrder.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                _showTrackOrderBottomSheet(bloc, context, APPStrings.trackOrder.tr);
              }),
              _buildPopupOption(context, text: APPStrings.manufacturingStatus.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                _showTrackOrderBottomSheet(bloc, context, APPStrings.manufacturingStatus.tr);
              }),
              if (bloc.userType == UserType.b2bUser) ...{
                _buildPopupOption(context, text: APPStrings.returnProduct.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                  _showReturnProductBottomSheet(bloc, context);
                }),
              } else ...{
                _buildPopupOption(context, text: APPStrings.viewTimeline.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                  context.popAndPushNamed(AppRoutes.orderTimelinePage);
                }),
              },
              _buildPopupOption(context, text: APPStrings.cancelOrder.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                _showOrderCancelBottomSheet(bloc, context);
              }),
            ],
          ),
        );
      },
    );
  }

  void _showTrackOrderBottomSheet(OrderDetailBloc bloc, BuildContext context, String? appBarTitle) {
    context.pop();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) => BlocProvider<OrderDetailBloc>(
        create: (context) => OrderDetailBloc(),
        child: TrackOrderBottomSheet(appBarTitle: appBarTitle),
      ),
    );
  }

  void _showReturnProductBottomSheet(OrderDetailBloc bloc, BuildContext context) {
    context.pop();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) {
        return BlocProvider<OrderDetailBloc>(
          create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
          child: const ReturnOrderProductBottomSheet(),
        );
      },
    );
  }

  void _showOrderCancelBottomSheet(OrderDetailBloc bloc, BuildContext context) {
    context.pop();
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) {
        return BlocProvider<OrderDetailBloc>(
          create: (context) => OrderDetailBloc()..add(InitialOrderDetailEvent(context)),
          child: const OrderCancelBottomSheet(),
        );
      },
    );
  }

  Widget _buildPopupOption(
    BuildContext context, {
    required String text,
    required TextStyle style,
    EdgeInsetsGeometry? padding,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: AlignmentDirectional.centerStart,
        padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }
}

class _OrderDetailsInfoCard extends StatelessWidget {
  final OrderDetailScreenStyle style;
  final PlaceOrderResponse? placeOrderResponse;

  const _OrderDetailsInfoCard({required this.style, this.placeOrderResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.detailsTileColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((placeOrderResponse?.uniqueId).isNotNullNorEmpty) ...[
                      SmartText(
                        "#${placeOrderResponse?.uniqueId}",
                        style: style.orderIdStyle,
                      ),
                      SizedBox(height: 4.h),
                    ],
                    SmartRichText(
                      spans: [
                        SmartTextSpan(text: APPStrings.orderOn.tr, style: style.orderDateStyle),
                        SmartTextSpan(text: " : ", style: style.orderDateStyle),
                        SmartTextSpan(text: placeOrderResponse!.getOrderDate, style: style.orderDateStyle),
                      ],
                    ),
                  ],
                ),
              ),
              SmartImage(
                path: AppImages.icMenu,
                onTap: () {
                  // Handle menu tap
                },
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              _DetailColumn(
                title: APPStrings.status.tr,
                value: placeOrderResponse?.getOrderStatus?.value,
                style: style,
                isOrderStatus: true,
              ),
              _DetailColumn(
                title: APPStrings.items.tr,
                value: placeOrderResponse?.items?.toString(),
                style: style,
              ),
              _DetailColumn(
                title: APPStrings.qty.tr,
                value: placeOrderResponse?.totalQuantity?.toString(),
                style: style,
              ),
              _DetailColumn(
                title: APPStrings.totalAmount.tr,
                value: placeOrderResponse?.totalPrice?.setCurrency,
                style: style,
                totalAmount: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderCreatorDetailsCard extends StatelessWidget {
  final OrderDetailScreenStyle style;
  final OrderDetailBloc bloc;
  final PlaceOrderResponse? placeOrderResponse;

  const _OrderCreatorDetailsCard({required this.style, required this.bloc, required this.placeOrderResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Development pending form backend
          _CreatorDetailItem(
            title: APPStrings.createdBy.tr,
            iconImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
            value: "Michael Lee",
            style: style,
          ),
          SizedBox(height: 24.h),
          _CreatorDetailItem(
            title: APPStrings.contactInfo.tr,
            iconImage: AppImages.icMail,
            value: "business@domain.com",
            style: style,
          ),
          SizedBox(height: 12.h),
          _CreatorDetailItem(
            iconImage: AppImages.icPhone,
            value: "(406) 555-0120",
            style: style,
          ),
          SizedBox(height: 24.h),
          if ((placeOrderResponse?.billingAddressDetails?.fullAddress).isNotNullNorEmpty) ...[
            _CreatorDetailItem(
              title: APPStrings.billingAddress.tr,
              value: placeOrderResponse?.billingAddressDetails?.fullAddress,
              style: style,
            ),
            SizedBox(height: 12.h),
          ],
          if ((placeOrderResponse?.shippingAddressDetails?.fullAddress).isNotNullNorEmpty)
            _CreatorDetailItem(
              title: APPStrings.shippingAddress.tr,
              value: placeOrderResponse?.shippingAddressDetails?.fullAddress,
              style: style,
            ),
        ],
      ),
    );
  }
}

class _DetailColumn extends StatelessWidget {
  final String title;
  final String? value;
  final OrderDetailScreenStyle style;
  final bool isOrderStatus;
  final bool totalAmount;

  const _DetailColumn({
    required this.title,
    this.value,
    required this.style,
    this.isOrderStatus = false,
    this.totalAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.orderItemLabelStyle,
            ),
            SizedBox(height: 4.h),
            isOrderStatus
                ? SmartStatusBadge(
                    currentStatus: ProjectStatus.values.firstWhere((orderStatus) => orderStatus.value == value),
                  )
                : SmartText(
                    value.isNullOrEmpty ? APPStrings.dash.tr : value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: totalAmount ? style.orderTotalStyle : style.orderItemValueStyle,
                  ),
          ],
        ),
      ),
    );
  }
}

class _CreatorDetailItem extends StatelessWidget {
  final String? title;
  final String? value;
  final String? iconImage;
  final OrderDetailScreenStyle style;

  const _CreatorDetailItem({this.title, this.value, this.iconImage, required this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: SmartText(
            title,
            style: style.orderItemLabelStyle,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Row(
            children: [
              if (iconImage != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: SmartImage(
                      path: iconImage ?? '',
                      fit: BoxFit.fill,
                      height: 24.w,
                      width: 24.w,
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
}
