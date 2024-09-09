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
                padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 18.h),
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
                              signUpBloc.add(const SignUpChangeAccountTypeEvent(true));
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
                              signUpBloc.add(const SignUpChangeAccountTypeEvent(false));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    if (signUpBloc.isIndividual)
                      ...generateIndividualForm(signUpBloc, context)
                    else
                      ...generateCompanyForm(signUpBloc, context),
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

  List<Widget> generateIndividualForm(SignUpBloc signUpBloc, BuildContext context) {
    return <Widget>[
      _buildFirstNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildLastNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildEmailField(signUpBloc),
      SizedBox(height: 24.h),
      _buildContactNumberField(signUpBloc, context),
      SizedBox(height: 24.h),
      _buildPasswordField(signUpBloc),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  List<Widget> generateCompanyForm(SignUpBloc signUpBloc, BuildContext context) {
    return <Widget>[
      _buildCompanyNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildCompanyLocationField(signUpBloc),
      SizedBox(height: 24.h),
      _buildBusinessType(signUpBloc, context),
      SizedBox(height: 24.h),
      const Divider(),
      SizedBox(height: 24.h),
      _buildFirstNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildLastNameField(signUpBloc),
      SizedBox(height: 24.h),
      _buildEmailField(signUpBloc),
      SizedBox(height: 24.h),
      _buildContactNumberField(signUpBloc, context),
      SizedBox(height: 24.h),
      _buildCountryField(signUpBloc, context),
      SizedBox(height: 24.h),
      _buildPasswordField(signUpBloc),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  Widget _buildFirstNameField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.firstName.tr,
      hintText: APPStrings.hintFirstName.tr,
      controller: signUpBloc.firstNameController,
      focusNode: signUpBloc.firstNameFocusNode,
      nextFocus: signUpBloc.lastNameFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildLastNameField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.lastName.tr,
      hintText: APPStrings.hintLastName.tr,
      controller: signUpBloc.lastNameController,
      focusNode: signUpBloc.lastNameFocusNode,
      nextFocus: signUpBloc.emailFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildEmailField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.email.tr,
      hintText: APPStrings.hintEmail.tr,
      controller: signUpBloc.emailController,
      focusNode: signUpBloc.emailFocusNode,
      nextFocus: signUpBloc.contactNumberFocusNode,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildContactNumberField(SignUpBloc signUpBloc, BuildContext context) {
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
                return SmartTextField(
                  labelText: index == 0 ? APPStrings.contactNumber.tr : null,
                  hintText: APPStrings.hintContactNumber.tr,
                  controller: signUpBloc.contactNumberControllers[index],
                  focusNode: signUpBloc.contactNumberFocusNodes[index],
                  nextFocus: (index == signUpBloc.contactNumberControllers.length - 1)
                      ? signUpBloc.passwordFocusNode
                      : signUpBloc.contactNumberFocusNodes[index + 1],
                  keyboardType: TextInputType.phone,
                  textInputFormatter: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
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
              separatorBuilder: (_, __) {
                return SizedBox(height: 8.h);
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
    return SmartTextField(
      labelText: APPStrings.password.tr,
      hintText: APPStrings.password.tr,
      controller: signUpBloc.passwordController,
      focusNode: signUpBloc.passwordFocusNode,
      nextFocus: signUpBloc.confirmPasswordFocusNode,
      obscured: true,
    );
  }

  Widget _buildConfirmPasswordField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.confirmPassword.tr,
      hintText: APPStrings.confirmPassword.tr,
      controller: signUpBloc.confirmPasswordController,
      focusNode: signUpBloc.confirmPasswordFocusNode,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        // signUpBloc.add(const SignUpSubmitEvent());
      },
      obscured: true,
    );
  }

  Widget _buildCompanyNameField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.companyName.tr,
      hintText: APPStrings.hintCompanyName.tr,
      controller: signUpBloc.companyNameController,
      focusNode: signUpBloc.companyNameFocusNode,
      nextFocus: signUpBloc.officeLocationFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildCompanyLocationField(SignUpBloc signUpBloc) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is SignUpChangeOfficeLocationState,
      builder: (context, state) {
        return SmartDropDown<OfficeLocation>(
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
            // context.popUntil((route) => (route.settings.name == AppRoutes.signInPage));
          },
        );
      },
    );
  }

  Widget _buildBusinessType(SignUpBloc signUpBloc, BuildContext context) {
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
                  padding: index != signUpBloc.businessTypes.length - 1 ? EdgeInsets.only(right: 20.w) : EdgeInsets.zero,
                  value: businessType.isSelected,
                  onChanged: (val) {
                    if (val == null) {
                      return;
                    }
                    signUpBloc.add(SignUpBusinessTypeChangedEvent(val, index));
                  },
                  label: businessType.name,
                  mainAxisSize: MainAxisSize.min,
                );
              },
            );
          }).toList(),
        ),
      ],
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                        signUpBloc.selectedCountry.name,
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
