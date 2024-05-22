import 'package:kgk/kgk.dart';
import 'package:kgk/modules/forgot_password/bloc/forgot_password_bloc.dart';

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
      floatingActionButton:
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordInitial) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: PrimaryButton(
                onClick: () {
                  context
                      .read<ForgotPasswordBloc>()
                      .add(const ForgotPasswordSubmitEvent());
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
    );
  }

  Widget buildLoadingView() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildSuccessView(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SmartText(
            APPStrings.forgotPassword.tr.interpolate(['']),
            style: style.titleTextStyle,
          ),
          const SizedBox(height: 24),
          //  install the buildTools for this version, please download it with SDKManager as hint.
          // SmartRichText(
          //   textSpans: [
          //     TextSpan(
          //       text: 'Email has been sent successfully to your email address ',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     TextSpan(
          //       text: 'someone@email.com',
          //       style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          //       recognizer: TapGestureRecognizer()
          //         ..onTap = () {
          //           // Handle email tap
          //         },
          //     ),
          //     TextSpan(
          //       text: '. Please use that link to change your password.',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ],
          //   padding: EdgeInsets.all(16.0),
          //   textAlign: TextAlign.center,
          // ),

          // SmartRichText(
          //     text: APPStrings.emailHasBeenSendSuccessfully.tr.interpolate(['patel@kgk.com']),
          //     subText:
          //         APPStrings.emailHasBeenSendSuccessfully.tr.replaceAll(APPStrings.emailHasBeenSendSuccessfully.tr, "@@@@@")),
        ],
      ),
    );
  }
}
