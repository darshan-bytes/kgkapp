import 'package:flutter/cupertino.dart';
import 'package:kgk/kgk.dart';
import 'package:kgk/utils/utils.dart';

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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(APPStrings.pleaseEnterEmailPass.tr),
                    CupertinoSwitch(
                      value: appBloc.switchValue,
                      onChanged: (value) {
                        Utils.showMessage("Testing message");
                        appBloc.add(ChangeThemeEvent(!appBloc.switchValue ? 'dark' : 'light'));
                        // signInBloc.add(ChangeSwitchValueEvent(switchValue: value));
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
