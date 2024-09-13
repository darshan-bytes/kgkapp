import 'package:kgk/kgk.dart';
import 'package:kgk/modules/common_modules/order_management/order_details/view/return_order_product_bottomsheet.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc bloc = BlocProvider.of<OrderDetailBloc>(context);
    final OrderDetailScreenStyle style = AppTheme.of(context).orderDetailScreenStyle;

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.myOrders.tr),
      body: _getBody(bloc, style, context),
    );
  }

  Widget _getBody(OrderDetailBloc bloc, OrderDetailScreenStyle style, BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) => current is OrderDetailsLoadedState,
      builder: (context, state) {
        if (state is OrderDetailsLoadedState) {
          return SafeArea(
            child: SmartSingleChildScrollView(
              controller: bloc.paginationScrollController.controller,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderDetailsInfoCard(bloc, style, context),
                  SizedBox(height: 24.h),
                  _buildSearchTextField(bloc),
                  SizedBox(height: 24.h),
                  _buildOrderList(bloc, style),
                  BlocBuilder<OrderDetailBloc, OrderDetailState>(
                    buildWhen: (previous, current) =>
                        current is OrderDetailsLoadedMoreProductsState || current is OrderDetailsLoadingMoreProductsState,
                    builder: (context, state) {
                      return state is OrderDetailsLoadedMoreProductsState && state.currentPage > 3
                          ? _buildOrderCreatorDetailsInfoCard(style, bloc)
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const SmartCircularProgressIndicator();
      },
    );
  }

  Widget _buildOrderDetailsInfoCard(OrderDetailBloc bloc, OrderDetailScreenStyle style, BuildContext context) {
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
                  _showOrderDetailPopup(bloc, context);
                },
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDetailColumn(APPStrings.status.tr, ProjectStatus.active.value, style, isOrderStatus: true)),
              Expanded(child: _buildDetailColumn(APPStrings.items.tr, "15", style)),
              Expanded(child: _buildDetailColumn(APPStrings.qty.tr, "250  ", style)),
              Expanded(child: _buildDetailColumn(APPStrings.totalAmount.tr, "\$1,12,500", style, totalAmount: true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCreatorDetailsInfoCard(
    OrderDetailScreenStyle style,
    OrderDetailBloc bloc,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(APPStrings.cancelItemList.tr, style: style.orderIdStyle),
          SizedBox(
            height: 22.h,
          ),
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (bloc.userType == UserType.b2cUser) {
                late ProductDetailsModel product;
                if (bloc.userType == UserType.b2cUser) {
                  product = bloc.orderProductList[index];
                }
                return CartProductItem(
                  boxHeight: 72.w,
                  boxWidth: 72.w,
                  isDropDownEnable: false,
                  isCheckboxShow: false,
                  selectedQuality: product.productQuality,
                  selectedQuantity: product.productQuantity,
                  onRemoveTap: () {
                    bloc.add(OrderDetailRemoveProductEvent(index: index));
                  },
                  onMoveToWishListTap: () {},
                  productDetails: product,
                  qualityOptionsList: product.cartProductQuality ?? [],
                  quantityOptionsList: product.cartProductQuantity ?? [],
                  onQualityChanged: (CartProductQuality value) {
                    bloc.add(OrderDetailChangeProductQuality(index: index, productQuality: value));
                  },
                  onQuantityChanged: (CartProductQuantity value) {
                    bloc.add(OrderDetailChangeProductQuantity(index: index, productQuantity: value));
                  },
                  priceTextStyle: style.priceTextStyle,
                );
              } else {
                return OrderDetailsProductItem(
                  productDetails: bloc.orderProductDetailsList[index],
                  onTap: () {},
                );
              }
            },
            separatorBuilder: (context, index) => SizedBox(height: 24.h),
          ),
          SizedBox(
            height: 32.h,
          ),
          _buildCreatorDetailItem(
              title: APPStrings.createdBy.tr,
              iconImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
              value: "Michael Lee",
              style: style),
          SizedBox(height: 24.h),
          _buildCreatorDetailItem(
              title: APPStrings.contactInfo.tr, iconImage: AppImages.icMail, value: "business@domain.com", style: style),
          SizedBox(height: 12.h),
          _buildCreatorDetailItem(iconImage: AppImages.icPhone, value: "(406) 555-0120", style: style),
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

  Widget _buildSearchTextField(OrderDetailBloc bloc) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Row(
        children: [
          Expanded(
            child: SmartTextField.search(
              height: 48.h,
              hintText: APPStrings.searchOrder.tr,
              controller: bloc.orderSearchController,
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

  Widget _buildOrderList(OrderDetailBloc bloc, OrderDetailScreenStyle style) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) =>
          current is OrderDetailProductRemovedState ||
          current is OrderDetailsLoadedState ||
          current is OrderDetailsLoadingMoreProductsState ||
          current is OrderDetailsLoadedMoreProductsState,
      builder: (context, state) {
        return ListView.separated(
          itemCount: bloc.productListLength,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          itemBuilder: (context, index) {
            late ProductDetailsModel product;
            if (bloc.userType == UserType.b2cUser) {
              product = bloc.orderProductList[index];
            }
            return Column(
              children: [
                (bloc.userType == UserType.b2cUser)
                    ? CartProductItem(
                        boxHeight: 72.w,
                        boxWidth: 72.w,
                        isDropDownEnable: false,
                        isCheckboxShow: false,
                        selectedQuality: product.productQuality,
                        selectedQuantity: product.productQuantity,
                        onDeleteTap: () {},
                        onRemoveTap: () {
                          bloc.add(OrderDetailRemoveProductEvent(index: index));
                        },
                        onMoveToWishListTap: () {},
                        productDetails: product,
                        qualityOptionsList: product.cartProductQuality ?? [],
                        quantityOptionsList: product.cartProductQuantity ?? [],
                        onQualityChanged: (CartProductQuality value) {
                          bloc.add(OrderDetailChangeProductQuality(index: index, productQuality: value));
                        },
                        onQuantityChanged: (CartProductQuantity value) {
                          bloc.add(OrderDetailChangeProductQuantity(index: index, productQuantity: value));
                        },
                        priceTextStyle: style.priceTextStyle,
                      )
                    : OrderDetailsProductItem(
                        productDetails: bloc.orderProductDetailsList[index],
                        onTap: () {},
                        onTapMenuButton: () {},
                      ),
                if (state is OrderDetailsLoadingMoreProductsState && index == bloc.productListLength - 1)
                  const SmartCircularProgressIndicator(),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 24.h),
        );
      },
    );
  }

  Widget _buildDetailColumn(String title, String? value, OrderDetailScreenStyle style,
      {bool isOrderStatus = false, bool totalAmount = false}) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
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

  void _showOrderDetailPopup(OrderDetailBloc bloc, BuildContext context) {
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
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
    EdgeInsets? padding,
    required VoidCallback onTap,
  }) {
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
}
