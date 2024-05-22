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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildRichText(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
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
              _buildLoginButton(),
              const SizedBox(height: 32),
              _buildDivider(style),
              const SizedBox(height: 24),
              _buildSocialMediaButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(SignInScreenStyle style, context) {
    return SmartTextField(
      lableText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      lableStyle: style.lableStyle,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildPasswordField(SignInScreenStyle style, context) {
    return SmartTextField(
      obscured: true,
      lableText: APPStrings.password.tr,
      hintText: APPStrings.password.tr,
      lableStyle: style.lableStyle,
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
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

  Widget _buildLoginButton() {
    return PrimaryButton(
      onClick: () {},
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
            style: style.lableStyle,
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
          child: const SmartImage(path: AppImages.icFacebook,),
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () {},
          child: const SmartImage(path : AppImages.icGoogle),
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () {},
          child: const SmartImage(path:AppImages.icZoho),
        ),
      ],
    );
  }

  Widget buildRichText() {
    return SmartRichText(
      spans: [
        SmartTextSpan(text: APPStrings.dontHaveAccount.tr),
        SmartTextSpan(
          text: APPStrings.register.tr,
          onTap: () {},
        )
      ],
    );
  }
}
