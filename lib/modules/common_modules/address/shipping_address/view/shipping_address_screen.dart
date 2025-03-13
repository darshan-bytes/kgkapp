import 'package:kgk/kgk.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShippingAddressBloc shippingAddressBloc = BlocProvider.of<ShippingAddressBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(shippingAddressBloc, context),
      body: _buildBody(shippingAddressBloc),
      bottomNavigationBar: _buildBottomNavigationBar(shippingAddressBloc, context),
    );
  }

  PreferredSizeWidget _buildAppBar(ShippingAddressBloc shippingAddressBloc, BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
        buildWhen: (previous, current) => current is ShippingAddressLoadedState,
        builder: (context, state) {
          if (state is ShippingAddressLoadedState) {
            return SmartAppBar(title: shippingAddressBloc.title);
          } else {
            return SmartAppBar(title: '');
          }
        },
      ),
    );
  }

  Widget _buildBody(ShippingAddressBloc shippingAddressBloc) {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
      buildWhen: (previous, current) => current is ShippingAddressLoadedState,
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 24.h),
          itemCount: shippingAddressBloc.addressList.length,
          itemBuilder: (context, index) {
            return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
              buildWhen: (previous, current) =>
                  current is ChangeSelectedShippingAddressState && (current.newIndex == index || current.oldIndex == index),
              builder: (context, state) {
                final AddressDetails address = shippingAddressBloc.addressList[index];
                return AddressSelectionWidget(
                  address: address,
                  groupValue: shippingAddressBloc.selectedAddress,
                  isDefault: address == shippingAddressBloc.defaultAddress,
                  onTap: () {
                    shippingAddressBloc.add(ChangeSelectedShippingAddressEvent(index));
                  },
                  onEdit: () {
                    shippingAddressBloc.add(EditShippingAddressEvent(index, context));
                  },
                  onDelete: () {
                    Utils.showSmartModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
                        ),
                        builder: (builderContext) => ConfirmationDialog(
                              title: APPStrings.deleteAddress.tr,
                              message: APPStrings.deleteAddressMsg.tr,
                              onApproved: () {
                                builderContext.pop();
                                shippingAddressBloc.add(DeleteShippingAddressEvent(context: context, index: index));
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

  Widget _buildBottomNavigationBar(ShippingAddressBloc shippingAddressBloc, BuildContext context) {
    final SavedAddressStyle style = AppTheme.of(context).savedAddressStyle;

    return Container(
      decoration: BoxDecoration(
        color: style.whiteColor,
        boxShadow: [style.boxShadow],
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SmartButton(
                onTap: () {
                  shippingAddressBloc.add(AddShippingAddressEvent(context));
                },
                title: APPStrings.add.tr,
                activeBackgroundColor: style.whiteColor,
                titleStyle: style.addressNameStyle,
                prefixImage: AppImages.icPlus,
                activeImageColor: style.primaryColor,
              ),
            ),
            Expanded(
              child: SmartButton(
                onTap: () {
                  shippingAddressBloc.add(SaveShippingAddressEvent(context));
                },
                title: APPStrings.save.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
