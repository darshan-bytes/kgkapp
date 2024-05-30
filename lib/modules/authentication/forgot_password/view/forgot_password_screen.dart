import 'package:kgk/kgk.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
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
          title: APPStrings.submit.tr,
        ),
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return SafeArea(
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
                            APPStrings.forgotPassword.tr.interpolate(['']),
                            style: style.titleTextStyle,
                          ),
                          SmartText(
                            APPStrings.forgotPasswordDescription.tr,
                            style: style.subTitleStyle,
                          ),
                          const SizedBox(height: 32),
                          SmartTextField(
                            controller: forgotPasswordBloc.emailController,
                            labelText: APPStrings.email.tr,
                            hintText: APPStrings.email.tr,
                            lableStyle: style.labelStyle,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
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
          );
        },
      ),
    );
  }
}
