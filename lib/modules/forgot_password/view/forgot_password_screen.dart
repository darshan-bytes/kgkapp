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
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
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
                              labelText: APPStrings.email.tr,
                              hintText: APPStrings.email.tr,
                              lableStyle: style.labelStyle,
                              keyboardType: TextInputType.emailAddress,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            const Spacer(),
                            if (state is ForgotPasswordInitial)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: SmartButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.emailSentPage);
                                  },
                                  title: APPStrings.submit.tr,
                                ),
                              ),
                          ],
                        ),
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
