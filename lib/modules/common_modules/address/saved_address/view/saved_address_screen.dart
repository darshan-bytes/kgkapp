import 'package:kgk/kgk.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SavedAddressBloc savedAddressBloc = BlocProvider.of<SavedAddressBloc>(context);
    final SavedAddressStyle style = AppTheme.of(context).savedAddressStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.savedAddress.tr),
      body: _buildBody(style, savedAddressBloc, context),
    );
  }

  Widget _buildBody(SavedAddressStyle style, SavedAddressBloc savedAddressBloc, BuildContext context) {
    return BlocBuilder<SavedAddressBloc, SavedAddressState>(
      buildWhen: (previous, current) => current is SavedAddressLoadedState,
      builder: (context, state) {
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
                onChange: () {
                  savedAddressBloc.add(SavedAddressChangeShippingAddressEvent(context, isShipping: true));
                },
                onAddNew: () {
                  savedAddressBloc.add(SavedAddressAddNewAddressEvent(context, isShipping: true));
                },
              ),
              SizedBox(height: 24.h),
              SavedAddressWidget(
                addressDetails: savedAddressBloc.defaultBillingAddress ?? AddressDetails(),
                onChange: () {
                  savedAddressBloc.add(SavedAddressChangeShippingAddressEvent(context));
                },
                onAddNew: () {
                  savedAddressBloc.add(SavedAddressAddNewAddressEvent(context));
                },
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
      },
    );
  }
}
