import 'package:kgk/kgk.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpStyle style = AppTheme.of(context).signUpStyle;
    SignUpBloc signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        appBarHeight: kToolbarHeight,
        backgroundColor: Colors.white,
        isBorder: false,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) => current is SignUpChangeAccountTypeState,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(
                      APPStrings.createAccount.tr,
                      style: style.titleStyle,
                    ),
                    const SizedBox(height: 4),
                    SmartText(
                      APPStrings.enterAccountDetails.tr,
                      style: style.subTitleStyle,
                    ),
                    const SizedBox(height: 32),
                    SmartText(
                      APPStrings.selectAccountType.tr,
                      style: style.selectAccountStyle,
                    ),
                    const SizedBox(height: 12),
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
                        const SizedBox(width: 12),
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
                    const SizedBox(height: 24),
                    if (signUpBloc.isIndividual)
                      ...generateIndividualForm(signUpBloc, context)
                    else
                      ...generateCompanyForm(signUpBloc, context),
                    const SizedBox(height: 24),
                    _buildRegisterButton(context),
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
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? style.selectedAccountTypeColor : style.unselectedAccountTypeColor,
          borderRadius: BorderRadius.circular(4),
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
            const SizedBox(width: 8),
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
      const SizedBox(height: 24),
      _buildLastNameField(signUpBloc),
      const SizedBox(height: 24),
      _buildEmailField(signUpBloc),
      const SizedBox(height: 24),
      _buildContactNumberField(signUpBloc, context),
      const SizedBox(height: 24),
      _buildPasswordField(signUpBloc),
      const SizedBox(height: 24),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  List<Widget> generateCompanyForm(SignUpBloc signUpBloc, BuildContext context) {
    return <Widget>[
      _buildCompanyNameField(signUpBloc),
      const SizedBox(height: 24),
      _buildCompanyLocationField(signUpBloc),
      const SizedBox(height: 12),
      _buildBusinessType(signUpBloc, context),
      const SizedBox(height: 12),
      const Divider(),
      const SizedBox(height: 24),
      _buildFirstNameField(signUpBloc),
      const SizedBox(height: 24),
      _buildLastNameField(signUpBloc),
      const SizedBox(height: 24),
      _buildEmailField(signUpBloc),
      const SizedBox(height: 24),
      _buildContactNumberField(signUpBloc, context),
      const SizedBox(height: 24),
      _buildCountryField(signUpBloc, context),
      const SizedBox(height: 24),
      _buildPasswordField(signUpBloc),
      const SizedBox(height: 24),
      _buildConfirmPasswordField(signUpBloc),
    ];
  }

  Widget _buildFirstNameField(SignUpBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.firstName.tr,
      hintText: APPStrings.firstName.tr,
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
      hintText: APPStrings.lastName.tr,
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
      hintText: APPStrings.email.tr,
      controller: signUpBloc.emailController,
      focusNode: signUpBloc.emailFocusNode,
      nextFocus: signUpBloc.contactNumberFocusNode,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildContactNumberField(SignUpBloc signUpBloc, BuildContext context) {
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
                  hintText: APPStrings.contactNumber.tr,
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
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              signUpBloc.add(SignUpChangeCountryCodeEvent(country: country, index: index));
                            },
                          );
                        },
                        child: SizedBox(
                          width: 95,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(right: 12),
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
                                const SizedBox(width: 4),
                                const SmartImage(path: AppImages.icArrowDown),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  suffixIcon: signUpBloc.isIndividual || (signUpBloc.contactNumberControllers.length == 1)
                      ? null
                      : IconButton(
                          onPressed: () {
                            signUpBloc.add(SignUpRemoveContactEvent(index));
                          },
                          icon: const SmartImage(
                            path: AppImages.icMinus,
                            height: 16,
                            width: 16,
                          ),
                        ),
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: 8);
              },
            ),
            if (!signUpBloc.isIndividual) ...[
              const SizedBox(height: 8),
              SmartText(
                APPStrings.add.tr,
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
      hintText: APPStrings.companyName.tr,
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
              title: officeLocation.name,
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

  Widget _buildRegisterButton(BuildContext context) {
    return SmartButton(
      title: APPStrings.register.tr,
      onTap: () {
        Navigator.popUntil(
            context, (route) => (route.settings.name == AppRoutes.getReadyPage) || (route.settings.name == AppRoutes.signInPage));
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
        const SizedBox(height: 4),
        Wrap(
          children: List.generate(signUpBloc.businessTypes.length, (index) {
            final BusinessType businessType = signUpBloc.businessTypes[index];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (previous, current) => current is SignUpBusinessTypeChangedState,
                  builder: (context, state) {
                    return SmartRadioButton<BusinessType>(
                      isToggle: true,
                      groupValue: signUpBloc.selectedBusinessType,
                      value: businessType,
                      onChanged: (val) {
                        signUpBloc.add(SignUpBusinessTypeChangedEvent(val));
                      },
                      label: businessType.name,
                    );
                  },
                ),
                if (index != signUpBloc.businessTypes.length - 1) const SizedBox(width: 20)
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCountryField(SignUpBloc signUpBloc, BuildContext context) {
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
                    signUpBloc.add(SignUpChangeCountryEvent(country));
                  },
                );
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.of(context).textFieldStyle.enabledTextFieldBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        signUpBloc.selectedCountry.name,
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
