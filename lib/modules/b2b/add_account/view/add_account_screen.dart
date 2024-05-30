import 'package:kgk/kgk.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAccountScreenStyle style = AppTheme.of(context).addAccountScreenStyle;
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Here GestureDetector is used to trigger state change and temporarily use it for testing
                  GestureDetector(
                      onTap: () {
                        bloc.add(AddAccountAddressChangeEvent(!bloc.isShippingAndBillingAddressFilled));
                      },
                      child: _buildShippingBillingAddress(bloc, style)),
                  _buildIsBillingAddressSameAsSelected(bloc, style),
                  generateAddressForm(bloc, countryPickerStyle),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShippingBillingAddress(AddAccountBloc bloc, AddAccountScreenStyle style) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: style.borderColor))),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      child: Row(
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
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
            child: DotIndicator(
              dotColor: bloc.isShippingAndBillingAddressFilled ? style.fillLineColor : style.dotColor,
            ),
          ),
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(
                color: bloc.isShippingAndBillingAddressFilled ? style.filledDotColor : style.dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          SmartText(APPStrings.payment.tr,
              style: bloc.isShippingAndBillingAddressFilled ? style.shippingBillingAddressStyle : style.paymentStyle),
        ],
      ),
    );
  }

  Widget _buildIsBillingAddressSameAsSelected(AddAccountBloc bloc, AddAccountScreenStyle style) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) => current is AddAccountChangeAddressSameState,
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

  Widget generateAddressForm(AddAccountBloc bloc, CountryPickerStyle countryPickerStyle) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) =>
          current is AddAccountChangeCityState || current is AddAccountChangeStateState || current is AddAccountChangeCountryState,
      builder: (context, state) {
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
              _buildCountryField(bloc, countryPickerStyle, context),
              const SizedBox(height: 24),
              _buildZipCodeField(bloc),
              const SizedBox(height: 24),
              _buildPhoneField(bloc),
              const SizedBox(height: 24),
              SmartButton(
                onTap: () {},
                title: APPStrings.saveAddress.tr,
              ),
            ]));
      },
    );
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
    return SmartDropDown<City>(
      hintText: APPStrings.city.tr,
      labelText: APPStrings.city.tr,
      items: bloc.arrCity.map((City city) {
        return SmartDropDownItem<City>(
          value: city,
          title: city.name,
        );
      }).toList(),
      onChanged: (city) {
        if (city != null) {
          bloc.add(AddAccountChangeCityEvent(city));
        }
      },
      selectedItem: bloc.selectedCity,
    );
  }

  Widget _buildStateField(AddAccountBloc bloc) {
    return SmartDropDown<StateModel>(
      hintText: APPStrings.state.tr,
      labelText: APPStrings.state.tr,
      items: bloc.arrState.map((StateModel state) {
        return SmartDropDownItem<StateModel>(
          value: state,
          title: state.name,
        );
      }).toList(),
      onChanged: (state) {
        if (state != null) {
          bloc.add(AddAccountChangeStateEvent(state));
        }
      },
      selectedItem: bloc.selectedState,
    );
  }

  Widget _buildCountryField(AddAccountBloc bloc, CountryPickerStyle countryPickerStyle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartText(
          APPStrings.country.tr,
          style: countryPickerStyle.inputLableStyle,
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            Utils.showCountryPickerModel(
              context: context,
              countryPickerStyle: countryPickerStyle,
              onSelect: (Country country) {
                bloc.add(AddAccountChangeCountryEvent(country));
              },
            );
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: countryPickerStyle.inputBorderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SmartText(
                    bloc.selectedCountry.name,
                    style: countryPickerStyle.inputTextStyle,
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
  }

  Widget _buildZipCodeField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.postalCode.tr,
      hintText: APPStrings.postalCode.tr,
      controller: bloc.zipCodeController,
      focusNode: bloc.zipCodeFocusNode,
      nextFocus: bloc.phoneFocusNode,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildPhoneField(AddAccountBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.phoneNumber.tr,
      hintText: APPStrings.phoneNumber.tr,
      controller: bloc.phoneController,
      focusNode: bloc.phoneFocusNode,
      keyboardType: TextInputType.number,
    );
  }
}
