import 'package:kgk/kgk.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return SmartSingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 17.5.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12.r),
            topEnd: Radius.circular(12.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAppBar(style, context),
              SizedBox(height: 24.h),
              ...generateChangePasswordForm(profileBloc),
              SizedBox(height: 24.h),
              _buildConfirmButton(context, profileBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ProfileScreenStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          APPStrings.changePassword.tr,
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

  List<Widget> generateChangePasswordForm(ProfileBloc profileBloc) {
    return <Widget>[
      _buildCurrentPasswordField(profileBloc),
      SizedBox(height: 24.h),
      _buildPasswordField(profileBloc),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(profileBloc),
    ];
  }

  Widget _buildCurrentPasswordField(ProfileBloc profileBloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is ChangePasswordFieldErrorState && current.fieldType == FieldTypeValidationEnum.currentPassword,
      builder: (context, state) {
        return SmartTextField(
          errorText: profileBloc.currentPasswordError,
          controller: profileBloc.currentPasswordController,
          labelText: APPStrings.currentPassword.tr,
          hintText: APPStrings.currentPassword.tr,
          obscured: true,
          keyboardType: TextInputType.visiblePassword,
          focusNode: profileBloc.currentPasswordFocusNode,
          nextFocus: profileBloc.newPasswordFocusNode,
          textInputAction: TextInputAction.next,
          autofocus: true,
          onValueChanges: (value) {
            if (profileBloc.currentPasswordError.isNotNullNorEmpty) {
              profileBloc.add(ChangePasswordFieldChangeEvent(fieldType: FieldTypeValidationEnum.currentPassword));
            }
          },
        );
      },
    );
  }

  Widget _buildPasswordField(ProfileBloc profileBloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ChangePasswordFieldErrorState && current.fieldType == FieldTypeValidationEnum.password,
      builder: (context, state) {
        return SmartTextField(
          obscured: true,
          errorText: profileBloc.passwordError,
          labelText: APPStrings.newPassword.tr,
          hintText: APPStrings.newPassword.tr,
          controller: profileBloc.newPasswordController,
          focusNode: profileBloc.newPasswordFocusNode,
          nextFocus: profileBloc.confirmPasswordFocusNode,
          textInputAction: TextInputAction.next,
          onValueChanges: (value) {
            if (profileBloc.passwordError.isNotNullNorEmpty) {
              profileBloc.add(ChangePasswordFieldChangeEvent(fieldType: FieldTypeValidationEnum.password));
            }
          },
        );
      },
    );
  }

  Widget _buildConfirmPasswordField(ProfileBloc profileBloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is ChangePasswordFieldErrorState && current.fieldType == FieldTypeValidationEnum.confirmPassword,
      builder: (context, state) {
        return SmartTextField(
          errorText: profileBloc.confirmPasswordError,
          labelText: APPStrings.confirmPassword.tr,
          hintText: APPStrings.confirmPassword.tr,
          controller: profileBloc.confirmPasswordController,
          focusNode: profileBloc.confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          obscured: true,
          onValueChanges: (value) {
            if (profileBloc.confirmPasswordError.isNotNullNorEmpty) {
              profileBloc.add(ChangePasswordFieldChangeEvent(fieldType: FieldTypeValidationEnum.confirmPassword));
            }
          },
        );
      },
    );
  }

  Widget _buildConfirmButton(BuildContext context, ProfileBloc profileBloc) {
    return SmartButton(
      title: APPStrings.confirm.tr,
      onTap: () {
        profileBloc.add(ChangePasswordEvent(context: context));
      },
    );
  }
}
