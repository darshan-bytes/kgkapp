import 'package:kgk/kgk.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAccountScreenStyle style =
        AppTheme.of(context).addAccountScreenStyle;
    final AddAccountBloc bloc = BlocProvider.of<AddAccountBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: bloc.addAccountAppbarTitle,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AddAccountBloc, AddAccountState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Here GestureDetector is used to trigger state change and temporarily use it for testing
                  GestureDetector(
                      onTap: () {
                        context.read<AddAccountBloc>().add(
                            AddAccountAddressChangeEvent(
                                !bloc.isShippingAndBillingAddressFilled));
                      },
                      child: _buildShippingBillingAddress(bloc, style)),
                  _buildIsBillingAddressSameAsSelected(bloc, style),
                  // Padding(padding: const EdgeInsets.symmetric(horizontal: 17)),
                  generateAddressForm(bloc),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShippingBillingAddress(
      AddAccountBloc bloc, AddAccountScreenStyle style) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: style.borderColor))),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      child: Row(
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(
                color: style.filledDotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: SmartText(
              APPStrings.shippingBillingAddress.tr,
              style: style.shippingBillingAddressStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SmartImage(
              path: AppImages.icLineBlank,
              color: bloc.isShippingAndBillingAddressFilled
                  ? style.fillLineColor
                  : style.dotColor,
            ),
          ),
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(
                color: bloc.isShippingAndBillingAddressFilled
                    ? style.filledDotColor
                    : style.dotColor,
                shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          SmartText(APPStrings.payment.tr,
              style: bloc.isShippingAndBillingAddressFilled
                  ? style.shippingBillingAddressStyle
                  : style.paymentStyle),
        ],
      ),
    );
  }

  Widget _buildIsBillingAddressSameAsSelected(
      AddAccountBloc bloc, AddAccountScreenStyle style) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) =>
          current is AddAccountChangeAddressSameState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
          child: SmartCheckbox(
            height: 24,
            width: 24,
            value: bloc.isShippingAddressSame,
            onChanged: (value) {
              bloc.add(AddAccountAddressSameEvent(value));
            },
            label: APPStrings.billingAddressSame.tr,
            labelStyle: style.isSameAddressStyle,
          ),
        );
      },
    );
  }

  Widget generateAddressForm(AddAccountBloc bloc) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(children: [
          _buildFirstNameField(bloc),
          const SizedBox(height: 24),
          _buildLastNameField(bloc),
          const SizedBox(height: 24),
          _buildStreetAddressField(bloc),
          const SizedBox(height: 24),
          _buildApartmentField(bloc),
          const SizedBox(height: 24),
          _buildCityField(bloc),
          const SizedBox(height: 24),
          _buildStateField(bloc),
          const SizedBox(height: 24),
          _buildCountryField(bloc),
          const SizedBox(height: 24),
          _buildZipCodeField(bloc),
          const SizedBox(height: 24),
          _buildPhoneField(bloc),
          const SizedBox(height: 24),
          SmartButton(
            onTap: () {},
            title: APPStrings.saveAddress.tr,
          ),
          const SizedBox(height: 24),
        ]));
  }

  Widget _buildFirstNameField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.firstName.tr,
      hintText: APPStrings.firstName.tr,
      controller: bloc.firstNameController,
      focusNode: bloc.firstNameFocusNode,
      nextFocus: bloc.lastNameFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildLastNameField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.lastName.tr,
      hintText: APPStrings.lastName.tr,
      controller: bloc.lastNameController,
      focusNode: bloc.lastNameFocusNode,
      nextFocus: bloc.streetAddressFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildStreetAddressField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.streetAddress.tr,
      hintText: APPStrings.streetAddress.tr,
      controller: bloc.streetAddressController,
      focusNode: bloc.streetAddressFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildApartmentField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.apartmentSuite.tr,
      controller: bloc.apartmentController,
      focusNode: bloc.apartmentFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildCityField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.city.tr,
      hintText: APPStrings.city.tr,
      controller: bloc.cityController,
      focusNode: bloc.cityFocusNode,
      nextFocus: bloc.stateFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildStateField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.state.tr,
      hintText: APPStrings.state.tr,
      controller: bloc.stateController,
      focusNode: bloc.stateFocusNode,
      nextFocus: bloc.zipCodeFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildZipCodeField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.postalCode.tr,
      hintText: APPStrings.postalCode.tr,
      controller: bloc.zipCodeController,
      focusNode: bloc.zipCodeFocusNode,
      nextFocus: bloc.phoneFocusNode,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildPhoneField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.phoneNumber.tr,
      hintText: APPStrings.phoneNumber.tr,
      controller: bloc.phoneController,
      focusNode: bloc.phoneFocusNode,
      keyboardType: TextInputType.phone,
    );
  }
  
  Widget _buildCountryField(AddAccountBloc bloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpChangeCountryState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartText(
              APPStrings.country.tr,
              style: AppTheme.of(context).textFieldStyle.labelStyle,
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    // bloc.add(SignUpChangeCountryEvent(country));
                  },
                );
              },
              child: Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.of(context)
                        .textFieldStyle
                        .enabledTextFieldBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        bloc.selectedCountry.name,
                        style: AppTheme.of(context).textFieldStyle.textStyle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const SmartImage(path: AppImages.icArrowDown),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
