import 'package:kgk/kgk.dart';

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(isBack: false),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmartButton(
                onTap: () {
                  handleUserTypeSelection(UserType.b2cUser, context);
                },
                title: 'B2C User',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  handleUserTypeSelection(UserType.b2bUser, context);
                },
                title: 'B2B User',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleUserTypeSelection(UserType userType, BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(SetUserTypeEvent(userType));
    context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
  }
}
