import 'package:kgk/kgk.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SavedAddressBloc savedAddressBloc = BlocProvider.of<SavedAddressBloc>(context);
    final SavedAddressStyle style = AppTheme.of(context).savedAddressStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.savedAddress.tr),
      body: _buildBody(style, savedAddressBloc),
    );
  }

  Widget _buildBody(SavedAddressStyle style, SavedAddressBloc savedAddressBloc) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 25.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SavedAddressWidget(
            isShippingAddress: true,
            addressDetails: savedAddressBloc.defaultShippingAddress ?? AddressDetails(),
            onChange: () {},
            onAddNew: () {},
          ),
          SizedBox(height: 24.h),
          SavedAddressWidget(
            addressDetails: savedAddressBloc.defaultBillingAddress ?? AddressDetails(),
            onChange: () {},
            onAddNew: () {},
            isSameAsShippingAddress: savedAddressBloc.isBillingAddressSameAsShippingAddress,
            onShippingAddressChange: (value) {
              if (value == true) {
                savedAddressBloc.add(SavedAddressChangeBillingAddressSameEvent(value!));
              }
            },
          ),
        ],
      ),
    );
  }
}
