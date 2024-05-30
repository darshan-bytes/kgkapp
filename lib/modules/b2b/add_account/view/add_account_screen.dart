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
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            height: 6.w,
            width: 6.w,
            decoration: BoxDecoration(color: style.filledDotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: SmartText(
              APPStrings.shippingBillingAddress.tr,
              style: style.shippingBillingAddressStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: DotIndicator(
              dotColor: bloc.isShippingAndBillingAddressFilled ? style.fillLineColor : style.dotColor,
            ),
          ),
          Container(
            height: 6.w,
            width: 6.w,
            decoration: BoxDecoration(
                color: bloc.isShippingAndBillingAddressFilled ? style.filledDotColor : style.dotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
          child: SmartCheckbox(
            height: 24.w,
            width: 24.w,
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
              _buildCountryField(bloc, countryPickerStyle, context),
              SizedBox(height: 24.h),
              _buildZipCodeField(bloc),
              SizedBox(height: 24.h),
              _buildPhoneField(bloc),
              SizedBox(height: 24.h),
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
        SizedBox(height: 4.h),
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
