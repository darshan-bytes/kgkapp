import 'package:kgk/kgk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final SignInBloc bloc = context.read<SignInBloc>();
    return Scaffold(
      bottomNavigationBar: buildRichText(context),
      appBar: SmartAppBar(appBarHeight: 52.h, isBorder: false, backgroundColor: style.backgroundColor),
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
                        APPStrings.login.tr,
                        style: style.titleTextStyle,
                      ),
                      SmartText(
                        APPStrings.enterYourAccountDetails.tr,
                        style: style.subTitleStyle,
                      ),
                      SizedBox(height: 32.h),
                      _buildEmailField(style, context, bloc),
                      SizedBox(height: 24.h),
                      _buildPasswordField(style, context, bloc),
                      SizedBox(height: 16.h),
                      _buildForgotPasswordText(context, style),
                      SizedBox(height: 32.h),
                      _buildLoginButton(context),
                      // TODO: For social media buttons
                      // const SizedBox(height: 32),
                      // _buildDivider(style),
                      // const SizedBox(height: 24),
                      // _buildSocialMediaButtons(),
                      SizedBox(height: 24.h),
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
      labelStyle: style.labelStyle,
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
      labelStyle: style.labelStyle,
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
          padding: EdgeInsets.symmetric(horizontal: 12.w),
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
        SizedBox(width: 40.w),
        GestureDetector(
          onTap: () {},
          child: const SmartImage(path: AppImages.icGoogle),
        ),
        SizedBox(width: 40.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartRichText(
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
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
