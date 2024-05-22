import 'package:kgk/kgk.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenStyle style = AppTheme.of(context).splashScreenStyle;
    return Scaffold(
      body: BlocProvider<SplashBloc>(
        lazy: false,
        create: (context) => SplashBloc()..add(LoadSplashEvent(context: context)),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const SmartImage(path: AppImages.icSplashBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(
                      APPStrings.skip.tr,
                      style: style.skipTextStyle,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signInPage);
                      },
                      textAlign: TextAlign.end,
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          AppImages.icSplashLogo,
                          height: 112,
                          width: 112,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            onClick: () {
                              Navigator.pushNamed(context, AppRoutes.diamondDetailPage);
                            },
                            activeBackgroundColor: style.activeBackgroundColor,
                            titleStyle: style.titleStyle,
                            title: APPStrings.login.tr,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PrimaryButton(
                            onClick: () {},
                            activeBackgroundColor: style.activeBackgroundColor,
                            titleStyle: style.titleStyle,
                            title: APPStrings.register.tr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
