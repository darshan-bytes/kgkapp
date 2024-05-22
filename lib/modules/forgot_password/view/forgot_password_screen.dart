import 'package:kgk/kgk.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
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
                  Navigator.pushNamed(context, AppRoutes.emailSentPage);
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
                    controller: forgotPasswordBloc.emailController,
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
        },
      ),
    );
  }
}
