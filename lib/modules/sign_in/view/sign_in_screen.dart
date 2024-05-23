import 'package:kgk/kgk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 52,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SmartText(
                                APPStrings.login.tr,
                                style: style.titleTextStyle,
                              ),
                              SmartText(
                                APPStrings.enterYourAccountDetails.tr,
                                style: style.subTitleStyle,
                              ),
                              const SizedBox(height: 32),
                              _buildEmailField(style, context),
                              const SizedBox(height: 24),
                              _buildPasswordField(style, context),
                              const SizedBox(height: 16),
                              _buildForgotPasswordText(context, style),
                              const SizedBox(height: 32),
                              _buildLoginButton(context),
                              const SizedBox(height: 32),
                              _buildDivider(style),
                              const SizedBox(height: 24),
                              _buildSocialMediaButtons(),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      buildRichText(context),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailField(SignInScreenStyle style, context) {
    return SmartTextField(
      labelText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      lableStyle: style.labelStyle,
      keyboardType: TextInputType.emailAddress,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildPasswordField(SignInScreenStyle style, context) {
    return SmartTextField(
      obscured: true,
      labelText: APPStrings.password.tr,
      hintText: APPStrings.password.tr,
      keyboardType: TextInputType.visiblePassword,
      lableStyle: style.labelStyle,
      onEditingComplete: () {},
    );
  }

  Widget _buildForgotPasswordText(BuildContext context, SignInScreenStyle style) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.forgotPasswordPage);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: SmartText(
          APPStrings.forgotPassword.tr.interpolate(['?']),
          style: style.forgotPasswordStyle,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SmartButton(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardPage, (route) => false);
      },
      title: APPStrings.login.tr,
    );
  }

  Widget _buildDivider(SignInScreenStyle style) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: style.backgroundColor,
          child: SmartText(
            APPStrings.orLoginWith.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.labelStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: const SmartImage(
            path: AppImages.icFacebook,
          ),
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () {},
          child: const SmartImage(path: AppImages.icGoogle),
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () {},
          child: const SmartImage(path: AppImages.icZoho),
        ),
      ],
    );
  }

  Widget buildRichText(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    return SmartRichText(
      spans: [
        SmartTextSpan(text: APPStrings.dontHaveAccount.tr),
        SmartTextSpan(text: ' '),
        SmartTextSpan(
          text: APPStrings.register.tr,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.signUpPage);
          },
          style: style.registerTextStyle,
        )
      ],
    );
  }
}
