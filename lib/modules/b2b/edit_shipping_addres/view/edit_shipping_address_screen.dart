import 'package:kgk/kgk.dart';

class EditShippingAddressScreen extends StatelessWidget {
  const EditShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAddressScreenStyle style = AppTheme.of(context).addAddressScreenStyle;
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    final EditShippingAddressBloc bloc = BlocProvider.of<EditShippingAddressBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(title: APPStrings.editAddress.tr),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               SizedBox(height: 16.0.h),
              generateAddressForm(bloc, countryPickerStyle, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateAddressForm(EditShippingAddressBloc bloc, CountryPickerStyle countryPickerStyle, BuildContext context) {

   final AddAddressScreenStyle style = AppTheme.of(context).addAddressScreenStyle;

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
          _buildZipCodeField(bloc),
          SizedBox(height: 24.h),
          _buildPhoneField(bloc),
          SizedBox(height: 7.h),
         _buildIsBillingAddressSameAsSelected(bloc, style) ,
          SizedBox(height: 10.h),
          SmartButton(
            onTap: () {
              bloc.add(SaveEditShippingAddressEvent(context));
            },
            title: APPStrings.save.tr,
          ),
          SizedBox(height: 24.h),
        ]));
  }

Widget _buildFirstNameField(EditShippingAddressBloc bloc) {
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

  Widget _buildLastNameField(EditShippingAddressBloc bloc) {
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

  Widget _buildStreetAddressField(EditShippingAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.streetAddress.tr,
      hintText: APPStrings.streetAddress.tr,
      controller: bloc.streetAddressController,
      focusNode: bloc.streetAddressFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildApartmentField(EditShippingAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.apartmentSuite.tr,
      hintText: APPStrings.apartmentSuite.tr,
      controller: bloc.apartmentController,
      focusNode: bloc.apartmentFocusNode,
      nextFocus: bloc.cityFocusNode,
      keyboardType: TextInputType.streetAddress,
    );
  }

  Widget _buildCityField(EditShippingAddressBloc bloc) {
    return BlocBuilder<EditShippingAddressBloc, EditShippingAddressState>(
      buildWhen: (previous, current) => current is EditShippingAddressChangeCityState,
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
              bloc.add(EditShippingAddressChangeCityEvent(city));
            }
          },
          selectedItem: bloc.selectedCity,
        );
      },
    );
  }

  Widget _buildStateField(EditShippingAddressBloc bloc) {
    return BlocBuilder<EditShippingAddressBloc, EditShippingAddressState>(
      buildWhen: (previous, current) => current is EditShippingAddressChangeStateState,
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
              bloc.add(EditShippingAddressChangeStateEvent(state));
            }
          },
          selectedItem: bloc.selectedState,
        );
      },
    );
  }

  Widget _buildZipCodeField(EditShippingAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.postalCode.tr,
      hintText: APPStrings.postalCode.tr,
      controller: bloc.zipCodeController,
      focusNode: bloc.zipCodeFocusNode,
      nextFocus: bloc.phoneFocusNode,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildPhoneField(EditShippingAddressBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.phoneNumber.tr,
      hintText: APPStrings.phoneNumber.tr,
      controller: bloc.phoneController,
      focusNode: bloc.phoneFocusNode,
      keyboardType: TextInputType.number,
    );
  }

 Widget _buildIsBillingAddressSameAsSelected(EditShippingAddressBloc bloc, AddAddressScreenStyle style) {
    return BlocBuilder<EditShippingAddressBloc, EditShippingAddressState>(
      buildWhen: (previous, current) => current is EditShippingAddressChangeAddressSameState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 22.h),
          child: SmartCheckbox(
            height: 24.w,
            width: 24.w,
            value: bloc.isShippingAddressSame,
            onChanged: (value) {
              bloc.add(EditShippingAddressAddressSameEvent(value));
            },
            label: APPStrings.markedAsDefault.tr,
            labelStyle: style.isSameAddressStyle,
          ),
        );
      },
    );
  }
}
