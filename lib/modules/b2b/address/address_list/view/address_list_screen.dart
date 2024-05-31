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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CheckoutHeaderProgressbar(),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildAddressList(addressListBloc, style),
                      const Divider(height: 48),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectionButton(
                            onTap: () {
                              addressListBloc.add(AddNewAddressEvent(context));
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            isSelected: false,
                            title: APPStrings.addAddress.tr,
                            image: AppImages.icPlus,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: style.backgroundColor, thickness: 8, height: 56),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _buildIsBillingAddressSameAsSelected(addressListBloc, style),
                      SmartExpansionTile(
                        key: addressListBloc.productsListExpansionKey,
                        initiallyExpanded: addressListBloc.isProductListExpanded,
                        title: SmartText(
                          APPStrings.productX.tr.interpolate([addressListBloc.productList.length]),
                          style: style.nProductsTitleStyle,
                        ),
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
                                  context.pushNamed(AppRoutes.diamondDetailPage);
                                },
                              );
                            }).toList()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildOrderSummary()
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartButton(
                  onTap: () {},
                  title: APPStrings.saveAddress.tr,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }

  Widget _buildAddressList(AddressListBloc addressListBloc, AddressListStyle style) {
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is DeleteAddressState || current is AddNewAddressState,
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: addressListBloc.addressList.length,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            return BlocBuilder<AddressListBloc, AddressListState>(
              buildWhen: (previous, current) =>
                  current is ChangeSelectedAddressState && (current.index == index || current.oldIndex == index),
              builder: (context, state) {
                final AddressDetails address = addressListBloc.addressList[index];
                return AddressSelectionWidget(
                  address: address,
                  onTap: () {
                    addressListBloc.add(ChangeSelectedAddressEvent(index));
                  },
                  groupValue: addressListBloc.selectedAddress,
                  onEdit: () {
                    addressListBloc.add(EditAddressEvent(index));
                  },
                  onDelete: () {
                    addressListBloc.add(DeleteAddressEvent(index));
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 48),
        );
      },
    );
  }

  Widget _buildIsBillingAddressSameAsSelected(AddressListBloc addressListBloc, AddressListStyle style) {
    return BlocBuilder<AddressListBloc, AddressListState>(
      buildWhen: (previous, current) => current is ToggleBillingAndShippingSameState,
      builder: (context, state) {
        return SmartCheckbox(
          height: 24,
          width: 24,
          value: addressListBloc.isBillingAndShippingSame,
          onChanged: (value) {
            addressListBloc.add(const ToggleBillingAndShippingSameEvent());
          },
          label: APPStrings.billingAddressSame.tr,
          labelStyle: style.isSameAddressStyle,
        );
      },
    );
  }

  Widget _buildOrderSummary() {
    return OrderSummary(
      title: APPStrings.priceDetails.tr,
      titleStyle: const TextStyle(fontSize: 24),
      isPromoCodeApplied: false,
      items: [
        // Here String come from API
        OrderSummaryItem(title: APPStrings.subtotal.tr, value: "\$11,950.00"),
        OrderSummaryItem(title: APPStrings.shipping.tr, value: "\$0.00"),
        OrderSummaryItem(title: APPStrings.salesTax.tr, value: "\$0.00"),
      ],
      totalPrice: "\$35,700.00",
    );
  }
}
