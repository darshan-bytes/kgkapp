import 'package:kgk/kgk.dart';

class ChangePasswordBottomSheetForUserMaster extends StatelessWidget {
  final UserMasterListingBloc bloc;
  final int index;

  const ChangePasswordBottomSheetForUserMaster({super.key, required this.bloc, required this.index});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
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
              ...generateChangePasswordForm(),
              SizedBox(height: 24.h),
              _buildConfirmButton(context),
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

  List<Widget> generateChangePasswordForm() {
    return <Widget>[
      _buildPasswordField(),
      SizedBox(height: 24.h),
      _buildConfirmPasswordField(),
    ];
  }

  Widget _buildPasswordField() {
    return BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is UserMasterChangePasswordFieldErrorState && current.fieldType == FieldTypeValidationEnum.password,
      builder: (context, state) {
        return SmartTextField(
          obscured: true,
          errorText: bloc.passwordError,
          labelText: APPStrings.newPassword.tr,
          hintText: APPStrings.newPassword.tr,
          controller: bloc.newPasswordController,
          focusNode: bloc.newPasswordFocusNode,
          nextFocus: bloc.confirmPasswordFocusNode,
          textInputAction: TextInputAction.next,
          onValueChanges: (value) {
            if (bloc.passwordError.isNotNullNorEmpty) {
              bloc.add(UserMasterChangePasswordFieldChangeEvent(fieldType: FieldTypeValidationEnum.password));
            }
          },
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is UserMasterChangePasswordFieldErrorState && current.fieldType == FieldTypeValidationEnum.confirmPassword,
      builder: (context, state) {
        return SmartTextField(
          errorText: bloc.confirmPasswordError,
          labelText: APPStrings.confirmPassword.tr,
          hintText: APPStrings.confirmPassword.tr,
          controller: bloc.confirmPasswordController,
          focusNode: bloc.confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          obscured: true,
          onValueChanges: (value) {
            if (bloc.confirmPasswordError.isNotNullNorEmpty) {
              bloc.add(UserMasterChangePasswordFieldChangeEvent(fieldType: FieldTypeValidationEnum.confirmPassword));
            }
          },
        );
      },
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SmartButton(
      title: APPStrings.confirm.tr,
      onTap: () {
        bloc.add(UserMasterChangePasswordEvent(context: context, index: index));
      },
    );
  }
}
