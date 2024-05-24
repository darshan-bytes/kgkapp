import 'package:kgk/kgk.dart';

class ForgotEmailSentScreen extends StatelessWidget {
  const ForgotEmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInStyle = AppTheme.of(context).signInScreenStyle;
    final style = AppTheme.of(context).forgotPasswordScreenStyle;
    final List<String> parts = APPStrings.emailHasBeenSendSuccessfully.tr.split('{#}');
    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52,
        isBorder: false,
        backgroundColor: signInStyle.backgroundColor,
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
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
                  RichText(
                    text: TextSpan(
                      text: parts[0],
                      style: style.didNotGetEmailTextStyle.copyWith(height: 1.5),
                      children: [
                        TextSpan(
                          text: "your_email@example.com", // Placeholder text
                          style: style.richSubTextStyle,
                        ),
                        TextSpan(text: parts[1], style: style.didNotGetEmailTextStyle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  SmartText(
                    APPStrings.didNotReceivedEmail.tr,
                    style: style.didNotGetEmailTextStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.resetPasswordPage);
                      },
                      child: SmartText(
                        APPStrings.resend.tr,
                        style: style.resendTextStyle,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
