import 'package:kgk/kgk.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInStyle = AppTheme.of(context).signInScreenStyle;
    final style = AppTheme.of(context).forgotPasswordScreenStyle;
    final List<String> parts = APPStrings.emailHasBeenSendSuccessfully.tr.split('{#}');
    return Scaffold(
      appBar: CustomAppBar(
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
        },
      ),
    );
  }
}
