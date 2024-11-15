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
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<AddAddressBloc, AddAddressState>(
          buildWhen: (previous, current) => current is AddAddressReloadState,
          builder: (context, state) {
            return SmartAppBar(
              title: bloc.isFromCheckout
                  ? APPStrings.checkout.tr
                  : bloc.isEditAddress
                      ? APPStrings.editAddress.tr
                      : APPStrings.addAddress.tr,
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AddAddressBloc, AddAddressState>(
            buildWhen: (previous, current) => current is AddAddressInitial,
            builder: (context, state) {
              return SmartSingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (bloc.isFromCheckout) ...[
                      const CheckoutHeaderProgressbar(),
                      _buildIsBillingAddressSameAsSelected(bloc, style),
                    ],
                    generateAddressForm(bloc, countryPickerStyle, context),
                  ],
                ),
              );
            }),
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
              if (value != null) {
                bloc.add(AddAddressAddressSameEvent(value));
              }
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
        padding: bloc.isFromCheckout ? EdgeInsets.symmetric(horizontal: 17.w) : EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
        child: Column(children: [
          _buildFirstNameField(bloc),
          SizedBox(height: 24.h),
          _buildLastNameField(bloc),
          SizedBox(height: 24.h),
          _buildApartmentField(bloc),
          SizedBox(height: 24.h),
          _buildStreetAddressField(bloc),
          SizedBox(height: 24.h),
          _buildCityField(bloc),
          SizedBox(height: 24.h),
          _buildStateField(bloc),
          SizedBox(height: 24.h),
          _buildCountryField(bloc, countryPickerStyle),
          SizedBox(height: 24.h),
          _buildZipCodeField(bloc),
          SizedBox(height: 24.h),
          _buildPhoneField(bloc, context, countryPickerStyle),
          SizedBox(height: 24.h),
          SmartButton(
            onTap: () {
              bloc.add(SaveAddressEvent(context));
            },
            title: APPStrings.save.tr,
          ),
          if (bloc.isFromCheckout) SizedBox(height: 24.h),
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
      nextFocus: bloc.apartmentFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildApartmentField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.apartmentSuite.tr,
      hintText: APPStrings.apartmentSuite.tr,
      controller: bloc.apartmentController,
      focusNode: bloc.apartmentFocusNode,
      nextFocus: bloc.streetAddressFocusNode,
      keyboardType: TextInputType.streetAddress,
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

  Widget _buildCityField(AddAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.city.tr,
      hintText: APPStrings.city.tr,
      controller: bloc.cityController,
      focusNode: bloc.cityFocusNode,
      nextFocus: bloc.stateFocusNode,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildStateField(AddAddressBloc bloc) {
    return BlocBuilder<AddAddressBloc, AddAddressState>(
      buildWhen: (previous, current) => current is AddAddressChangeStateState || current is AddAddressChangeCountryState,
      builder: (context, state) {
        return SmartDropDown<CountryStateModel>(
          hintText: APPStrings.state.tr,
          labelText: APPStrings.state.tr,
          items: bloc.arrState.map((CountryStateModel state) {
            return SmartDropDownItem<CountryStateModel>(value: state, title: state.name ?? '');
          }).toList(),
          onChanged: (state) {
            if (state != null) {
              bloc.add(AddAddressChangeStateEvent(context, state));
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
                  countryFilter: bloc.countryList.map((CountryStateModel country) => country.code ?? '').toList(),
                  onSelect: (Country country) {
                    bloc.add(AddAddressChangeCountryEvent(context: context, selectedCountry: country));
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
                        bloc.selectedCountry?.name,
                        style: countryPickerStyle.inputTextStyle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const SmartImage(path: AppImages.icArrowDropDown),
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

  Widget _buildPhoneField(AddAddressBloc bloc, BuildContext context, CountryPickerStyle countryPickerStyle) {
    return SmartTextField(
      labelText: APPStrings.phoneNumber.tr,
      hintText: APPStrings.phoneNumber.tr,
      controller: bloc.phoneController,
      focusNode: bloc.phoneFocusNode,
      keyboardType: TextInputType.number,
      prefixIcon: InkWell(
        onTap: bloc.isEditAddress
            ? null
            : () {
                Utils.showCountryPickerModel(
                  context: context,
                  countryPickerStyle: countryPickerStyle,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    bloc.add(AddAddressChangeCountryCodeEvent(country));
                  },
                );
              },
        child: SizedBox(
          width: 95.w,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppTheme.of(context).textFieldStyle.enabledTextFieldBorderColor,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AddAddressBloc, AddAddressState>(
                  buildWhen: (previous, current) => current is AddAddressChangeCountryCodeState,
                  builder: (context, state) {
                    return SmartText(
                      '+${bloc.selectedCountryCodes.phoneCode}',
                      style: AppTheme.of(context).textFieldStyle.textStyle,
                    );
                  },
                ),
                if (!bloc.isEditAddress) ...[
                  SizedBox(width: 4.w),
                  const SmartImage(path: AppImages.icArrowDropDown),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
