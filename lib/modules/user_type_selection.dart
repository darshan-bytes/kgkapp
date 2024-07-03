import 'package:kgk/kgk.dart';

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(),
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
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.stonesLandingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.landingForDiamonds});
                },
                title: 'Diamond Landing Page',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.stonesLandingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.landingForGemstones});
                },
                title: 'Gemstone Landing Page',
              ),
              const SizedBox(height: 20),
              SmartButton(
                onTap: () {
                  context.pushNamed(AppRoutes.stonesLandingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.landingForJewellery});
                },
                title: 'Jewellery Landing Page',
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
