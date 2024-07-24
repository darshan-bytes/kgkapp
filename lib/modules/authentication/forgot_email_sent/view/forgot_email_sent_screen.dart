import 'package:kgk/kgk.dart';

class ForgotEmailSentScreen extends StatelessWidget {
  const ForgotEmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInStyle = AppTheme.of(context).signInScreenStyle;
    final style = AppTheme.of(context).forgotPasswordScreenStyle;
    final List<String> parts = APPStrings.emailHasBeenSendSuccessfully.tr.split('{#}');
    final ForgotPasswordBloc forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52.h,
        isBorder: false,
        backgroundColor: signInStyle.backgroundColor,
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return SmartSingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
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
                  SizedBox(height: 24.h),
                  RichText(
                    text: TextSpan(
                      text: parts[0],
                      style: style.didNotGetEmailTextStyle.copyWith(height: 1.5.h),
                      children: [
                        TextSpan(
                          text: forgotPasswordBloc.emailController.text,
                          style: style.richSubTextStyle,
                        ),
                        TextSpan(text: parts[1], style: style.didNotGetEmailTextStyle),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                  SmartText(
                    APPStrings.didNotReceivedEmail.tr,
                    style: style.didNotGetEmailTextStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        forgotPasswordBloc.add(ForgotPasswordSubmitEvent(context: context, isFromResend: true));
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
