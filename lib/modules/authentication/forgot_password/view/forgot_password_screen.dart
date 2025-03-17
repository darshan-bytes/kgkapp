import 'package:kgk/kgk.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final ForgotPasswordBloc bloc = BlocProvider.of<ForgotPasswordBloc>(context);
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
              margin: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
              onTap: () {
                bloc.add(ForgotPasswordSubmitEvent(context: context));
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
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
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
                            controller: bloc.emailController,
                            labelText: APPStrings.email.tr,
                            hintText: APPStrings.hintEmail.tr,
                            labelStyle: style.labelStyle,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (p0) => bloc.add(ForgotPasswordSubmitEvent(context: context)),
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
