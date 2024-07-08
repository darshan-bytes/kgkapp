import 'package:kgk/kgk.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc orderDetailBloc = BlocProvider.of<OrderDetailBloc>(context);
    final OrderDetailScreenStyle style = AppTheme.of(context).orderDetailScreenStyle;

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.myOrders.tr),
      body: _getBody(orderDetailBloc, style, context),
    );
  }

  Widget _getBody(OrderDetailBloc orderDetailBloc, OrderDetailScreenStyle style, BuildContext context) {
    return SafeArea(
      child: SmartSingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderDetailsInfoCard(style, context),
            SizedBox(height: 24.h),
            _buildOrderCreatorDetailsInfoCard(style),
            SizedBox(height: 32.h),
            _buildSearchTextField(orderDetailBloc),
            SizedBox(height: 24.h),
            _buildOrderList(orderDetailBloc, style),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsInfoCard(OrderDetailScreenStyle style, BuildContext context) {
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
                  _showOrderDetailPopup(context);
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

  Widget _buildOrderCreatorDetailsInfoCard(OrderDetailScreenStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  Widget _buildSearchTextField(OrderDetailBloc orderDetailBloc) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) => current is OrderDetailReloadState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: Row(
            children: [
              Expanded(
                child: SmartTextField.search(
                  height: 48.h,
                  onValueChanges: (value) => orderDetailBloc.add(const FilterOrdersEvent()),
                  onFieldSubmitted: (value) => orderDetailBloc.add(const FilterOrdersEvent()),
                  hintText: APPStrings.searchOrder.tr,
                  controller: orderDetailBloc.orderSearchController,
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
      },
    );
  }

  Widget _buildOrderList(OrderDetailBloc orderDetailBloc, OrderDetailScreenStyle style) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) =>
          current is OrderDetailProductQualityChangedState ||
          current is OrderDetailProductQuantityChangedState ||
          current is OrderDetailProductRemovedState ||
          current is FilterOrdersState ||
          current is OrderDetailReloadState,
      builder: (context, state) {
        return ListView.separated(
          itemCount: orderDetailBloc.filteredOrdersDetailsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          itemBuilder: (context, index) {
            ProductDetails product = orderDetailBloc.filteredOrdersDetailsList[index];
            switch (orderDetailBloc.screenIdentifier) {
              case ScreenIdentifier.orderDetailsForMyOrder:
                return CartProductItem(
                  boxHeight: 72.w,
                  boxWidth: 72.w,
                  isCheckboxShow: false,
                  selectedQuality: product.productQuality,
                  selectedQuantity: product.productQuantity,
                  onRemoveTap: () {
                    orderDetailBloc.add(OrderDetailRemoveProductEvent(index: index));
                  },
                  onMoveToWishListTap: () {},
                  productDetails: product,
                  qualityOptionsList: product.cartProductQuality ?? [],
                  quantityOptionsList: product.cartProductQuantity ?? [],
                  onQualityChanged: (CartProductQuality value) {
                    orderDetailBloc.add(OrderDetailChangeProductQuality(index: index, productQuality: value));
                  },
                  onQuantityChanged: (CartProductQuantity value) {
                    orderDetailBloc.add(OrderDetailChangeProductQuantity(index: index, productQuantity: value));
                  },
                  priceTextStyle: style.priceTextStyle,
                );

              case ScreenIdentifier.orderDetailsForRetailer:
                ProductInfoItem(
                    onTap360View: () => printWrapped("onTap360View"),
                    onTapDNA: () => printWrapped("onTapDNA"),
                    onTapCertificate: () => printWrapped("onTapCertificate"),
                    onTapImageViewer: () => printWrapped("onTapImageViewer"),
                    onTapUSA: () => printWrapped("onTapUSA"),
                    onTapMenuButton: () {
                      Utils.showSmartModalBottomSheet(
                        context: context,
                        builder: (context) => const ProductMenuBottomSheet(),
                      );
                    },
                    isSelectedBackground: (index % 2 != 0),
                    onTap: () {
                      context.pushNamed(AppRoutes.productDetailsPage,
                          arguments: {RoutesData.isPageFor: ScreenIdentifier.orderDetailsForRetailer});
                    },
                    productDetails: ProductDetails(
                      productInfoClarityChat: ProductInfoClarityChat(
                          rapRate: "\$35,500.00",
                          productId: "1",
                          productName: "1.00 Cts Round Diamond",
                          ct: "10.04",
                          shape: "Marquise",
                          colour: "H",
                          clarity: "VVS1",
                          lotNumber: "MBFG716306",
                          certificateNumber: "230000066395",
                          measurements: "10.18 x 8.34 x 6.14",
                          lab: "GIA",
                          cut: "Excellent",
                          polish: "Excellent",
                          symmetry: "Excellent",
                          flourish: "O",
                          tablePercentage: "50",
                          depthPercentage: "50",
                          rap: "\$24,850.00",
                          discount: "-30.00",
                          perCts: "\$24,850.00",
                          amount: "\$1,24,995.50",
                          fluorescence: '0'),
                      productId: "1",
                      diamond: "1.5 gram",
                      gram: "1.5 gram",
                      imageUrl: "https://i.ibb.co/swb5gVs/Round.png",
                    ));

              case ScreenIdentifier.orderDetailsForManufacturer:
                return CartProductItem(
                  boxHeight: 72.w,
                  boxWidth: 72.w,
                  isCheckboxShow: false,
                  selectedQuality: product.productQuality,
                  selectedQuantity: product.productQuantity,
                  onRemoveTap: () {
                    orderDetailBloc.add(OrderDetailRemoveProductEvent(index: index));
                  },
                  onMoveToWishListTap: () {},
                  productDetails: product,
                  qualityOptionsList: product.cartProductQuality ?? [],
                  quantityOptionsList: product.cartProductQuantity ?? [],
                  onQualityChanged: (CartProductQuality value) {
                    orderDetailBloc.add(OrderDetailChangeProductQuality(index: index, productQuality: value));
                  },
                  onQuantityChanged: (CartProductQuantity value) {
                    orderDetailBloc.add(OrderDetailChangeProductQuantity(index: index, productQuantity: value));
                  },
                  priceTextStyle: style.priceTextStyle,
                );
              default:
                break;
            }
            return CartProductItem(
              boxHeight: 72.w,
              boxWidth: 72.w,
              isCheckboxShow: false,
              selectedQuality: product.productQuality,
              selectedQuantity: product.productQuantity,
              onRemoveTap: () {
                orderDetailBloc.add(OrderDetailRemoveProductEvent(index: index));
              },
              onMoveToWishListTap: () {},
              productDetails: product,
              qualityOptionsList: product.cartProductQuality ?? [],
              quantityOptionsList: product.cartProductQuantity ?? [],
              onQualityChanged: (CartProductQuality value) {
                orderDetailBloc.add(OrderDetailChangeProductQuality(index: index, productQuality: value));
              },
              onQuantityChanged: (CartProductQuantity value) {
                orderDetailBloc.add(OrderDetailChangeProductQuantity(index: index, productQuantity: value));
              },
              priceTextStyle: style.priceTextStyle,
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

  void _showOrderDetailPopup(BuildContext context) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(context).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              color: orderPopupStyle.whiteColor,
            ),
            height: 220.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPopupOption(context, text: APPStrings.trackOrder.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                    context.pop();
                    Utils.showSmartModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                      ),
                      builder: (context) => BlocProvider<OrderDetailBloc>(
                        create: (context) => OrderDetailBloc(),
                        child: const TrackOrderBottomSheet(),
                      ),
                    );
                  }),
                  _buildPopupOption(context, text: APPStrings.viewTimeline.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                    context.popAndPushNamed(AppRoutes.orderTimelinePage);
                  }),
                  _buildPopupOption(context, text: APPStrings.cancelOrder.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                    context.pop();
                    Utils.showSmartModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                      ),
                      builder: (context) {
                        return BlocProvider<OrderDetailBloc>(
                          create: (context) => OrderDetailBloc(),
                          child: const OrderCancelBottomSheet(),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        });
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
