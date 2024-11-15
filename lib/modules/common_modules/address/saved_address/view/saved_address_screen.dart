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

  Widget _buildBody(SavedAddressStyle style, SavedAddressBloc bloc, BuildContext context) {
    return BlocBuilder<SavedAddressBloc, SavedAddressState>(
      buildWhen: (previous, current) => current is SavedAddressLoadedState,
      builder: (context, state) {
        if (state is! SavedAddressLoadedState) {
          return const SizedBox.shrink();
        }
        return SmartSingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
          child: bloc.addressList.isEmpty
              ? NoDataFoundWidget(
                  text: APPStrings.noSavedAddressFound.tr,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SavedAddressWidget(
                      isShippingAddress: true,
                      addressDetails: bloc.defaultShippingAddress ?? AddressDetails(),
                      onChange: () {
                        bloc.add(SavedAddressChangeShippingAddressEvent(context, isShipping: true));
                      },
                      onAddNew: () {
                        bloc.add(SavedAddressAddNewAddressEvent(context, isShipping: true));
                      },
                    ),
                    SizedBox(height: 24.h),
                    SavedAddressWidget(
                      addressDetails: bloc.defaultBillingAddress ?? AddressDetails(),
                      onChange: () {
                        bloc.add(SavedAddressChangeShippingAddressEvent(context));
                      },
                      onAddNew: () {
                        bloc.add(SavedAddressAddNewAddressEvent(context));
                      },
                      isSameAsShippingAddress: bloc.isBillingAddressSameAsShippingAddress,
                      onShippingAddressChange: (value) {
                        if (value == true) {
                          bloc.add(SavedAddressChangeBillingAddressSameEvent(value!));
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
