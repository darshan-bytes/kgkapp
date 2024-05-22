import 'package:kgk/kgk.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 52,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          if (state is ResetPasswordInitial) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: PrimaryButton(
                onClick: () {},
                title: APPStrings.confirmAndLogIn.tr,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          final style = AppTheme.of(context).signInScreenStyle;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmartText(
                    APPStrings.resetPassword.tr,
                    style: style.titleTextStyle,
                  ),
                  SmartText(
                    APPStrings.resetPasswordDescription.tr,
                    style: style.subTitleStyle,
                  ),
                  const SizedBox(height: 32),
                  SmartTextField(
                    controller: resetPasswordBloc.newPasswordController,
                    lableText: APPStrings.newPassword.tr,
                    lableStyle: style.lableStyle,
                    obscured: true,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  SmartTextField(
                    controller: resetPasswordBloc.confirmPasswordController,
                    lableText: APPStrings.confirmPassword.tr,
                    lableStyle: style.lableStyle,
                    obscured: true,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
