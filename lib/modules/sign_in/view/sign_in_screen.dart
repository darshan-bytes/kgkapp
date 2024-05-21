import 'package:kgk/kgk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 52,
        isBorder: false,
        backgroundColor: style.backgroundColor,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmartText(
                  APPStrings.login.tr,
                  style: style.titleTextStyle,
                ),
                // SmartText(),

                // SmartTextField(
                //   isRequired: true,
                //   obscured: true,
                //   lableText: APPStrings.email.tr,
                //   hintText: APPStrings.email.tr,
                //   onEditingComplete: () {
                //     FocusScope.of(context).nextFocus();
                //   },
                // ),
                // const SizedBox(height: 16),
                // SmartCheckbox(
                //   value: appBloc.switchValue,
                //   onChanged: (value) {
                //     Utils.showMessage("Testing message");
                //     appBloc.add(ChangeThemeEvent(!appBloc.switchValue ? 'dark' : 'light'));
                //   },
                //   label: APPStrings.pleaseEnterEmailPass.tr,
                // ),
                // const SizedBox(height: 16),
                // Text(APPStrings.pleaseEnterEmailPass.tr),
                // CupertinoSwitch(
                //   value: appBloc.switchValue,
                //   onChanged: (value) {
                //     Utils.showMessage("Testing message");
                //     appBloc.add(ChangeThemeEvent(!appBloc.switchValue ? 'dark' : 'light'));
                //     // signInBloc.add(ChangeSwitchValueEvent(switchValue: value));
                //   },
                // ),
                // const SizedBox(height: 16),
                // PrimaryButton(
                //   isEnabled: false,
                //   onClick: () {
                //     Utils.showMessage("Testing message");
                //   },
                //   title: APPStrings.signIn.tr,
                // ),
              ],
            ),
          )),
    );
  }
}
