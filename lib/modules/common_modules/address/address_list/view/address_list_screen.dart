import 'package:kgk/kgk.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressListBloc addressListBloc = BlocProvider.of<AddressListBloc>(context);
    final AddressListStyle style = AppTheme.of(context).addressListStyle;
    return Scaffold(
        appBar: SmartAppBar(title: APPStrings.checkout.tr),
        body: SafeArea(
          child: BlocBuilder<AddressListBloc, AddressListState>(
            buildWhen: (previous, current) => current is AddressListLoadedState,
            builder: (context, state) {
              if (state is! AddressListLoadedState) return const SizedBox.shrink();
              return SmartSingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CheckoutHeaderProgressbar(),
                    SizedBox(height: 22.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SmartText(APPStrings.shippingAddress.tr, style: style.addressTypeTitleStyle),
                          _buildShippingAddressList(addressListBloc, style),
                          SizedBox(height: 24.h),
                          const Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SelectionButton(
                                onTap: () {
                                  addressListBloc.add(AddNewAddressEvent(context));
                                },
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                isSelected: false,
                                title: APPStrings.addAddress.tr,
                                image: AppImages.icPlus,
                                selectedButtonBorderColor: style.whiteColor,
                                unselectedButtonBorderColor: style.whiteColor,
                              ),
                            ],
                          ),
                          const Divider(),
                          SizedBox(height: 24.h),
                          _buildIsBillingAddressSameAsSelected(addressListBloc, style),
                        ],
                      ),
                    ),
                    // Divider(color: style.backgroundColor, thickness: 8.h, height: 56.h),

                    /// Below line is commented as it is not required in the screen for now. The same is discussed in the meeting with JD.
                    /* Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          SmartExpansionTile(
                        key: addressListBloc.productsListExpansionKey,
                        initiallyExpanded: addressListBloc.isProductListExpanded,
                        title: SmartText(APPStrings.productX.tr.interpolate([addressListBloc.productList.length]),
                            style: style.nProductsTitleStyle),
                        trailing: BlocBuilder<AddressListBloc, AddressListState>(
                          buildWhen: (previous, current) => current is ChangeProductListExpansionState,
                          builder: (context, state) {
                            return SmartImage(
                                path: addressListBloc.isProductListExpanded ? AppImages.icArrowUp : AppImages.icArrowDown,
                                width: 24,
                                height: 24,
                                color: style.arrowColor);
                          },
                        ),
                        onExpansionChanged: (isExpanded) {
                          addressListBloc.add(const ChangeProductListExpansionEvent());
                        },
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: SmartGridView(
                                items: addressListBloc.productList.map((ProductDetails productDetails) {
                              return ProductGridItem(
                                productDetails: productDetails,
                                onEyeTap: () {},
                                onFavTap: () {},
                                onTap: () {
                                  context.pushNamed(AppRoutes.diamondDetailPage,
                                      arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondDetailForDefault});
                                },
                              );
                            }).toList()),
                          ),
                        ],
                      ),
                        ],
                      ),
                    ),*/
                    if (addressListBloc.bagOrderSummaryData != null)
                      _buildOrderSummary(
                        style: style,
                        context: context,
                        addressListBloc: addressListBloc,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartButton(
                  onTap: () {
                    // context.pushNamed(AppRoutes.paymentPage);
                    addressListBloc.add(ContinueToPaymentEvent(context: context));
                  },
                  title: APPStrings.strContinue.tr,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ));
  }

  Widget _buildShippingAddressList(AddressListBloc addressListBloc, AddressListStyle style) {
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is DeleteAddressState || current is AddNewAddressState,
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: addressListBloc.addressList.length,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            return BlocBuilder<AddressListBloc, AddressListState>(
              buildWhen: (previous, current) =>
                  current is ChangeSelectedAddressState && !current.isBilling && (current.index == index || current.oldIndex == index),
              builder: (context, state) {
                final AddressDetails address = addressListBloc.addressList[index];
                return AddressSelectionWidget(
                  address: address,
                  isDefault: address.isDefaultShipping,
                  onTap: () {
                    addressListBloc.add(ChangeSelectedAddressEvent(index));
                  },
                  groupValue: addressListBloc.selectedShippingAddress,
                  onEdit: () {
                    addressListBloc.add(EditAddressEvent(index, context));
                  },
                  onDelete: () {
                    Utils.showSmartModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                        ),
                        builder: (builderContext) => ConfirmationDialog(
                              title: APPStrings.deleteAddress.tr,
                              message: APPStrings.deleteAddressMsg.tr,
                              onApproved: () {
                                builderContext.pop();
                                addressListBloc.add(DeleteAddressEvent(context: context, index: index));
                              },
                              onDenied: () => builderContext.pop(),
                              onApprovedText: APPStrings.delete.tr,
                              onDeniedText: APPStrings.cancel.tr,
                            ));
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => Divider(height: 48.h),
        );
      },
    );
  }

  Widget _buildBillingAddressList(AddressListBloc addressListBloc, AddressListStyle style) {
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is DeleteAddressState || current is AddNewAddressState,
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: addressListBloc.addressList.length,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            return BlocBuilder<AddressListBloc, AddressListState>(
              buildWhen: (previous, current) =>
                  current is ChangeSelectedAddressState && current.isBilling && (current.index == index || current.oldIndex == index),
              builder: (context, state) {
                final AddressDetails address = addressListBloc.addressList[index];
                return AddressSelectionWidget(
                  address: address,
                  isDefault: address.isDefaultBilling,
                  onTap: () {
                    addressListBloc.add(ChangeSelectedAddressEvent(index, isBilling: true));
                  },
                  groupValue: addressListBloc.selectedBillingAddress,
                  onEdit: () {
                    addressListBloc.add(EditAddressEvent(index, context));
                  },
                  onDelete: () {
                    Utils.showSmartModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                        ),
                        builder: (builderContext) => ConfirmationDialog(
                              title: APPStrings.deleteAddress.tr,
                              message: APPStrings.deleteAddressMsg.tr,
                              onApproved: () {
                                builderContext.pop();
                                addressListBloc.add(DeleteAddressEvent(context: context, index: index));
                              },
                              onDenied: () => builderContext.pop(),
                              onApprovedText: APPStrings.delete.tr,
                              onDeniedText: APPStrings.cancel.tr,
                            ));
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => Divider(height: 48.h),
        );
      },
    );
  }

  Widget _buildIsBillingAddressSameAsSelected(AddressListBloc addressListBloc, AddressListStyle style) {
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is ToggleBillingAndShippingSameState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartCheckbox(
              value: addressListBloc.isBillingAndShippingSame,
              onChanged: (value) {
                addressListBloc.add(const ToggleBillingAndShippingSameEvent());
              },
              label: APPStrings.billingAddressSame.tr,
            ),
            SizedBox(height: 24.h),
            if (!addressListBloc.isBillingAndShippingSame) ...[
              Divider(height: 24.h),
              SmartText(APPStrings.billingAddress.tr, style: style.addressTypeTitleStyle),
              _buildBillingAddressList(addressListBloc, style),
            ],
          ],
        );
      },
    );
  }

  Widget _buildOrderSummary({
    required AddressListStyle style,
    required BuildContext context,
    required AddressListBloc addressListBloc,
  }) {
    addressListBloc.add(OrderSummaryDataRefreshEvent(context: context));
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is AddressListLoadedState,
      builder: (context, state) {
        return OrderSummary(
          onApplyPromoCode: () {},
          promoCode: addressListBloc.bagOrderSummaryData?.promoCode,
          items: List.generate(
            addressListBloc.bagOrderSummaryData?.charges.length ?? 0,
            (index) {
              BagOrderCharge? bagOrderCharge = addressListBloc.bagOrderSummaryData?.charges[index];
              return OrderSummaryItem(
                title: bagOrderCharge?.title ?? '',
                value: bagOrderCharge?.displayValue?.setCurrency ?? '',
              );
            },
          ).toList(),
          totalPrice: addressListBloc.bagOrderSummaryData?.totalAmount?.setCurrency ?? '',
          subTotalPrice: addressListBloc.bagOrderSummaryData?.subTotal?.setCurrency ?? '',
        );
      },
    );
  }
}
