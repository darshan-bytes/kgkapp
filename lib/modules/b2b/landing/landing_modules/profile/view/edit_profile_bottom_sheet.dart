import 'package:kgk/kgk.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);

    return SmartSingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      controller: bloc.scrollController,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBar(style, context),
            SizedBox(height: 24.h),
            _buildProfileImageSection(style, context, bloc),
            SizedBox(height: 24.h),
            ...generateProfileForm(bloc, context),
            SizedBox(height: 24.h),
            _buildSaveButton(context, bloc),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(ProfileScreenStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          APPStrings.editProfile.tr,
          style: style.bottomTitleStyle,
        ),
        SmartImage(
          path: AppImages.icCross,
          height: 24.w,
          width: 24.w,
          color: style.primaryColor,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _buildProfileImageSection(ProfileScreenStyle style, BuildContext context, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfilePickImageState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SmartImage(
                  path: bloc.profilePickedImageList.isNotNullNorEmpty ? bloc.profilePickedImageList.first.path : AppImages.icProfilePic,
                  height: 73.w,
                  width: 73.w,
                  fit: BoxFit.cover,
                  imageBorderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    _showImagePickDialog(context, bloc);
                  },
                ),
                if (bloc.profilePickedImageList.isNullOrEmpty) ...[
                  SmartImage(
                    path: AppImages.icEditImage,
                    height: 32.w,
                    width: 32.w,
                    onTap: () {
                      _showImagePickDialog(context, bloc);
                    },
                  ),
                ] else ...[
                  Positioned(
                    top: 0.w,
                    right: 0.w,
                    child: CircleAvatar(
                      radius: 16.r,
                      child: SmartImage(
                        path: AppImages.icCross,
                        color: style.primaryColor,
                        height: 16.w,
                        width: 16.w,
                        onTap: () {
                          bloc.add(RemoveProfileImageEvent());
                        },
                      ),
                    ),
                  )
                ]
              ],
            ),
          ],
        );
      },
    );
  }

  List<Widget> generateProfileForm(ProfileBloc bloc, BuildContext context) {
    return <Widget>[
      _buildFirstNameField(bloc),
      SizedBox(height: 24.h),
      _buildLastNameField(bloc),
      SizedBox(height: 24.h),
      _buildEmailField(bloc),
      SizedBox(height: 24.h),
      _buildContactNumberField(bloc, context),
    ];
  }

  Widget _buildFirstNameField(ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is EditProfileFieldErrorState && current.fieldType == FieldTypeValidationEnum.firstName,
      builder: (context, state) {
        return SmartTextField(
          labelText: APPStrings.firstName.tr,
          hintText: APPStrings.firstName.tr,
          controller: bloc.firstNameController,
          focusNode: bloc.firstNameFocusNode,
          nextFocus: bloc.lastNameFocusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          errorText: bloc.firstNameError,
          onValueChanges: (value) {
            if (bloc.firstNameError.isNotNullNorEmpty) {
              bloc.add(EditProfileFieldChangeEvent(fieldType: FieldTypeValidationEnum.firstName));
            }
          },
        );
      },
    );
  }

  Widget _buildLastNameField(ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is EditProfileFieldErrorState && current.fieldType == FieldTypeValidationEnum.lastName,
      builder: (context, state) {
        return SmartTextField(
          labelText: APPStrings.lastName.tr,
          hintText: APPStrings.lastName.tr,
          controller: bloc.lastNameController,
          focusNode: bloc.lastNameFocusNode,
          nextFocus: bloc.emailFocusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          errorText: bloc.lastNameError,
          onValueChanges: (value) {
            if (bloc.lastNameError.isNotNullNorEmpty) {
              bloc.add(EditProfileFieldChangeEvent(fieldType: FieldTypeValidationEnum.lastName));
            }
          },
        );
      },
    );
  }

  Widget _buildEmailField(ProfileBloc bloc) {
    return SmartTextField(
      isEnabled: false,
      labelText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      controller: bloc.emailController,
      focusNode: bloc.emailFocusNode,
      nextFocus: bloc.contactNumberFocusNode,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildContactNumberField(ProfileBloc bloc, BuildContext context) {
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is EditProfileFieldErrorState && current.fieldType == FieldTypeValidationEnum.contactNumber,
      builder: (context, state) {
        return SmartTextField(
          labelText: APPStrings.contactNumber.tr,
          hintText: APPStrings.hintContactNumber.tr,
          controller: bloc.contactNumberController,
          focusNode: bloc.contactNumberFocusNode,
          keyboardType: TextInputType.phone,
          errorText: bloc.contactNumberError,
          onValueChanges: (value) {
            if (bloc.contactNumberError.isNotNullNorEmpty) {
              bloc.add(EditProfileFieldChangeEvent(fieldType: FieldTypeValidationEnum.contactNumber));
            }
            bloc.add(EditProfilePhoneNumberValidationEvent(context: context, phoneNumber: value));
          },
          prefixIcon: BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) => current is EditProfileChangeCountryCodeState,
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  Utils.showCountryPickerModel(
                    context: context,
                    countryPickerStyle: countryPickerStyle,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      bloc.add(EditProfileChangeCountryCodeEvent(context: context, country: country));
                      if (bloc.contactNumberController.text.isNotEmpty) {
                        bloc.add(EditProfilePhoneNumberValidationEvent(context: context, phoneNumber: bloc.contactNumberController.text));
                      }
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
                          '+${bloc.selectedCountry.phoneCode}',
                          style: AppTheme.of(context).textFieldStyle.textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          onTap: () {
            bloc.scrollController.animateTo(
              bloc.scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
            );
          },
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context, ProfileBloc bloc) {
    return SmartButton(
      key: bloc.saveBtnKey,
      title: APPStrings.save.tr,
      onTap: () {
        bloc.add(EditProfileSaveEvent(context: context));
      },
    );
  }

  void _showImagePickDialog(BuildContext context, ProfileBloc bloc) {
    Utils.showSmartModalBottomSheet(
      context: context,
      builder: (context) {
        return SmartImagePickDialogSheet(
          onTapSource: (ImageSource imageSource) {
            bloc.add(ProfilePickImageEvent(imageSource: imageSource));
          },
        );
      },
    );
  }
}
