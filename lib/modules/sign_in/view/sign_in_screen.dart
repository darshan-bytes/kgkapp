import 'package:flutter/cupertino.dart';
import 'package:kgk/kgk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    signInBloc.context = context;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, appState) {
            return BlocBuilder<SignInBloc, SignInState>(
              buildWhen: (context, state) => state is ChangeValueState,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmartTextField(
                        isRequired: true,
                        obscured: true,
                        lableText: APPStrings.email.tr,
                        hintText: APPStrings.email.tr,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      const SizedBox(height: 16),
                      SmartCheckbox(
                        value: appBloc.switchValue,
                        onChanged: (value) {
                          Utils.showMessage("Testing message");
                          appBloc.add(ChangeThemeEvent(!appBloc.switchValue ? 'dark' : 'light'));
                        },
                        label: APPStrings.pleaseEnterEmailPass.tr,
                      ),
                      const SizedBox(height: 16),
                      Text(APPStrings.pleaseEnterEmailPass.tr),
                      CupertinoSwitch(
                        value: appBloc.switchValue,
                        onChanged: (value) {
                          Utils.showMessage("Testing message");
                          appBloc.add(ChangeThemeEvent(!appBloc.switchValue ? 'dark' : 'light'));
                          // signInBloc.add(ChangeSwitchValueEvent(switchValue: value));
                        },
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        onClick: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboardPage, (route) => false);
                        },
                        title: APPStrings.signIn.tr,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
