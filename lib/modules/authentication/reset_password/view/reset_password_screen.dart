import 'package:kgk/kgk.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        appBarHeight: 52.h,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      body: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SmartText(
                            APPStrings.resetPassword.tr,
                            style: style.titleTextStyle,
                          ),
                          SmartText(
                            APPStrings.resetPasswordDescription.tr,
                            style: style.subTitleStyle,
                          ),
                          SizedBox(height: 32.h),
                          SmartTextField(
                            controller: resetPasswordBloc.newPasswordController,
                            labelText: APPStrings.newPassword.tr,
                            hintText: APPStrings.newPassword.tr,
                            lableStyle: style.labelStyle,
                            obscured: true,
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          SizedBox(height: 16.h),
                          SmartTextField(
                            controller: resetPasswordBloc.confirmPasswordController,
                            labelText: APPStrings.confirmPassword.tr,
                            hintText: APPStrings.confirmPassword.tr,
                            lableStyle: style.labelStyle,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscured: true,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const Spacer(),
                          if (state is ResetPasswordInitial)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: SmartButton(
                                onTap: () {
                                  context.pushNamed(AppRoutes.emailSentPage);
                                },
                                title: APPStrings.confirmAndLogIn.tr,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
