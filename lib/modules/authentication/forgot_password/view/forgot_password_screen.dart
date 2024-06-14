import 'package:kgk/kgk.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52.h,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartButton(
              margin: EdgeInsets.symmetric(horizontal: 17.w),
              onTap: () {
                context.pushNamed(AppRoutes.emailSentPage);
              },
              title: APPStrings.submit.tr,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SmartSingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
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
                          SizedBox(height: 32.h),
                          SmartTextField(
                            controller: forgotPasswordBloc.emailController,
                            labelText: APPStrings.email.tr,
                            hintText: APPStrings.email.tr,
                            labelStyle: style.labelStyle,
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
