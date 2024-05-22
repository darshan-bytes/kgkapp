import 'package:kgk/kgk.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
      floatingActionButton: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordInitial) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: PrimaryButton(
                onClick: () {
                  context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitEvent());
                },
                title: APPStrings.submit.tr,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordInitial) {
            return buildInitialView(context);
          } else if (state is ForgotPasswordLoading) {
            return buildLoadingView();
          } else if (state is ForgotPasswordSent) {
            return buildSuccessView(context);
          } else if (state is ForgotPasswordError) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInitialView(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final TextEditingController emailController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SmartText(
              APPStrings.forgotPassword.tr.interpolate(['']),
              style: style.titleTextStyle,
            ),
            SmartText(
              APPStrings.forgotPasswordDescription.tr,
              style: style.subTitleStyle,
            ),
            const SizedBox(height: 32),
            SmartTextField(
              controller: emailController,
              lableText: APPStrings.email.tr,
              hintText: APPStrings.email.tr,
              lableStyle: style.lableStyle,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildSuccessView(BuildContext context) {
    final style = AppTheme.of(context).forgotPasswordScreenStyle;
    final signInStyle = AppTheme.of(context).signInScreenStyle;
    final List<String> parts = APPStrings.emailHasBeenSendSuccessfully.tr.split('{#}');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: SmartText(
                APPStrings.forgotPassword.tr.interpolate(['']),
                style: signInStyle.titleTextStyle,
              ),
            ),
            const SizedBox(height: 24),
            SmartRichText(
              spans: [
                SmartTextSpan(text: parts[0]), // Before placeholder
                SmartTextSpan(
                  text: "your_email@example.com", // Placeholder text
                  style: style.richSubTextStyle,
                ),
                SmartTextSpan(text: parts[1]), // After placeholder
              ],
            ),
            const SizedBox(height: 48),
            SmartText(
              APPStrings.didNotReceivedEmail.tr,
              style: style.didNotGetEmailTextStyle,
            ),
            const SizedBox(height: 8),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.resetPasswordPage);
                },
                child: SmartText(
                  APPStrings.resend.tr,
                  style: style.resendTextStyle,
                )),
          ],
        ),
      ),
    );
  }
}
