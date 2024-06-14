import 'package:kgk/kgk.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return SmartSingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.r),
              topRight: Radius.circular(6.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAppBar(style, context),
              SizedBox(height: 24.h),
              ...generateChangePasswordForm(profileBloc),
              SizedBox(height: 24.h),
              _buildConfirmButton(context),
            ],
          ),
        ));
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
      _buildNewPasswordField(profileBloc),
      SizedBox(height: 24.h),
      _buildConfirmNewPasswordField(profileBloc),
    ];
  }

  Widget _buildCurrentPasswordField(ProfileBloc profileBloc) {
    return SmartTextField(
      controller: profileBloc.currentPasswordController,
      labelText: APPStrings.currentPassword.tr,
      hintText: APPStrings.currentPassword.tr,
      obscured: true,
      keyboardType: TextInputType.visiblePassword,
      focusNode: profileBloc.currentPasswordFocusNode,
      nextFocus: profileBloc.newPasswordFocusNode,
      textInputAction: TextInputAction.next,
      autofocus: true,
    );
  }

  Widget _buildNewPasswordField(ProfileBloc profileBloc) {
    return SmartTextField(
      controller: profileBloc.newPasswordController,
      labelText: APPStrings.newPassword.tr,
      hintText: APPStrings.newPassword.tr,
      obscured: true,
      keyboardType: TextInputType.visiblePassword,
      focusNode: profileBloc.newPasswordFocusNode,
      nextFocus: profileBloc.confirmPasswordFocusNode,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildConfirmNewPasswordField(ProfileBloc profileBloc) {
    return SmartTextField(
      controller: profileBloc.confirmPasswordController,
      labelText: APPStrings.confirmPassword.tr,
      hintText: APPStrings.confirmPassword.tr,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscured: true,
      focusNode: profileBloc.confirmPasswordFocusNode,
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SmartButton(
      title: APPStrings.confirm.tr,
      onTap: () {
        context.pop();
      },
    );
  }
}
