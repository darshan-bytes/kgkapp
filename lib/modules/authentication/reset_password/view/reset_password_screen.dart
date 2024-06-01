import 'package:kgk/kgk.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52.h,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartButton(
              margin: EdgeInsets.symmetric(horizontal: 17.w),
              onTap: () {
                context.popUntil((route) => route.settings.name == AppRoutes.signInPage);
              },
              title: APPStrings.confirmAndLogIn.tr,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SmartText(
                        APPStrings.resetPassword.tr,
                        style: style.titleTextStyle,
                      ),
                      SmartText(
                        APPStrings.resetPasswordDescription.tr,
                        style: style.subTitleStyle,
                      ),
                      SizedBox(height: 32.h),
                      SmartTextField(
                        controller: resetPasswordBloc.newPasswordController,
                        labelText: APPStrings.newPassword.tr,
                        hintText: APPStrings.newPassword.tr,
                        lableStyle: style.labelStyle,
                        obscured: true,
                        keyboardType: TextInputType.visiblePassword,
                        nextFocus: resetPasswordBloc.confirmPasswordFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SizedBox(height: 16.h),
                      SmartTextField(
                        controller: resetPasswordBloc.confirmPasswordController,
                        labelText: APPStrings.confirmPassword.tr,
                        hintText: APPStrings.confirmPassword.tr,
                        lableStyle: style.labelStyle,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscured: true,
                        focusNode: resetPasswordBloc.confirmPasswordFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
