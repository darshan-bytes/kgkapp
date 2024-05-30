import 'package:kgk/kgk.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      bottomNavigationBar: SafeArea(
        child: SmartButton(
          margin: const EdgeInsets.symmetric(horizontal: 17),
          onTap: () {
            context.pushNamed(AppRoutes.emailSentPage);
          },
          title: APPStrings.confirmAndLogIn.tr,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
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
                      const SizedBox(height: 32),
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
                      const SizedBox(height: 16),
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
