import 'package:kgk/kgk.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpStyle style = AppTheme.of(context).signUpStyle;
    SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        appBarHeight: AppConst.defaultAppBarHeight,
        backgroundColor: Colors.white,
        isBorder: false,
      ),
      body: SmartSingleChildScrollView(
        child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) => current is SignUpChangeAccountTypeState,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 18.w, end: 18.w, bottom: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(
                      APPStrings.createAccount.tr,
                      style: style.titleStyle,
                    ),
                    SizedBox(height: 4.h),
                    SmartText(
                      APPStrings.enterAccountDetails.tr,
                      style: style.subTitleStyle,
                    ),
                    SizedBox(height: 32.h),
                    SmartText(
                      APPStrings.selectAccountType.tr,
                      style: style.selectAccountStyle,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildAccountTypeSelection(
                            style: style,
                            isSelected: signUpBloc.isIndividual,
                            title: APPStrings.individual.tr,
                            image: AppImages.icUser,
                            onTap: () {
                              signUpBloc.add(SignUpChangeAccountTypeEvent(context, true));
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildAccountTypeSelection(
                            style: style,
                            isSelected: !signUpBloc.isIndividual,
                            title: APPStrings.company.tr,
                            image: AppImages.icCompany,
                            onTap: () {
                              signUpBloc.add(SignUpChangeAccountTypeEvent(context, false));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    if (signUpBloc.isIndividual)
                      ...generateIndividualForm(signUpBloc, context, style)
                    else
                      ...generateCompanyForm(signUpBloc, context, style),
                    SizedBox(height: 32.h),
                    _buildRegisterButton(context, signUpBloc),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAccountTypeSelection({
    required SignUpStyle style,
    required bool isSelected,
    required String title,
    required String image,
    required GestureTapCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.w,
        decoration: BoxDecoration(
          color: isSelected ? style.selectedAccountTypeColor : style.unselectedAccountTypeColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: isSelected ? style.selectedAccountTypeBorderColor : style.unselectedAccountTypeBorderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmartImage(
              path: image,
              color: isSelected ? style.selectedAccountTypeIconColor : style.unselectedAccountTypeIconColor,
            ),
            SizedBox(width: 8.w),
            SmartText(
              title,
              style: isSelected ? style.selectedAccountTypeTextStyle : style.unselectedAccountTypeTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateIndividualForm(SignUpBloc signUpBloc, BuildContext context, SignUpStyle style) {
    return <Widget>[
      _buildFirstNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildLastNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildEmailField(context, signUpBloc, style),
      SizedBox(height: 24.h),
      _buildContactNumberField(signUpBloc, context, style),
      SizedBox(height: 24.h),
      _buildPasswordField(signUpBloc),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  List<Widget> generateCompanyForm(SignUpBloc signUpBloc, BuildContext context, SignUpStyle style) {
    return <Widget>[
      _buildCompanyNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildCompanyLocationField(signUpBloc),
      SizedBox(height: 24.h),
      _buildBusinessType(signUpBloc, context, style),
      SizedBox(height: 24.h),
      const Divider(),
      SizedBox(height: 24.h),
      _buildFirstNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildLastNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildEmailField(context, signUpBloc, style),
      SizedBox(height: 24.h),
      _buildContactNumberField(signUpBloc, context, style),
      SizedBox(height: 24.h),
      _buildAddressField(signUpBloc),
      SizedBox(height: 24.h),
      _buildCityField(signUpBloc),
      SizedBox(height: 24.h),
      _buildStateField(signUpBloc),
      SizedBox(height: 24.h),
      _buildZipcodeField(signUpBloc),
      SizedBox(height: 24.h),
      _buildCountryField(signUpBloc, context),
      SizedBox(height: 24.h),
      _buildPasswordField(signUpBloc),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  Widget _buildFirstNameField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.firstName,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.firstNameError,
          labelText: APPStrings.firstName.tr,
          hintText: APPStrings.hintFirstName.tr,
          controller: signUpBloc.firstNameController,
          focusNode: signUpBloc.firstNameFocusNode,
          nextFocus: signUpBloc.lastNameFocusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.firstNameError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.firstName));
            }
          },
        );
      },
    );
  }

  Widget _buildLastNameField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.lastName,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.lastNameError,
          labelText: APPStrings.lastName.tr,
          hintText: APPStrings.hintLastName.tr,
          controller: signUpBloc.lastNameController,
          focusNode: signUpBloc.lastNameFocusNode,
          nextFocus: signUpBloc.emailFocusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.lastNameError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.lastName));
            }
          },
        );
      },
    );
  }

  // build address field
  Widget _buildAddressField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.address,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.addressError,
          labelText: APPStrings.address.tr,
          hintText: APPStrings.address.tr,
          controller: signUpBloc.addressController,
          focusNode: signUpBloc.addressFocusNode,
          nextFocus: signUpBloc.cityFocusNode,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.addressError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.address));
            }
          },
        );
      },
    );
  }

  // build city field
  Widget _buildCityField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.city,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.cityError,
          labelText: APPStrings.city.tr,
          hintText: APPStrings.city.tr,
          controller: signUpBloc.cityController,
          focusNode: signUpBloc.cityFocusNode,
          nextFocus: signUpBloc.stateFocusNode,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.cityError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.city));
            }
          },
        );
      },
    );
  }

  // build state field
  Widget _buildStateField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.state,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.stateError,
          labelText: APPStrings.state.tr,
          hintText: APPStrings.state.tr,
          controller: signUpBloc.stateController,
          focusNode: signUpBloc.stateFocusNode,
          nextFocus: signUpBloc.zipcodeFocusNode,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.stateError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.state));
            }
          },
        );
      },
    );
  }

  // build zipcode field
  Widget _buildZipcodeField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.zipcode,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.zipcodeError,
          labelText: APPStrings.zipcode.tr,
          hintText: APPStrings.zipcode.tr,
          controller: signUpBloc.zipcodeController,
          focusNode: signUpBloc.zipcodeFocusNode,
          nextFocus: signUpBloc.officeLocationFocusNode,
          keyboardType: TextInputType.number,
          onValueChanges: (value) {
            if (signUpBloc.zipcodeError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.zipcode));
            }
          },
        );
      },
    );
  }

  Widget _buildEmailField(BuildContext context, SignUpBloc signUpBloc, SignUpStyle style) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          (current is SignUpEmailValidationState && current.emailValidationFieldType == ValidationFieldType.email) ||
          (current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.email),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartTextField(
              errorText: signUpBloc.emailError,
              labelText: APPStrings.email.tr,
              hintText: APPStrings.hintEmail.tr,
              controller: signUpBloc.emailController,
              focusNode: signUpBloc.emailFocusNode,
              nextFocus: signUpBloc.contactNumberFocusNode,
              keyboardType: TextInputType.emailAddress,
              onValueChanges: (value) {
                signUpBloc.add(SignUpEmailValidationEvent(email: value, context: context));
                if (signUpBloc.emailError.isNotNullNorEmpty) {
                  signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.email));
                }
              },
            ),
            Visibility(
              visible: state is SignUpEmailValidationState && state.isError,
              child: SmartText(
                APPStrings.emailAlreadyUsed.tr,
                color: style.errorTextColor,
                optionalPadding: EdgeInsetsDirectional.only(top: 6.h),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildContactNumberField(SignUpBloc signUpBloc, BuildContext context, SignUpStyle style) {
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpAddRemoveContactState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: signUpBloc.isIndividual ? 1 : signUpBloc.contactNumberControllers.length,
              itemBuilder: (_, index) {
                return BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (previous, current) =>
                      current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.contactNumber,
                  builder: (context, state) {
                    return SmartTextField(
                      errorText: signUpBloc.contactNumberErrors[index],
                      labelText: index == 0 ? APPStrings.contactNumber.tr : null,
                      hintText: APPStrings.hintContactNumber.tr,
                      controller: signUpBloc.contactNumberControllers[index],
                      focusNode: signUpBloc.contactNumberFocusNodes[index],
                      nextFocus: (index == signUpBloc.contactNumberControllers.length - 1)
                          ? signUpBloc.addressFocusNode
                          : signUpBloc.contactNumberFocusNodes[index + 1],
                      keyboardType: TextInputType.phone,
                      textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      prefixIcon: BlocBuilder<SignUpBloc, SignUpState>(
                        buildWhen: (previous, current) => current is SignUpChangeCountryCodeState,
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              Utils.showCountryPickerModel(
                                context: context,
                                countryPickerStyle: countryPickerStyle,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  signUpBloc.add(SignUpChangeCountryCodeEvent(country: country, index: index));
                                },
                              );
                            },
                            child: SizedBox(
                              width: 95.w,
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                padding: EdgeInsetsDirectional.all(12.w),
                                margin: EdgeInsetsDirectional.only(end: 12.w),
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                    end: BorderSide(
                                      color: AppTheme.of(context).textFieldStyle.enabledTextFieldBorderColor,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SmartText(
                                      '+${signUpBloc.selectedCountryCodes[index].phoneCode}',
                                      style: AppTheme.of(context).textFieldStyle.textStyle,
                                    ),
                                    SizedBox(width: 4.w),
                                    const SmartImage(path: AppImages.icArrowDropDown),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      suffixIcon: (!signUpBloc.isIndividual && index > 0)
                          ? IconButton(
                              onPressed: () {
                                signUpBloc.add(SignUpRemoveContactEvent(index));
                              },
                              icon: SmartImage(
                                path: AppImages.icMinus,
                                height: 16.w,
                                width: 16.w,
                              ),
                            )
                          : null,
                    );
                  },
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(height: 8.h);
              },
            ),
            BlocBuilder<SignUpBloc, SignUpState>(
              buildWhen: (previous, current) => current is SignUpPhoneNumberValidationState,
              builder: (context, state) {
                if (state is SignUpPhoneNumberValidationState && state.isError) {
                  return SmartText(
                    state.errorMessage ?? APPStrings.phoneNumberAlreadyUsed.tr,
                    color: style.errorTextColor,
                    optionalPadding: EdgeInsetsDirectional.only(top: 6.h),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            if (!signUpBloc.isIndividual && signUpBloc.contactNumberControllers.length < 2) ...[
              SizedBox(height: 8.h),
              SmartText(
                APPStrings.plusAdd.tr,
                style: AppTheme.of(context).textFieldStyle.textStyle,
                onTap: () {
                  signUpBloc.add(const SignupAddContactEvent());
                },
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildPasswordField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.password,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.passwordError,
          labelText: APPStrings.password.tr,
          hintText: APPStrings.password.tr,
          controller: signUpBloc.passwordController,
          focusNode: signUpBloc.passwordFocusNode,
          nextFocus: signUpBloc.confirmPasswordFocusNode,
          obscured: true,
          onValueChanges: (value) {
            if (signUpBloc.passwordError.isNotNullNorEmpty || signUpBloc.confirmPasswordError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.password));
            }
          },
        );
      },
    );
  }

  Widget _buildConfirmPasswordField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.confirmPassword,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.confirmPasswordError,
          labelText: APPStrings.confirmPassword.tr,
          hintText: APPStrings.confirmPassword.tr,
          controller: signUpBloc.confirmPasswordController,
          focusNode: signUpBloc.confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          obscured: true,
          onValueChanges: (value) {
            if (signUpBloc.confirmPasswordError.isNotNullNorEmpty || signUpBloc.passwordError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.confirmPassword));
            }
          },
        );
      },
    );
  }

  Widget _buildCompanyNameField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.companyName,
      builder: (context, state) {
        return SmartTextField(
          errorText: signUpBloc.companyNameError,
          labelText: APPStrings.companyName.tr,
          hintText: APPStrings.hintCompanyName.tr,
          controller: signUpBloc.companyNameController,
          focusNode: signUpBloc.companyNameFocusNode,
          nextFocus: signUpBloc.officeLocationFocusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          onValueChanges: (value) {
            if (signUpBloc.companyNameError.isNotNullNorEmpty) {
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.companyName));
            }
          },
        );
      },
    );
  }

  Widget _buildCompanyLocationField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          current is SignUpChangeOfficeLocationState ||
          (current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.officeLocation),
      builder: (context, state) {
        return SmartDropDown<OfficeLocation>(
          canSearch: true,
          errorText: signUpBloc.officeLocationError,
          hintText: APPStrings.officeLocation.tr,
          labelText: APPStrings.officeLocation.tr,
          items: signUpBloc.officeLocations.map((OfficeLocation officeLocation) {
            return SmartDropDownItem<OfficeLocation>(
              value: officeLocation,
              title: officeLocation.name ?? '',
            );
          }).toList(),
          onChanged: (businessType) {
            if (businessType != null) {
              signUpBloc.add(SignUpChangeOfficeLocationEvent(businessType));
              signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.officeLocation));
            }
          },
          selectedItem: signUpBloc.selectedOfficeLocation,
        );
      },
    );
  }

  Widget _buildRegisterButton(BuildContext context, SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpLoadedState || current is SignUpErrorState,
      builder: (context, state) {
        return SmartButton(
          isEnabled: signUpBloc.isSignupButtonEnabled,
          title: APPStrings.register.tr,
          onTap: () {
            signUpBloc.add(SignUpSubmitEvent(context));
          },
        );
      },
    );
  }

  Widget _buildBusinessType(SignUpBloc signUpBloc, BuildContext context, SignUpStyle style) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpFieldValidationState && current.fieldType == FieldTypeValidationEnum.businessType,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartText(
              APPStrings.businessType.tr,
              style: AppTheme.of(context).textFieldStyle.labelStyle,
            ),
            SizedBox(height: 12.h),
            Wrap(
              children: List.generate(signUpBloc.businessTypes.length, (index) {
                final BusinessType businessType = signUpBloc.businessTypes[index];
                return BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (previous, current) => current is SignUpBusinessTypeChangedState,
                  builder: (context, state) {
                    return SmartCheckbox.radio(
                      padding:
                          index != signUpBloc.businessTypes.length - 1 ? EdgeInsetsDirectional.only(end: 20.w) : EdgeInsetsDirectional.zero,
                      value: businessType.isSelected,
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        signUpBloc.add(SignUpBusinessTypeChangedEvent(val, index));
                        signUpBloc.add(SignUpFieldChangeEvent(FieldTypeValidationEnum.businessType));
                      },
                      label: businessType.name,
                      mainAxisSize: MainAxisSize.min,
                    );
                  },
                );
              }).toList(),
            ),
            if (signUpBloc.businessTypeError.isNotNullNorEmpty)
              Visibility(
                visible: state is SignUpEmailValidationState && state.isError,
                child: SmartText(
                  signUpBloc.businessTypeError,
                  color: style.errorTextColor,
                  optionalPadding: EdgeInsetsDirectional.only(top: 6.h),
                ),
              )
          ],
        );
      },
    );
  }

  Widget _buildCountryField(SignUpBloc signUpBloc, BuildContext context) {
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpChangeCountryState,
      builder: (context, state) {
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
                    signUpBloc.add(SignUpChangeCountryEvent(country));
                  },
                );
              },
              child: Container(
                height: 48.w,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: countryPickerStyle.inputBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        signUpBloc.selectedCountry.getTranslatedName(context) ?? signUpBloc.selectedCountry.name,
                        style: countryPickerStyle.inputTextStyle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const SmartImage(path: AppImages.icArrowDropDown),
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
