import 'package:kgk/kgk.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAddressScreenStyle style = AppTheme.of(context).addAddressScreenStyle;
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    final AddAddressBloc bloc = BlocProvider.of<AddAddressBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(title: APPStrings.checkout.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CheckoutHeaderProgressbar(),
              _buildIsBillingAddressSameAsSelected(bloc, style),
              generateAddressForm(bloc, countryPickerStyle, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIsBillingAddressSameAsSelected(AddAddressBloc bloc, AddAddressScreenStyle style) {
    return BlocBuilder<AddAddressBloc, AddAddressState>(
      buildWhen: (previous, current) => current is AddAddressChangeAddressSameState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
          child: SmartCheckbox(
            height: 24.w,
            width: 24.w,
            value: bloc.isShippingAddressSame,
            onChanged: (value) {
              bloc.add(AddAddressAddressSameEvent(value));
            },
            label: APPStrings.billingAddressSame.tr,
            labelStyle: style.isSameAddressStyle,
          ),
        );
      },
    );
  }

  Widget generateAddressForm(AddAddressBloc bloc, CountryPickerStyle countryPickerStyle, BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Column(children: [
          _buildFirstNameField(bloc),
          SizedBox(height: 24.h),
          _buildLastNameField(bloc),
          SizedBox(height: 24.h),
          _buildStreetAddressField(bloc),
          SizedBox(height: 24.h),
          _buildApartmentField(bloc),
          SizedBox(height: 24.h),
          _buildCityField(bloc),
          SizedBox(height: 24.h),
          _buildStateField(bloc),
          SizedBox(height: 24.h),
          _buildCountryField(bloc, countryPickerStyle),
          SizedBox(height: 24.h),
          _buildZipCodeField(bloc),
          SizedBox(height: 24.h),
          _buildPhoneField(bloc),
          SizedBox(height: 24.h),
          SmartButton(
            onTap: () {
              bloc.add(SaveAddressEvent(context));
            },
            title: APPStrings.saveAddress.tr,
          ),
          SizedBox(height: 24.h),
        ]));
  }

  Widget _buildFirstNameField(AddAddressBloc bloc) {
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

  Widget _buildLastNameField(AddAddressBloc bloc) {
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

  Widget _buildStreetAddressField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.streetAddress.tr,
      hintText: APPStrings.streetAddress.tr,
      controller: bloc.streetAddressController,
      focusNode: bloc.streetAddressFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildApartmentField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.apartmentSuite.tr,
      controller: bloc.apartmentController,
      focusNode: bloc.apartmentFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildCityField(AddAddressBloc bloc) {
    return BlocBuilder<AddAddressBloc, AddAddressState>(
      buildWhen: (previous, current) => current is AddAddressChangeCityState,
      builder: (context, state) {
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
              bloc.add(AddAddressChangeCityEvent(city));
            }
          },
          selectedItem: bloc.selectedCity,
        );
      },
    );
  }

  Widget _buildStateField(AddAddressBloc bloc) {
    return BlocBuilder<AddAddressBloc, AddAddressState>(
      buildWhen: (previous, current) => current is AddAddressChangeStateState,
      builder: (context, state) {
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
              bloc.add(AddAddressChangeStateEvent(state));
            }
          },
          selectedItem: bloc.selectedState,
        );
      },
    );
  }

  Widget _buildCountryField(AddAddressBloc bloc, CountryPickerStyle countryPickerStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartText(
          APPStrings.country.tr,
          style: countryPickerStyle.inputLableStyle,
        ),
        SizedBox(height: 4.h),
        BlocBuilder<AddAddressBloc, AddAddressState>(
          buildWhen: (previous, current) => current is AddAddressChangeCountryState,
          builder: (context, state) {
            return InkWell(
              onTap: () {
                Utils.showCountryPickerModel(
                  context: context,
                  countryPickerStyle: countryPickerStyle,
                  onSelect: (Country country) {
                    bloc.add(AddAddressChangeCountryEvent(country));
                  },
                );
              },
              child: Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: countryPickerStyle.inputBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        bloc.selectedCountry.name,
                        style: countryPickerStyle.inputTextStyle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SmartImage(path: AppImages.icArrowDropDown),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildZipCodeField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.postalCode.tr,
      hintText: APPStrings.postalCode.tr,
      controller: bloc.zipCodeController,
      focusNode: bloc.zipCodeFocusNode,
      nextFocus: bloc.phoneFocusNode,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildPhoneField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.phoneNumber.tr,
      hintText: APPStrings.phoneNumber.tr,
      controller: bloc.phoneController,
      focusNode: bloc.phoneFocusNode,
      keyboardType: TextInputType.number,
    );
  }
}
