import 'package:kgk/kgk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final SignInBloc bloc = context.read<SignInBloc>();
    return Scaffold(
      bottomNavigationBar: buildRichText(context),
      appBar: SmartAppBar(appBarHeight: 52, isBorder: false, backgroundColor: style.backgroundColor),
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
                        APPStrings.login.tr,
                        style: style.titleTextStyle,
                      ),
                      SmartText(
                        APPStrings.enterYourAccountDetails.tr,
                        style: style.subTitleStyle,
                      ),
                      const SizedBox(height: 32),
                      _buildEmailField(style, context, bloc),
                      const SizedBox(height: 24),
                      _buildPasswordField(style, context, bloc),
                      const SizedBox(height: 16),
                      _buildForgotPasswordText(context, style),
                      const SizedBox(height: 32),
                      _buildLoginButton(context),
                      // TODO: For social media buttons
                      // const SizedBox(height: 32),
                      // _buildDivider(style),
                      // const SizedBox(height: 24),
                      // _buildSocialMediaButtons(),
                      const SizedBox(height: 24),
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

  Widget _buildEmailField(SignInScreenStyle style, context, SignInBloc bloc) {
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

  Widget _buildPasswordField(SignInScreenStyle style, context, SignInBloc bloc) {
    return SmartTextField(
      obscured: true,
      labelText: APPStrings.password.tr,
      hintText: APPStrings.password.tr,
      keyboardType: TextInputType.visiblePassword,
      lableStyle: style.labelStyle,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _buildForgotPasswordText(BuildContext context, SignInScreenStyle style) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.forgotPasswordPage);
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
        context.pushNamedAndRemoveUntil(AppRoutes.dashboardPage, (route) => false);
      },
      title: APPStrings.login.tr,
    );
  }

  // ignore: unused_element
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

  // ignore: unused_element
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
    return SafeArea(
      child: SmartRichText(
        textAlign: TextAlign.center,
        spans: [
          SmartTextSpan(text: APPStrings.dontHaveAccount.tr),
          SmartTextSpan(text: ' '),
          SmartTextSpan(
            text: APPStrings.register.tr,
            onTap: () {
              context.pushNamed(AppRoutes.signUpPage);
            },
            style: style.registerTextStyle,
          )
        ],
      ),
    );
  }
}
